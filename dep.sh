#!/bin/bash

upload_to_ftp_singlefile(){
    HOST=ftp://ftp.dlptest.com/
    USER=dlpuser@dlptest.com
    PASSWORD=SzMf7rTE4pCrf9dV286GuNe4N

    ACTION=$1
    FILE=$2

    FILE_PATH=`dirname "$FILE"`
    FILE_NAME=`basename "$FILE"`

    if [ $ACTION == "A" -o $ACTION == "M" ]
    then
        echo "Uploading File $FILE";
        echo "File path $FILE_PATH"
        echo "File name $FILE_NAME"
        if [ $FILE_PATH == "." ]
        then
            echo $(lftp -c "set ftp:ssl-allow no; open -u $USER,$PASSWORD $HOST; put -O / $FILE")
        else
            echo $(lftp -c "set ftp:ssl-allow no; open -u $USER,$PASSWORD $HOST; mkdir -p $FILE_PATH; put -O /$FILE_PATH $FILE")
        fi
    fi

}

OUTPUT="$(git pull)"
echo "${OUTPUT}"
SAVEIFS=$IFS
IFS=$'\n'
names=($OUTPUT)
IFS=$SAVEIFS

hash=0
for (( i=0; i<${#names[@]}; i++ ))
do

    if [[ "${names[$i]}" == *"Updating"* ]]; then
        echo "###########   start and end hashes from branch";
        a=${names[$i]};
        echo $a;

        my_array=($(echo $a | tr ".." "\n"))

        hash=${my_array[1]};


    fi
    #echo "$i: ${names[$i]}"
done


if [ $hash != "0" ]
then
 echo ${hash};
fi

updated_files=$(git diff --name-status d043564..)


SAVEIFS=$IFS
IFS=$'\n'
names=($updated_files)
IFS=$SAVEIFS

hash=0
for (( i=0; i<${#names[@]}; i++ ))
do
    a=(${names[$i]});
    echo ${a[0]};
    echo ${a[1]};
    upload_to_ftp_singlefile ${a[0]} ${a[1]}
done
