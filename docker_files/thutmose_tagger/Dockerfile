# miniconda3 as base image
FROM python:3.8-slim

# RUN apt-get update && \
#     apt-get install -y build-essential && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# Set a working directory
WORKDIR /itn

# Copy the source code into the container
COPY . .

# Set up the environment and dependencies
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip3 install -r ./NeMo/requirements/requirements.txt
RUN pip3 cache purge
RUN python run_once.py

# Command to run on container start
CMD ["python", "flask_app.py"]