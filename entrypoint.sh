#!/bin/bash

download_and_run() {
    local model_path="$1"
    local model_url="$2"
    local model_args="$3"

    if [ ! -f "$model_path" ]; then
        wget -O "$model_path" "$model_url"
    fi

	if [ "$CHAT_MODE" == "1" ]; then
	    python3 server.py $model_args --chat
	else
	    python3 server.py $model_args
	fi
}

case "$MODEL_TYPE" in
    "gpt13")
        download_and_run "models/gpt4-x-alpaca-13b-native-4bit-128g/gpt-x-alpaca-13b-native-4bit-128g-cuda.pt" \
            "https://huggingface.co/anon8231489123/gpt4-x-alpaca-13b-native-4bit-128g/resolve/main/gpt-x-alpaca-13b-native-4bit-128g-cuda.pt" \
            "--model gpt4-x-alpaca-13b-native-4bit-128g --wbits 4 --model_type LLaMa --listen --listen-port 5000"
        ;;
    "gpt30")
        download_and_run "models/alpaca-30b-lora-int4/alpaca-30b-4bit.safetensors" \
            "https://huggingface.co/elinas/alpaca-30b-lora-int4/resolve/main/alpaca-30b-4bit.safetensors" \
            "--model alpaca-30b-lora-int4 --wbits 4 --model_type LLaMa --listen --listen-port 5000"
        ;;
    "gpt30u")
        download_and_run "models/GPT4-X-Alpaca-30B-4bit/gpt4-x-alpaca-30b-4bit.safetensors" \
            "https://huggingface.co/MetaIX/GPT4-X-Alpaca-30B-4bit/resolve/main/gpt4-x-alpaca-30b-4bit.safetensors" \
            "--model GPT4-X-Alpaca-30B-4bit --wbits 4 --model_type LLaMa --listen --listen-port 5000"
        ;;
    "gpt30oa")
        download_and_run "models/OpenAssistant-SFT-7-Llama-30B-GPTQ/OpenAssistant-30B-epoch7-GPTQ-4bit-1024g.compat.no-act-order.safetensors" \
            "https://huggingface.co/TheBloke/OpenAssistant-SFT-7-Llama-30B-GPTQ/resolve/main/OpenAssistant-30B-epoch7-GPTQ-4bit-1024g.compat.no-act-order.safetensors" \
            "--model OpenAssistant-SFT-7-Llama-30B-GPTQ --wbits 4 --groupsize 1024 --model_type LLaMa --listen --listen-port 5000"
        ;;
    "gpt65")
        download_and_run "models/alpaca-lora-65B-GPTQ-4bit/alpaca-lora-65B-GPTQ-4bit-128g.safetensors" \
            "https://huggingface.co/TheBloke/alpaca-lora-65B-GPTQ-4bit/resolve/main/alpaca-lora-65B-GPTQ-4bit-128g.safetensors" \
            "--model alpaca-lora-65B-GPTQ-4bit --wbits 4 --groupsize 128 --model_type LLaMa --listen --listen-port 5000"
        ;;
    *)
        echo "Unknown file type specified in MODEL_TYPE environment variable"
        exit 1
        ;;
esac

