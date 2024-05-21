Two folders in this directory each contains the code for building docker image of a simple flask app that encapsulats ITN models for easy inference. The code in each folder are the minimum to run inference of the model. 

- denoramalizer/
encapsulates denormalizer model trained locally on the entire training split of GTN

- thutmose_tagger/
encapsulates pre-trained thutmose tagger model downloaded from cloud

Detailed instructions on how to run the published built docker image can be found [here](https://hub.docker.com/r/mario6666667/itn)