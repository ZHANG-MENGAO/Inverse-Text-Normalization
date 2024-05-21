import time
from flask import Flask, render_template, request, jsonify
from fairseq.models.transformer import TransformerModel
import denormalizer.scripts.custom_arch
app = Flask(__name__)

def load_model():
    start=time.time()
    global DENORMALIZER
    DENORMALIZER = TransformerModel.from_pretrained(
                                'denormalizer/checkpoints/denorm',
                                checkpoint_file=f'checkpoint_last.pt',
                                data_name_or_path=f'denormalizer/data-bin/denorm',
                                bpe='subword_nmt',
                                bpe_codes=f'denormalizer/data-bin/denorm/bpe_code',
                                )
    print("Model loading time: ", time.time()-start)
    
def inference(input:list) -> str:
    start = time.time()
    outputs = [DENORMALIZER.translate(string, beam=5) for string in input]
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
    with app.app_context():
        load_model()
    app.run(host="0.0.0.0")