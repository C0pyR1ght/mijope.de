#!/bin/bash

if [ "$#" != 1 ]; then
  echo "Wrong number of arguments"
  exit 1
fi

function copy {
  rsync -avhr --delete -e ssh $1 rootknecht:$2
}


hugo
hugo --minify
case $1 in
    dev )
        echo "Deploying to test.rootknecht.net"
        copy ./public/ /var/www/test/
        ssh rootknecht chown -R knecht:www-data /var/www/test
        ;;
    prod )
        echo "Deploying to mijope.de"
        scp -r ./public/* rootknecht:/var/www/mijope
        ssh rootknecht chown -R knecht:www-data /var/www/mijope
        ;;
esac
