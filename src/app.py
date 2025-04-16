import os
import time
from http import HTTPStatus
from flask import Flask, request

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    resp = {'status': 'healthy'}
    app.logger.info('Health endpoint successfully hit')
    return resp, HTTPStatus.OK

@app.route('/example', methods=['GET'])
def example():
    app.logger.info('Example endpoint successfully hit')
    resp = {'data': 'example'}
    return resp, HTTPStatus.OK


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)