import time
import os
import urllib.request
import json
from http.server import BaseHTTPRequestHandler, HTTPServer
import threading
# Environment variables 
immich_url = os.environ['IMMICH_URL']
server_port = int(os.environ['SERVER_PORT'])

url = f"{immich_url}/api/server-info/config"
post_url = f"{immich_url}/api/auth/admin-sign-up"

# env variables
# immich url: IMMICH_URL
# port to serve status on: SERVER_PORT
# email: EMAIL
# password: PASSWORD


print("Making check request to: " + url)

# Data for POST request
payload = {
    "email": os.environ['EMAIL'],
    "name": "Admin",
    "password":os.environ['PASSWORD'] 
}

data = json.dumps(payload).encode('utf-8')
headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

post_req = urllib.request.Request(post_url, data=data, headers=headers, method='POST')

# Global variable for the condition
is_initialized = False

# Function to toggle the boolean every second
def toggle_condition():
    global is_initialized
    while True:
        time.sleep(0.5)
        is_initialized = server_initialized()

        if is_initialized is False:
            try:
                with urllib.request.urlopen(post_req) as response:
                    response_text = response.read().decode('utf-8')
                    print("Server initialization response:", response_text)
            except Exception as e:
                print("Server initialization failed:", e)
        else:
            print("Server is initialized, doing nothing")

def server_initialized():
        try:
            with urllib.request.urlopen(url) as response:
                body = response.read()
                serialized_response = json.loads(body)
                print(body)
                is_initialized = serialized_response.get("isInitialized", False)

                return is_initialized

        except Exception as e:
            print("Failed to get server status:", e)
            return False

class MyRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        global is_initialized
        
        if is_initialized:
            self.send_response(200)  # OK status
        else:
            self.send_response(404)  # Not Found status
            
        self.end_headers()
        self.wfile.write(b"Hello, World!")

def run(server_class=HTTPServer, handler_class=MyRequestHandler, port=server_port):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Server running on port {port}...')
    httpd.serve_forever()

if __name__ == "__main__":
    # Start the background thread to toggle the boolean condition
    toggle_thread = threading.Thread(target=toggle_condition, daemon=True)
    toggle_thread.start()

    # Run the HTTP server
    run()
