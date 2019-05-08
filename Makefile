NAME = grumpy.physics.yale.edu/spt3g
VERSION = $(shell cd spt3g_software; git rev-parse --short HEAD)

.PHONY : all
all : spt3g_software/ check pulled.txt built.txt pushed.txt

# test and push
pushed.txt : built.txt
	/usr/bin/python3 ./test_image.py $(NAME) $(VERSION)
	touch pushed.txt

# Build the docker image and tag with git hash and update latest
built.txt : pulled.txt
	docker build -t ${NAME}:$(VERSION) .
	docker tag ${NAME}:$(VERSION) ${NAME}:latest
	@echo `date` > built.txt

# Clone the repo if we haven't already
spt3g_software/ :
	git clone https://github.com/CMB-S4/spt3g_software.git

# Always check if the repo has been updated
.PHONY : check
check : 
	cd spt3g_software/; git fetch
	cp check_repo_status.sh spt3g_software/
	cd spt3g_software/; ./check_repo_status.sh; rm ./check_repo_status.sh

# check_repo.txt only updates if we've fallen behind (or haven't run anything
# before), in which case, pull and create the dummy output file
pulled.txt : check_repo.txt
	cd spt3g_software/; git pull origin master
	@echo `date` > pulled.txt

.PHONY : clean
clean :
	rm -f pulled.txt
	rm -f built.txt
	rm -f check_repo.txt
	rm -rf spt3g_software/

.PHONY : variables
variables :
	@echo ${VERSION}

# vim: set expandtab!:
