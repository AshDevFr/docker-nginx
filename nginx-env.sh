#!/bin/bash

CONF_DIR=/etc/nginx/conf.d
FILE_PATTERN=${CONF_DIR}/*.conf

ls ${FILE_PATTERN} | while read file
do
        typeset i=$(cat ${file}  | grep -e '\#\#IF\#__|\([a-zA-Z0-9\_\-\$]*\)|__' -o)
        typeset condition=$(echo "${i}" | wc -w)
        if [ "${enabled}" != "0" ]
        then
                typeset varname=$(echo ${i} | sed -e 's%\#\#IF\#__|\([a-zA-Z0-9\_\-\$]*\)|__%\1%')
                typeset evalvar=$(eval echo "\$${varname}")
                typeset enabled=$(echo "${evalvar}" | wc -w)
                echo "${enabled}"
                if [ "${enabled}" == "0" ]
                then
                        mv ${file} ${file}.bak
                fi
        fi
done

cat /dev/null > sed.script
cat ${FILE_PATTERN} | grep -e  '__|\([a-zA-Z0-9\_\-\$]*\)|__' -o | while read var
do
        typeset varname=$(echo ${var} | sed -e 's%__|\([a-zA-Z0-9\_\-\$]*\)|__%\1%')
        typeset evalvar=$(eval echo "\$${varname}")
        echo "s%__|${varname}|__%${evalvar}%" >> sed.script
done
ls ${FILE_PATTERN} | while read file
do
        echo "Eval env variables in ${file}"
        sed -f sed.script -i ${file}
	# cat ${file}
done
rm -f sed.script
echo "Start Nginx"
service nginx start
