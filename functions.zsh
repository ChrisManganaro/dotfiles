#!/bin/sh

gipu () {
  CURRENT_BRANCH="$(git branch | grep \* | cut -d ' ' -f2)"

  git push -u origin $CURRENT_BRANCH
}

gmm () {
  CURRENT_BRANCH="$(git branch | grep \* | cut -d ' ' -f2)"
  DIVIDER='#'

  function printLargeBlock() {
    TITLE="${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER} [$1] ${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}${DIVIDER}"
    STR_LENGTH=${#TITLE}

    echo "\n"
    printf "${DIVIDER}%.0s" {1..${STR_LENGTH}}
    echo ''
    echo $TITLE
    printf "${DIVIDER}%.0s" {1..${STR_LENGTH}}
    echo "\n"
  }
  
  if [ ! -d .git ]; then
    printLargeBlock "Not a GIT repo!" | chalk white bold bgRed
    
    return 0
  fi;

  printLargeBlock "Master -> ${CURRENT_BRANCH}" | chalk white bold bgGreen
  
  chalk -t "{bgWhite.black.bold  1 }{cyan  Checkout out to MASTER...}"
  git checkout master
  echo ""
  chalk -t "{bgWhite.black.bold  2 }{cyan  Pulling MASTER...}"
  git pull
  echo ""
  chalk -t "{bgWhite.black.bold  3 }{cyan  Moving back to feature [${CURRENT_BRANCH}]}"
  git checkout $CURRENT_BRANCH
  echo ""
  chalk -t "{bgWhite.black.bold  4 }{cyan  Merging MASTER into [${CURRENT_BRANCH}]}"
  git merge master
  
  if [ "$1" == "-p" ]; then
    echo ""

    chalk -t "{bgWhite.black.bold  5 }{cyan  Pushing to [${CURRENT_BRANCH}]}"
    git push
  fi;

  printLargeBlock "DONE!" | chalk white bold bgGreen
}


# LazyLoad node/npm
nvm() {
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}
 
node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    node "$@"
}
 
npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    npm "$@"
}