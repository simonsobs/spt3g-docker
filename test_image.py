#!/usr/bin/env python3

import subprocess
import sys
import docker


client = docker.from_env()
check = client.containers.run('{}:{}'.format(sys.argv[1], sys.argv[2]), '/usr/bin/python3 -c "from spt3g import core"', auto_remove=True)

# valid import in container if returns empty string
if check == b'':
    tag = subprocess.run(["docker tag {}:{} {}:latest".format(sys.argv[1], sys.argv[2], sys.argv[1])], shell=True)
    push = subprocess.run(["docker push {}:{}".format(sys.argv[1], sys.argv[2])], shell=True)
    print("push result: {}".format(push.stdout))
    push_latest = subprocess.run(["docker push {}:latest".format(sys.argv[1])], shell=True)
else:
    print("Import failed within docker image")
