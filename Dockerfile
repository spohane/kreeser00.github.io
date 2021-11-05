FROM polochau/cse6242-2021fall:d4c6d11796ed692fa4f70407d5ff524b2b87a7fa5dd8f61cafbc98ce9deb33de
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install --no-cache-dir notebook && pip3 install --no-cache-dir jupyterhub
RUN pip3 install numpy nltk pandas matplotlib nbinteract pyspark

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

#WORKDIR /root
#EXPOSE 8888
#CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''", "--allow-root"]
