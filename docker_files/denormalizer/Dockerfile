# miniconda3 as base image
FROM python:3.9-slim

# RUN apt-get update && \
#     apt-get install -y build-essential && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# Set a working directory
WORKDIR /itn

# Copy the source code into the container
COPY . .

# Set up the environment and dependencies
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install fairseq
RUN pip install subword-nmt
RUN pip install flask
RUN pip cache purge

# Command to run on container start
CMD ["python", "flask_app.py"]