# Tiny CoreNLP Docker

A minimal Docker image for running [Stanford CoreNLP Server](https://stanfordnlp.github.io/CoreNLP/corenlp-server.html). The Dockerfile was based on a peek at some of the CoreNLP server Docker images listed [here](https://stanfordnlp.github.io/CoreNLP/other-languages.html#docker) and especially [CoreNLP Complete Dockerfile](https://github.com/grahamimac/corenlp-complete-docker) and [NLPBox's stanford-corenlp-docker](https://github.com/NLPbox/stanford-corenlp-docker). The NLPBox docker gets you the latest CoreNLP version, which would be better for most purposes. However, the image that this Dockerfile creates is more compact than these other options and allows you to specify the CoreNLP server RAM usage and threads at runtime.

## Build the Dockerfile

`docker build https://github.com/polsci/tiny-corenlp-docker.git -t tiny-corenlp:latest`

## Run

`docker run --rm -p 9000:9000 tiny-corenlp`

Note: add -itd if you want it to run in the background.
Remember: --rm tidies up afterwards.

## More memory, more threads, more time?

By default the server will start with up to 4GB RAM usage, 4 threads, and timeout of 15000. To change these values (in this case to 8GB RAM, 8 threads, 30000 timeout)...

`docker run -e JAVA_XMX=8g -e CORENLP_THREADS=8 -e CORENLP_TIMEOUT=30000 --rm -p 9000:9000 tiny-corenlp`

## Testing

Basic test:

`wget --post-data 'Cow said "moo".' 'localhost:9000/?properties={"annotators":"tokenize,ssplit,pos","outputFormat":"json"}' -O -`

More annotators (it takes a while for the server to add each annotator, so be patient if including all these):

`wget --post-data 'Cow said "moo".' 'localhost:9000/?properties={"annotators":"tokenize,ssplit,pos,lemma,ner,depparse,coref,quote","outputFormat":"json"}' -O -`
