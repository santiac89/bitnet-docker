FROM python:3.12.0
RUN apt update && apt -y install cmake clang git

RUN git clone --recursive https://github.com/microsoft/BitNet.git

WORKDIR /BitNet

RUN pip install --no-cache-dir -r requirements.txt

RUN huggingface-cli download microsoft/BitNet-b1.58-2B-4T-gguf --local-dir models/BitNet-b1.58-2B-4T
RUN python setup_env.py -md models/BitNet-b1.58-2B-4T -q i2_s

CMD ["python3", "run_inference_server.py", "-m", "models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf", "--host", "0.0.0.0", "--port", "5000"]