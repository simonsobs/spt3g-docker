NAME = simonsobs/spt3g
VERSION = $(shell cd spt3g_software; git describe --tags --always HEAD)

.PHONY : all
all : spt3g_software/ check pulled.txt built.txt pushed.txt pruned.txt

.PHONY : build
build : spt3g_software/ check pulled.txt built.txt

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

# Build the docker image
built.txt : pulled.txt
	docker pull ubuntu:18.04
	docker build -t ${NAME}:$(VERSION) .
	@echo `date` > built.txt

# test and push
pushed.txt : built.txt
	/usr/bin/python3 ./test_image.py $(NAME) $(VERSION)
	touch pushed.txt

pruned.txt : pushed.txt
	docker rmi $(NAME):$(VERSION)
	@echo `date` - removed $(NAME):$(VERSION) > pruned.txt

.PHONY : clean
clean :
	rm -f pulled.txt
	rm -f built.txt
	rm -f check_repo.txt
	rm -f pushed.txt
	rm -f pruned.txt
	rm -rf spt3g_software/

.PHONY : variables
variables :
	@echo ${VERSION}

# vim: set expandtab!:
