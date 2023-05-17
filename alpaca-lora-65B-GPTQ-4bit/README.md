---
license: other
inference: false
---

# Alpaca LoRA 65B GPTQ 4bit

This is a [GPTQ-for-LLaMa](https://github.com/qwopqwop200/GPTQ-for-LLaMa) 4bit quantisation of [changsung's alpaca-lora-65B](https://huggingface.co/chansung/alpaca-lora-65b)

I also have 4bit and 2bit GGML files for cPU inference available here: [TheBloke/alpaca-lora-65B-GGML](https://huggingface.co/TheBloke/alpaca-lora-65B-GGML).

## These files need a lot of VRAM!

I believe they will work on 2 x 24GB cards, and I hope that at least the 1024g file will work on an A100 40GB.

I can't guarantee that the two 128g files will work in only 40GB of VRAM.

I haven't specifically tested VRAM requirements yet but will aim to do so at some point. If you have any experiences to share, please do so in the comments.

If you want to try CPU inference instead, check out my GGML repo: [TheBloke/alpaca-lora-65B-GGML](https://huggingface.co/TheBloke/alpaca-lora-65B-GGML).

## GIBBERISH OUTPUT IN `text-generation-webui`?

Please read the Provided Files section below. You should use `alpaca-lora-65B-GPTQ-4bit-128g.no-act-order.safetensors` unless you are able to use the latest Triton branch of GPTQ-for-LLaMa.

## Provided files

Three files are provided. **The second and third files will not work unless you use a recent version of the Triton branch of GPTQ-for-LLaMa**

Specifically, the last two files use `--act-order` for maximum quantisation quality and will not work with oobabooga's fork of GPTQ-for-LLaMa. Therefore at this time it will also not work with the CUDA branch of GPTQ-for-LLaMa, or `text-generation-webui` one-click installers.

Unless you are able to use the latest Triton GPTQ-for-LLaMa code, please use `medalpaca-13B-GPTQ-4bit-128g.no-act-order.safetensors`
 
* `alpaca-lora-65B-GPTQ-4bit-128g.no-act-order.safetensors`
  * Works with all versions of GPTQ-for-LLaMa code, both Triton and CUDA branches
  * Works with text-generation-webui one-click-installers
  * Works on Windows
  * Will require ~40GB of VRAM, meaning you'll need an A100 or 2 x 24GB cards.
  * I haven't yet tested how much VRAM is required exactly so it's possible it won't run on an A100 40GB
  * Parameters: Groupsize = 128g. No act-order.
  * Command used to create the GPTQ:
    ```
    CUDA_VISIBLE_DEVICES=0 python3 llama.py alpaca-lora-65B-HF c4 --wbits 4 --true-sequential --groupsize 128 --save_safetensors alpaca-lora-65B-GPTQ-4bit-128g.no-act-order.safetensors
    ```
* `alpaca-lora-65B-GPTQ-4bit-128g.safetensors`
  * Only works with the latest Triton branch of GPTQ-for-LLaMa
  * **Does not** work with text-generation-webui one-click-installers
  * **Does not** work on Windows
  * Will require 40+GB of VRAM, meaning you'll need an A100 or 2 x 24GB cards.
  * I haven't yet tested how much VRAM is required exactly so it's possible it won't run on an A100 40GB
  * Parameters: Groupsize = 128g. act-order.
  * Offers highest quality quantisation, but requires recent Triton GPTQ-for-LLaMa code and more VRAM
  * Command used to create the GPTQ:
    ```
    CUDA_VISIBLE_DEVICES=0 python3 llama.py alpaca-lora-65B-HF c4 --wbits 4 --true-sequential --act-order --groupsize 128 --save_safetensors alpaca-lora-65B-GPTQ-4bit-128g.safetensors
    ```
* `alpaca-lora-65B-GPTQ-4bit-1024g.safetensors`
  * Only works with the latest Triton branch of GPTQ-for-LLaMa
  * **Does not** work with text-generation-webui one-click-installers
  * **Does not** work on Windows
  * Should require less VRAM than the 128g file, so hopefully it will run in an A100 40GB
  * I haven't yet tested how much VRAM is required exactly
  * Parameters: Groupsize = 1024g. act-order.
  * Offers the benefits of act-order, but at a higher groupsize to reduce VRAM requirements
  * Command used to create the GPTQ:
    ```
    CUDA_VISIBLE_DEVICES=0 python3 llama.py alpaca-lora-65B-HF c4 --wbits 4 --true-sequential --act-order --groupsize 1024 --save_safetensors alpaca-lora-65B-GPTQ-4bit-1024g.safetensors
    ```

## How to run in `text-generation-webui`

File `alpaca-lora-65B-GPTQ-4bit-128g.no-act-order.safetensors` can be loaded the same as any other GPTQ file, without requiring any updates to [oobaboogas text-generation-webui](https://github.com/oobabooga/text-generation-webui).

[Instructions on using GPTQ 4bit files in text-generation-webui are here](https://github.com/oobabooga/text-generation-webui/wiki/GPTQ-models-\(4-bit-mode\)).

The other two `safetensors` model files were created using `--act-order` to give the maximum possible quantisation quality, but this means it requires that the latest Triton GPTQ-for-LLaMa is used inside the UI.

If you want to use the act-order `safetensors` files and need to update the Triton branch of GPTQ-for-LLaMa, here are the commands I used to clone the Triton branch of GPTQ-for-LLaMa, clone text-generation-webui, and install GPTQ into the UI:
```
# Clone text-generation-webui, if you don't already have it
git clone https://github.com/oobabooga/text-generation-webui
# Make a repositories directory
mkdir text-generation-webui/repositories
cd text-generation-webui/repositories
# Clone the latest GPTQ-for-LLaMa code inside text-generation-webui
git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa
```

Then install this model into `text-generation-webui/models` and launch the UI as follows:
```
cd text-generation-webui
python server.py --model alpaca-lora-65B-GPTQ-4bit --wbits 4 --groupsize 128 --model_type Llama # add any other command line args you want
```

The above commands assume you have installed all dependencies for GPTQ-for-LLaMa and text-generation-webui. Please see their respective repositories for further information.

If you can't update GPTQ-for-LLaMa to the latest Triton branch, or don't want to, you can use `alpaca-lora-65B-GPTQ-4bit-128g.no-act-order.safetensors` as mentioned above, which should work without any upgrades to text-generation-webui.

# Original model card not provided

No model card was provided in [changsung's original repository](https://huggingface.co/chansung/alpaca-lora-65b).

Based on the name, I assume this is the result of fine tuning using the original GPT 3.5 Alpaca dataset. It is unknown as to whether the original Stanford data was used, or the [cleaned tloen/alpaca-lora variant](https://github.com/tloen/alpaca-lora).