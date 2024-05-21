import nemo.collections.asr as nemo_asr
import json
from tqdm import tqdm

asr_model = nemo_asr.models.ASRModel.from_pretrained("nvidia/parakeet-tdt-1.1b")

with open("/home/mazhang/pt/SPGISpeech/csv/val_ITN.csv", "r") as file:
    lines = file.readlines()
    lines = [line.strip().replace("/home4/andrew219/asr_corpora/SPGISpeech/audio", "./ITN_audio") for line in lines]

transcripts = asr_model.transcribe(lines, batch_size=16)
to_save = {"lines":lines, "transcripts": transcripts}
with open("./val_transcript.json", "w") as file:
    json.dump(to_save, file, indent=4)

with open("/home/mazhang/pt/SPGISpeech/csv/train_ITN.csv", "r") as file:
    lines = file.readlines()
    lines = [line.strip().replace("/home4/andrew219/asr_corpora/SPGISpeech/audio", "./ITN_audio") for line in lines]
    lines = lines[len(lines)//2:]
    print(len(lines))

transcripts = asr_model.transcribe(lines, batch_size=16)
to_save = {"lines":lines, "transcripts": transcripts}
with open("./train_transcript_2half.json", "w") as file:
    json.dump(to_save, file, indent=4)

with open("/home/mazhang/pt/SPGISpeech/csv/train_ITN.csv", "r") as file:
    lines = file.readlines()
    lines = [line.strip().replace("/home4/andrew219/asr_corpora/SPGISpeech/audio", "./ITN_audio") for line in lines]

for line in tqdm(lines):
    try:
        with open(line, "r") as file:
            pass
    except:
        print("file didn't found:", line)