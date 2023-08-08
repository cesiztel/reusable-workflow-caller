header="| header | header |\n| ------ | ------ |\n"
for i in *sh
do
    header+="| ${i} |  |\n"
done
printf "$header"