FROM ubuntu:22.04

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y \
  vim git tmux cmake wget curl python3 python3-pip \
  clang libstdc++-12-dev ninja-build pkg-config

RUN pip3 install --no-cache --upgrade pip setuptools
RUN --mount=type=cache,target=/root/.cache/pip pip3 install \
  meson ninja

RUN git clone https://github.com/Tilps/lc0 /root/lc0
WORKDIR /root/lc0
RUN git checkout rescore_tb
RUN CC=clang CXX=clang++ ./build.sh
RUN cp build/release/rescorer /usr/local/bin

RUN git clone https://github.com/official-stockfish/stockfish /root/stockfish
WORKDIR /root/stockfish
RUN git checkout tools
WORKDIR /root/stockfish/src
RUN make -j profile-build ARCH=x86-64-bmi2
RUN cp stockfish /usr/local/bin

WORKDIR /root
COPY .bash_profile .
RUN echo 'source .bash_profile' >> .bashrc

COPY process_tar_files.sh rescore_tar_files.sh filter_* convert_to_binpack.sh merge_binpacks.sh .
RUN chmod +x *.sh

CMD sleep infinity
