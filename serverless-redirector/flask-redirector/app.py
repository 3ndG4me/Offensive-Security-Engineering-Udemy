from flask import Flask, jsonify, make_response, request
import json
import urllib3

http = urllib3.PoolManager()
app = Flask(__name__)

def redirect(path):
    query = request.query_string.decode()
    
    host = "https://injection.sh"

    if path != '':
        host += "/" + path

    if query != '':
        host += "?" + query # Replace with your API URL

    try:
        # Make the GET request
        response = http.request('GET', host)

        return {
            'statusCode': 200,
            'body':  response.data.decode('utf-8') # Decode the response from bytes to string
        }
    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }

@app.route("/")
def index_route():
    return redirect('')

@app.route('/<path:path>')
def catch_all(path):
    return redirect(path)

@app.errorhandler(404)
def resource_not_found(e):
    return make_response(jsonify(error='Not found!'), 404)

