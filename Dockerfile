# FROM artifactory-dockerhub.cloud.capitalone.com/alpine:3.17
FROM alpine:3.17 

RUN apk update && \
    apk add --no-cache py-pip gcc musl-dev linux-headers libffi-dev python3-dev && \
    pip install --upgrade pip && \
    pip install --ignore-installed pipenv gunicorn flask python-json-logger requests exceptiongroup && \
    pip install "sealights-python-agent==2.2.4"

    
WORKDIR /app

# COPY Pipfile Pipfile.lock /app/

COPY . /app

EXPOSE 8080

# # For local testing
ENV SL_LAB_ID=tryout-python-gunicorn-local
ENV SL_DEBUG=true

# https://flask.palletsprojects.com/en/2.1.x/deploying/gunicorn/#running
CMD ["gunicorn",  "-b", "0.0.0.0:8080", "src.app:app"]