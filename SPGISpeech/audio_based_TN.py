from nemo_text_processing.text_normalization.normalize_with_audio import NormalizerWithAudio
from tqdm import tqdm
from multiprocessing import Pool

normalizer = NormalizerWithAudio(
        lang="en",
        input_case="cased",
        overwrite_cache=False,
        cache_dir="TN_cache",
    )

def process_line(line_tuple):
    written, asr = line_tuple
    written = written.strip().lower()
    asr = asr.strip()
    return normalizer.normalize(written, -1, True, False, asr)

train_written = "parallel_corpus/train_ref.txt"
val_written = "parallel_corpus/val_ref.txt"
train_ASR = "parallel_corpus/train_input.txt"
val_ASR = "parallel_corpus/val_input.txt"

with open(train_written, "r") as w_file, open(train_ASR, "r") as asr_file:
    w_lines = w_file.readlines()
    asr_lines = asr_file.readlines()
    line_tuples = [(written, asr) for written, asr in zip(w_lines, asr_lines)]

    num_processes = 64

    with Pool(num_processes) as pool:
        result_list = list(tqdm(pool.imap(process_line, line_tuples), total=len(line_tuples)))

with open("./parallel_corpus/train_input_TN.txt", "w") as file:
    for sen in result_list:
        file.write(sen+"\n")