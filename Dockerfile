# Use the official Python base image
FROM ubuntu:22.04

# Install git and other dependencies
RUN apt-get update && \
    apt-get install -y git wget python3 python3-pip ninja-build build-essential



RUN pip install torch torchvision torchaudio

#Copy text-generation-webui respository into container
COPY text-generation-webui /workspace/text-generation-webui
RUN pip install -r /workspace/text-generation-webui/requirements.txt

WORKDIR /workspace/text-generation-webui
# Set the working directory


#Copy GPTQ-for-LLaMarespository into container
COPY GPTQ-for-LLaMa /workspace/text-generation-webui/repositories/GPTQ-for-LLaMa
RUN pip install -r /workspace/text-generation-webui/repositories/GPTQ-for-LLaMa/requirements.txt

#Copy gpt4-x-alpaca (except for weights) into container
COPY gpt4-x-alpaca-13b-native-4bit-128g /workspace/text-generation-webui/models/gpt4-x-alpaca-13b-native-4bit-128g

COPY alpaca-lora-65B-GPTQ-4bit /workspace/text-generation-webui/models/alpaca-lora-65B-GPTQ-4bit

COPY alpaca-30b-lora-int4 /workspace/text-generation-webui/models/alpaca-30b-lora-int4

COPY GPT4-X-Alpaca-30B-4bit /workspace/text-generation-webui/models/GPT4-X-Alpaca-30B-4bit

COPY OpenAssistant-SFT-7-Llama-30B-GPTQ /workspace/text-generation-webui/models/OpenAssistant-SFT-7-Llama-30B-GPTQ

# Copy entrypoint script into the container
COPY entrypoint.sh /workspace/entrypoint.sh
RUN chmod +x /workspace/entrypoint.sh

# Copy alpaca30 script into the container
COPY alpaca30.sh /workspace/alpaca30.sh
RUN chmod +x /workspace/alpaca30.sh

# Copy alpaca65 script into the container
COPY alpaca65.sh /workspace/alpaca65.sh
RUN chmod +x /workspace/alpaca65.sh

# Copy gptx-alpaca script into the container
COPY gptxalpaca.sh /workspace/gptxalpaca.sh
RUN chmod +x /workspace/gptxalpaca.sh


ENV PYTHONPATH "${PYTHONPATH}:/workspace/text-generation-webui"

# Set the custom entrypoint script as the container's default entrypoint
ENTRYPOINT ["/workspace/entrypoint.sh"]
