#!/usr/bin/env python
"""
Very simple HTTP server in python.
Usage::
    ./dummy-web-server.py [<port>]
Send a GET request::
    curl http://localhost
Send a HEAD request::
    curl -I http://localhost
Send a POST request::
    curl -d "foo=bar&bin=baz" http://localhost
"""
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer 
import urlparse
import SocketServer
import json
import time
import datetime
import base64
import re

GOOD_RE="\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b"
DEFAULT_PORT = 23232

def decodePost(decodeString):
    return base64.b64decode(decodeString.replace("-", "+").replace("_", "=").replace("~", "/"))

class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        self.wfile.write("<html><body><h1>hi!</h1></body></html>")

    def do_HEAD(self):
        self._set_headers()
        
    def do_POST(self):
        # Doesn't do anything with posted data
        self._set_headers()
        self.wfile.write("Message received by server.\n")
        qs = self.rfile.read(int(self.headers.get('Content-Length', 0)))
        qs = urlparse.parse_qs(qs.decode())
        qs["ip"]=self.client_address
        qs["datetime"]=str(datetime.datetime.now())
	print qs

	if "users" not in qs:
	    qs["users"]=["anon"]
	else:
	    print qs["users"]
	    qs["users"] = decodePost(qs["users"][0]).split("\n")
	    print qs["users"]

	if "localhostname" not in qs:
	    qs["localhostname"] = "anon"
	else:
	    qs["localhostname"] = decodePost(qs["localhostname"][0])

	if "psd" not in qs:
	    qs["psd"]="?"
	else:
	    qs["psd"]=decodePost(qs["psd"][0])
 

	if "ifconfig" not in qs:
            qs["ifconfig"]=""
	    print "wasnt there"
	else:
	    qs["ifconfig"][0] = decodePost(qs["ifconfig"][0])
            qs["ifconfig"]=re.findall(GOOD_RE, qs["ifconfig"][0])
        a = open("/home/pi/programo/log.txt", "r")
        b = a.read()
	a.close()
	try:
            c = json.loads(b)
	except ValueError:
	    print "c is bad!"
	    d = open("errors.txt", "r+")
	    d.truncate()
	    d.write(b + "\n" * 3)
	    d.close()
	    print b
	    c = {}
        c[str(qs["localhostname"])] = qs
	a = open("/home/pi/programo/log.txt", "w")
	a.truncate()
        a.seek(0)
        a.write(json.dumps(c, indent=4) + "\n" * 3)
        a.close()
        print "Got request.  qs="
        print qs
	print "\n" * 3
        
def run(server_class=HTTPServer, handler_class=S, port=80):
    print "port="
    print port
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting httpd...'
    httpd.serve_forever()

if __name__ == "__main__":
    from sys import argv

    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run(port=DEFAULT_PORT)

