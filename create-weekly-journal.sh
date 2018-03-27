#! /bin/sh

# ./create-weekly-journal.sh 13
function create () {
  # Deps
  npm i -g yaml-cli gh-description

  #statements
  SRC=/Users/richard/src
  SOURCE='2018-week-12'
  TARGET='2018-week-'$1
  SOURCE_TITLE="2018 Week 12"
  TARGET_TITLE="2018 Week "$1

  # Copy over the files and go into the dir
  cp -r $SRC'/'$SOURCE $SRC'/'$TARGET
  cd $SRC'/'$TARGET

  # Clean up the git
  rm -rf .git
  git init
  hub create

  # Clear all of the past content
  rm -rf _site _drafts/* _posts/*
  # Replace 2018-week-12 string
  ag -0 -l $SOURCE | xargs -0 sed -i '' "s/$SOURCE/$TARGET/g"
  # Replace title in config.site and in README.md
  sed -i '' '1s/.*/# '$TARGET_TITLE'/' README.md
  ## The following ag rule breaks on spaces
  # ag -0 -l $SOURCE_TITLE | xargs -0 sed -i '' "s/$SOURCE/$TARGET_TITLE/g"
  # Replace description in config.site
  yaml set _config.yml site.title $TARGET_TITLE
  yaml set _config.yml site.description "A journaling experiment for week 13 of 2018"
  echo 'Having some issues with `gh-description`'
  # gh-description RichardLitt/$TARGET "A journaling experiment for week '$1' of 2018"

  echo 'Time to push!'

}

create $1
