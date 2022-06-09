import os
import sys
import json
import jinja2

data_file="data/"+sys.argv[1]

def my_function():
  with open(data_file,'r') as f:
    data =  json.load(f)
    return data[0]

sys.stdout.write(jinja2.Template(sys.stdin.read()).render(my_function()))