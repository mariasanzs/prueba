FROM rasa/rasa:latest

COPY . /app
COPY server.sh /app/server.sh

USER root
RUN pip3 install rasa[spacy]
RUN python -m spacy download es_core_news_md && python3 -m spacy validate
RUN pip3 install Flask-socketIO==4.3.1
RUN pip3 install python-engineio==3.13.2
RUN pip3 install python-socketio==4.6.0
RUN chmod -R 777 /app
USER 1001

RUN rasa train nlu

ENTRYPOINT ["/app/server.sh"]
