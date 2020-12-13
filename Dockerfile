FROM rackspacedot/python37:30

RUN git clone https://github.com/deepmind/deepmind-research.git && \
    cd deepmind-research/alphafold_casp13 && \
    wget http://bit.ly/alphafold-casp13-weights -O model.zip && \
    unzip model.zip && \
    rm -f model.zip && \
    mkdir -p /input &&  mkdir -p /output && \
    sed -i "s!TARGET_PATH=.*!TARGET_PATH=\"\/input\"!g" run_eval.sh && \
    sed -i "s!OUTPUT_DIR=.*!OUTPUT_DIR=\"/output\"!g" run_eval.sh && \
    sed -i "s!TARGET=.*!TARGET=\"\${NAME:-INPUT}\"!g" run_eval.sh && \
    sed -i "s!python3 -m venv alphafold_venv!!g" run_eval.sh && \
    sed -i "s!source alphafold_venv/bin/activate!!g" run_eval.sh && \
    sed -i "s!pip install .*!!g" run_eval.sh && \
    cat run_eval.sh && \
    cd .. && pwd && \
    pip install wheel && \
    pip install -r alphafold_casp13/requirements.txt

WORKDIR /deepmind-research

ENTRYPOINT [ "alphafold_casp13/run_eval.sh" ]

