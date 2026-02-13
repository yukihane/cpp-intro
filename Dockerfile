FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ghostscript \
        lmodern \
        make \
        texlive-lang-japanese \
        texlive-latex-base \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-fonts-recommended \
        texlive-plain-generic \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

CMD ["bash"]
