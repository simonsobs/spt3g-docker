#!/bin/sh
# https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    :
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull" > ../check_repo.txt
elif [ $REMOTE = $BASE ]; then
    :
else
    :
fi

if [ ! -f ../check_repo.txt ]; then
    echo "first repo check" > ../check_repo.txt
fi
