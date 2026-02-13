FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ghostscript \
        make \
        texlive-full \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

CMD ["bash"]
