#!/bin/bash
HOST=ftp://ftp.dlptest.com/
USER=dlpuser@dlptest.com
PASSWORD=SzMf7rTE4pCrf9dV286GuNe4N

#OUTPUT="$(git pull)"

OUTPUT="remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 5 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (5/5), 499 bytes | 166.00 KiB/s, done.
From http://203.122.33.119/hemraj/demo2
   f48b69b..695f5ac  master     -> origin/master
Updating f48b69b..695f5ac
Fast-forward
 asds.txt   | 1 +
 readme.txt | 1 -
 tew22.txt  | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 create mode 100644 asds.txt
 delete mode 100644 readme.txt
 delete mode 100644 tew22.txt"

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
names=($OUTPUT) # split to array $names
IFS=$SAVEIFS   # Restore IFS

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

var=($(./inner.sh))

# And then test the array with:

echo ${var[0]}
echo ${var[1]}
echo ${var[2]}


#echo "${OUTPUT}"
#for i in $OUTPUT;
 #   do
  #      echo "Line = $i \n";
  #  done


#ftp -inv $HOST <<EOF
#user $USER $PASSWORD
#cd /path/to/file
#mput *.html
#bye
#EOF