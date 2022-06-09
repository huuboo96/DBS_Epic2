#!/usr/bin/env python

import yaml

with open("cloudformation_template_output.yaml", "r") as stream:
    try:
        print(yaml.safe_load(stream))
    except yaml.YAMLError as exc:
        print(exc)