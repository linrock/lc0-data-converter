FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

ENV PATH=/usr/local/nvidia/bin:${PATH}
ENV PATH=/usr/local/cuda/bin:${PATH}
ENV LIBRARY_PATH=/usr/local/cuda/lib64:${LIBRARY_PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}

RUN apt update --fix-missing
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y \
  vim git cmake wget curl python3 python3-pip \
  clang libstdc++-12-dev ninja-build pkg-config

RUN pip3 install --no-cache --upgrade pip setuptools
RUN --mount=type=cache,target=/root/.cache/pip pip3 install \
  meson ninja

RUN git clone https://github.com/Tilps/lc0 /root/lc0
WORKDIR /root/lc0
RUN git checkout rescore_tb
RUN CC=clang CXX=clang++ ./build.sh
RUN cp build/release/rescorer /usr/local/bin

RUN git clone https://github.com/official-stockfish/Stockfish /root/Stockfish
WORKDIR /root/Stockfish
RUN git checkout tools
WORKDIR /root/Stockfish/src
RUN make -j build ARCH=x86-64
RUN cp stockfish /usr/local/bin

WORKDIR /root
COPY run_rescorer.sh .

RUN echo "alias ls='ls --color=auto -X --group-directories-first'" >> ~/.bashrc

CMD sleep infinity
