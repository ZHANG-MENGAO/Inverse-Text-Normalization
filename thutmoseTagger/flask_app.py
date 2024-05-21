from flask import Flask, render_template, url_for, request
import os

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
    
def inference(input:str) -> str:
    s = spoken_preprocessing(input)  # this is the same input transformation as in corpus preparation
    print(s)
    start = time.time()
    outputs = model._infer([s])
    output = outputs[0].split("\t")[0]
    print(output)
    print(time.time()-start)
    return output
    

@app.route("/", methods=["POST", "GET"])
def index():
    user_input = None
    output = None
    if request.method=="POST":
        user_input = request.form['content']
        # input model, get output
        output = inference(user_input)
    
    # pass output into this
    return render_template('index.html', input=user_input, output=output)


if __name__ == "__main__":
    app.run()


