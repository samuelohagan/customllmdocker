#!/bin/bash

MODEL_WEIGHTS_DIR=models/alpaca-lora-65B-GPTQ-4bit
# download

if [ ! -f "$MODEL_WEIGHTS_DIR/alpaca-lora-65B-GPTQ-4bit-128g.safetensors" ]; then
    wget -O "$MODEL_WEIGHTS_DIR/alpaca-lora-65B-GPTQ-4bit-128g.safetensors" https://huggingface.co/TheBloke/alpaca-lora-65B-GPTQ-4bit/resolve/main/alpaca-lora-65B-GPTQ-4bit-128g.safetensors
fi

# Start the server
python3 server.py --wbits 4 --model_type LLaMa --groupsize 128 --listen --listen-port 5000
