#!/usr/bin/python

import sys
import json

body = sys.argv[1]

response = {
        "statusCode": 201,
        "headers": { "Content-Type": "application/json"},
        "body": json.dumps(body)
    }

print(json.dumps(response))