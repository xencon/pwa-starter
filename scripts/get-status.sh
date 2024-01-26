#!/bin/sh

if [ -z "$1" ]
then
    echo "Commit sha was not provided!"
    exit 1
else
    echo "Retrieving last completed workflow run for commit '$1'"
    last_run_status=$(gh run list --branch main --workflow "Main Pipeline" --json "conclusion,headSha,status" --jq '.[] | select(.status == "completed") | select(.headSha == "'$1'") | .conclusion')

    if [ -z "$last_run_status" ]
    then
        echo "No completed workflow run was found for '$1'"
        echo "Ensure correct commit is being used!"
        exit 1
    fi

    if [ "$last_run_status" == "success" ]
    then
        echo "Last run for commit '$1' was successful"
        exit 0
    else
        echo "Last run for commit '$1' was '$last_run_status'"
        echo "Aborting..."
        exit 1
    fi
fi
