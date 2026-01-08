# Extrapolating METR's Findings

This is a small project to extend the time horizon research conducted by METR and play around with the data.



## Installation

### Option 1: Dev Container (Original Analysis)

This project contains a dev container, which can be used for reproducing the original analysis. Alternatively, you can view the [.devcontainer/Dockerfile](Dockerfile) to see which dependencies need to be installed.

After installing those dependencies, the figures can be recreated by running:

```
poetry install
poetry run dvc repro
```

### Option 2: Conda Environment (Extended Analysis)

For extended analysis, you can use the provided conda environment file:

```
conda env create -f environment.yml
conda activate metr-time-horizon
```

An example of additional analysis which can be performed after completing these steps can be found at [example_analysis.ipynb](example_analysis.ipynb)