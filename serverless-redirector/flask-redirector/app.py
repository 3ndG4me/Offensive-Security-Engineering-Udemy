from flask import Flask, jsonify, make_response, request
import json
import urllib3

http = urllib3.PoolManager()
app = Flask(__name__)

host = "https://injection.sh"

@app.route("/")
def index_route():
    query = request.query_string.decode()

    url = host 

    if query != '':
        url += "?" + query # Replace with your API URL

    try:
        # Make the GET request
        response = http.request('GET', url)

        return {
            'statusCode': 200,
            'body':  response.data.decode('utf-8') + "url was:" + url # Decode the response from bytes to string
        }
    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }

@app.route('/<path:path>')
def catch_all(path):

    query = request.query_string.decode()

    url = host + "/" + path

    if query != '':
        url += "?" + query # Replace with your API URL

    try:
        # Make the GET request
        response = http.request('GET', url)

        return {
            'statusCode': 200,
            'body':  response.data.decode('utf-8') + "url was:" + url # Decode the response from bytes to string
        }
    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }

@app.errorhandler(404)
def resource_not_found(e):
    return make_response(jsonify(error='Not found!'), 404)

