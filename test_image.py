#!/usr/bin/python3

import subprocess
import sys

check = subprocess.run(["docker run -it --rm {}:{} /usr/bin/python3 -c 'from spt3g import core'".format(sys.argv[1], sys.argv[2])], shell=True, capture_output=True)
#fail = subprocess.run(["docker run -it --rm {}:{} /usr/bin/python3 -c 'from spt3g import core2'".format(sys.argv[1], sys.argv[2])], shell=True, capture_output=True)

if check.returncode == 0:
    push = subprocess.run(["docker push {}:{}".format(sys.argv[1], sys.argv[2])], shell=True)
    push_latest = subprocess.run(["docker push {}:latest".format(sys.argv[1])], shell=True)
