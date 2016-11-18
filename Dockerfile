FROM ubuntu:16.04

MAINTAINER Michael Wright <mkwright@gmail.com> 

RUN apt-get update && \
    apt-get install -y curl build-essential libpng12-dev libffi-dev  && \
    apt-get clean && \
    rm -rf /var/tmp /tmp /var/lib/apt/lists/*

RUN curl -sSL -o installer.sh https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    bash /installer.sh -b -f && \
    rm /installer.sh

ENV PATH "$PATH:/root/anaconda3/bin"
ADD startup /startup

EXPOSE 8888 6006
VOLUME /notebooks
WORKDIR "/notebooks"

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]

ADD environment.yml /environment.yml
RUN conda env create -f /environment.yml
ENV CONDA_ENV default

# Install the spacy data (around 1GB of data)
RUN /startup "python -m spacy.de.download all"
RUN /startup "python -m spacy.en.download all"

