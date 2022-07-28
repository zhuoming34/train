#!/bin/bash
set -u

repo_token=$1

if [ "$GITHUB_EVENT_NAME" != "milestone" ]; then
  echo "::set-output name=release-url::http://example.com"
  exit 0
fi

event_type=$(jq --raw-output .action $GITHUB_EVENT_PATH)

if [ $event_type != "closed" ]; then
  echo "::debug:::The event type was "$event_type 
  exit 0
fi

milestone_name=$(jq --raw-output .milestone.title $GITHUB_EVENT_PATH)

# Internal Field Separator, read multiple variables
IFS='/' read owner repository <<< "$GITHUB_REPOSITORY"

release_url=$(dotnet gitreleasemanager create \ 
--milestone $milestone_name \
--targetcommitish $GITHUB_SHA \
--token $repo_token \
--owner $owner \
--repository $repository)

#echo "::set-output name=release-url::http://example.com"
echo "::set-output name=release-url::$release_url"

exit0
