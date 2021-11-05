FROM python:3.9-slim

# install java
RUN apt-get update && apt-get install -y openjdk-11-jdk

# set softlink to python
RUN ln -s /usr/bin/python3 /usr/bin/python

# install the notebook package
RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache notebook jupyterlab

# install other Python dependencies
RUN pip3 install numpy nltk pandas matplotlib nbinteract pyspark

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV JAVA_HOME /usr/bin/java
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
