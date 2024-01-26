#!/bin/sh

if [ -z "$1" ]
then
    echo "Tag was not provided!"
    exit 1
fi

if git tag --list | egrep -q "^$1$"
then
    echo "Valid tag: '$1'"
    commit=$(git rev-list -n 1 tags/$1)
    echo "Retrieved commit from tag: '$commit'"
    echo "::set-output name=commit::$commit"
else
    echo "Tag does not exist: '$1'\n"
    echo "Available tags:"
    git tag --list
    exit 1
fi