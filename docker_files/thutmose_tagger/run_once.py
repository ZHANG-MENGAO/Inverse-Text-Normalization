import sys
sys.path.append("./NeMo/")

from NeMo.examples.nlp.text_normalization_as_tagging.helpers import ITN_MODEL, instantiate_model_and_trainer
from omegaconf import DictConfig, OmegaConf

from nemo.collections.nlp.data.text_normalization_as_tagging.utils import spoken_preprocessing
from nemo.core.config import hydra_runner
from nemo.utils import logging


@hydra_runner(config_path="conf", config_name="thutmose_tagger_itn_config")
def main(cfg: DictConfig) -> None:
    logging.debug(f'Config Params: {OmegaConf.to_yaml(cfg)}')

    _, model = instantiate_model_and_trainer(cfg, ITN_MODEL, False)

    s = spoken_preprocessing("One two three")  # this is the same input transformation as in corpus preparation
    outputs = model._infer([s])

if __name__ == "__main__":
    main()