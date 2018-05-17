#! /bin/sh
#
# To run: sh create-monthly-blog.sh june
# Note: casing for june is odd. Maybe it should be lowercase.

function createRepo () {
  # Clean up the git
  rm -rf .git
  git init
  hub create
}

# ./create-weekly-journal.sh 13
function create () {
  # Deps
  npm i -g yaml-cli gh-description

  #statements
  SRC=/Users/richard/src
  SOURCE='2018-month'
  TARGET='2018-'$1
  SOURCE_TITLE="2018 Month"
  TARGET_TITLE="2018 "$1" Blog"

  # Copy over the files and go into the dir
  cp -r $SRC'/monthly-blog' $SRC'/'$TARGET
  cd $SRC'/'$TARGET

  createRepo

  # Clear all of the past content
  rm -rf _site _drafts/* _posts/*
  # Replace 2018-month string
  ag -0 -l $SOURCE | xargs -0 sed -i '' "s/$SOURCE/$TARGET/g"
  # Replace title in README.md
  sed -i '' '1s/.*/# '$TARGET_TITLE'/' README.md
  ## The following ag rule breaks on spaces
  # ag -0 -l $SOURCE_TITLE | xargs -0 sed -i '' "s/$SOURCE/$TARGET_TITLE/g"
  # Replace description in config.site
  # These don't work, either
  echo 'Having some issues with setting yaml config, too'
  yaml set _config.yml site.title $TARGET_TITLE
  yaml set _config.yml site.description "A journaling experiment for the month of "$1" in 2018"
  echo 'Having some issues with `gh-description`'
  echo 'Set them manually.'
  # gh-description RichardLitt/$TARGET "A journaling experiment for week '$1' of 2018"

  echo 'Setting up a symlink to docs'
  ln -s ~/src/$1/ /Users/richard/docs/$1

  echo 'Time to push!'
  # Go to site
  git browse "RichardLitt/"$TARGET

}

create $1
