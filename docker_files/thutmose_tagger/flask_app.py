from flask import Flask, render_template, url_for, request, jsonify

import sys
sys.path.append("./NeMo/")

import time
from NeMo.examples.nlp.text_normalization_as_tagging.helpers import ITN_MODEL, instantiate_model_and_trainer
from omegaconf import DictConfig, OmegaConf

from NeMo.nemo.collections.nlp.data.text_normalization_as_tagging.utils import spoken_preprocessing
from NeMo.nemo.core.config import hydra_runner
from NeMo.nemo.utils import logging
app = Flask(__name__)

@hydra_runner(config_path="conf", config_name="thutmose_tagger_itn_config")
def load_model(cfg: DictConfig):
    print(cfg)
    logging.debug(f'Config Params: {OmegaConf.to_yaml(cfg)}')

    if cfg.pretrained_model is None:
        raise ValueError("A pre-trained model should be provided.")
    start=time.time()
    global model
    _, model = instantiate_model_and_trainer(cfg, ITN_MODEL, False)
    print("Model loading time: ", time.time()-start)

@app.before_first_request
def bootup():
    load_model()
    
def inference(input:list) -> str:
    s = [spoken_preprocessing(i) for i in input]  # this is the same input transformation as in corpus preparation
    print(s)
    start = time.time()
    outputs = model._infer(s)
    outputs = [o.split("\t")[0] for o in outputs]
    print(outputs)
    print(time.time()-start)
    return outputs
    

@app.route("/", methods=["POST", "GET"])
def index():
    user_input = None
    output = None
    if request.method=="POST":
        user_input = request.form['content']
        # input model, get output
        output = inference([user_input])[0]
    
    # pass output into this
    return render_template('index.html', input=user_input, output=output)

@app.route("/api/normalize", methods=["POST"])
def normalize_text():
    # Get data from JSON request
    data = request.get_json()
    
    # Check if 'content' key exists and its value is a list
    if not data or 'content' not in data or not isinstance(data['content'], list):
        return jsonify({'error': 'Invalid request, content must be a list'}), 400

    api_input = data['content']
    
    batch_size = 8
    batch, all_prd = [], []
    for idx, ipt in enumerate(api_input):
        batch.append(ipt.strip())
        if len(batch) == batch_size or idx == len(api_input) - 1:
            all_prd += inference(batch)
            batch = []
    
    if len(all_prd) != len(api_input):
        raise ValueError(
            "number of input lines and predictions is different: predictions="
            + str(len(all_prd))
            + "; lines="
            + str(len(api_input))
        )
    
    return jsonify({'input': api_input, 'output': all_prd})

if __name__ == "__main__":
    app.run(host="0.0.0.0")


