FROM alpine:latest

RUN apk update && \
	apk add wget openjdk8-jre-base

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip; \
  unzip stanford-corenlp-full-2018-10-05.zip; \
  rm stanford-corenlp-full-2018-10-05.zip; \
  mv stanford-corenlp-full-2018-10-05 /opt/corenlp; \
  cd /opt/corenlp

ENV PORT 9000

EXPOSE 9000

WORKDIR /opt/corenlp

ENV JAVA_XMX 4g

ENV CORENLP_THREADS 4

ENV CORENLP_TIMEOUT 15000

CMD java -Xmx$JAVA_XMX -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9000 -timeout $CORENLP_TIMEOUT -threads $CORENLP_THREADS
