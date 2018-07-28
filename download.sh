#!/bin/bash

# https://mirrors.slackware.com/slackware/slackware-2.0.0/slakware
# https://mirror.yandex.ru/slackware/slackware-2.0.0/slakware/
# https://mirror.yandex.ru/slackware/slackware-2.0.0/source/
domain=https://mirror.yandex.ru/slackware/slackware-2.0.0/slakware
downloaddir=`pwd`/slackfat

mkdir -p $downloaddir
currentdir=$downloaddir
currentitem=

for item in $(grep -v '^#' ./00index.txt | awk '{print $1}')
do
    cd $currentdir
    case $item in
        */ )
        ;;

        *: )
            currentdir=${downloaddir}/${item%:}
            currentitem=${item%:}
            mkdir -p ${currentdir} && cd ${currentdir}
        ;;

        * )
            # echo "downloading $item from $fileurl ..."
            filebaseurl=${domain}
            if [ ! -z ${currentitem} ]; then filebaseurl+=/${currentitem}; fi
            wget ${filebaseurl}/${item}
        ;;
    esac
done