#!/bin/bash

MODEL_WEIGHTS_DIR=models/alpaca-30b-lora-int4
# download

if [ ! -f "$MODEL_WEIGHTS_DIR/alpaca-30b-4bit.safetensors" ]; then
    wget -O "$MODEL_WEIGHTS_DIR/alpaca-30b-4bit.safetensors" https://huggingface.co/elinas/alpaca-30b-lora-int4/resolve/main/alpaca-30b-4bit.safetensors
fi

# Start the server
python3 server.py --wbits 4 --model_type LLaMa --listen --listen-port 5000
