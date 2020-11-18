#!/bin/bash

if [ "$#" != 1 ]; then
  echo "Wrong number of arguments"
  exit 1
fi

function copy {
  rsync -avhr --delete -e ssh $1 neu:$2
}


hugo
hugo --minify
case $1 in
    dev )
        echo "Deploying to test.rootknecht.net"
        copy ./public/ /var/www/test/
        ssh neu chown -R michael:www-data /var/www/test
        ;;
    prod )
        echo "Deploying to mijope.de"
        copy ./public/ /var/www/mijope/
        ssh neu chown -R michael:www-data /var/www/mijope
        ;;
esac
