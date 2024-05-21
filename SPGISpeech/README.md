# Introduction
The SPGISpeech contains audio from company earning calls. It consists of pairs of audio and human-labeled transcript. The transcript is in written form (contains capitalization, punctuation and ITN instances in written form).

We first select the audios that may contain ITN instances according to the human-labeled transcript. Then we use ASR model to transcribe audios to get spoken form transcripts. Next, we apply text normalization on written-form transcript with the aid of spoken-form transcripts. 

# Directory structure
- **csv/**
    Contains the audio metadata and human labeled transcript (written form). The path to the audio is absolute path on another path, need to replace with suitable relative path

- **ITN_audio/**
    should contain the audio, omitted here to save space. Can be found at server 172.21.47.111 under user mengao001. Contact me if you are unable to access it. 

- **parallel_corpus/**
    intermediate and processed spoken-form and written-form parallel corpus
    --- **{train/val}_transcript.json**: ASR transcript
    --- **{train/val}_ref.txt**: human-labeled written-form transcript
    --- **{train/val}_input.txt**: The extracted ASR transcript, to see whether it is good enough to form the parallel_corpus. It turns out that it is not good as performing text normalization.
    --- **{train/val}_input_TN.txt**: The result of performing text normalization on ref with the aid of ASR transcript.
    --- **train_val_test/**: splited train set into train and validation set. Use validation split in original dataset as testset because the original dataset doesn't have test split. 

- **audio_based_TN.py**
    perform text normalization

- **get_transcript.py**
    transcribe the audios using an ASR model

- **prepara_data.ipynb**
    do necessary preprocessing on the corpus

- **select_ITN.ipynb**
    select the audio files that likely contains ITN instances. 

# Runing code
Need to install NeMo to use their ASR system [[NeMo](https://github.com/NVIDIA/NeMo)]

And also nemo text processing to do text normalization [[nemo-text-processing](https://github.com/NVIDIA/NeMo-text-processing)]
