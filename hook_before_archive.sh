echo "-- rebranding libraries --"
export LC_CTYPE=C LANG=C

curr_dir=$(pwd)

cd "avr/libraries/"

#rename variable inside library
# find ./Teeny*/ -type f -name '*.*' -exec sed -i '' s/Teeny/Coco/ {} +
find ./Teeny*/ -type f -exec sed -i 's/Teeny/Coco/g' '{}' \;
find ./Teeny*/ -type f -exec sed -i 's/TEENY/COCO/g' '{}' \;

#rename folder name
# find ./Teeny* -depth -name "*Teeny*" -execdir sh -c 'mv {} $(echo {} | sed "s/Teeny/Coco/")' \;
# find . -name "*Teeny*" -exec rename 's/Teeny$/Coco/' '{}' \;
# find . -iname "*Teeny*" -exec rename Teeny Coco '{}' \;
# find . -iname "*Teeny*" -exec rename _dbg.txt .txt '{}' \;
# find . -name Teeny* | sed -e "p;s/Teeny/Coco/" | xargs -n2 mv
# find . -name *Teeny* | sed -e "p;s/Teeny/Coco/" | xargs -n2 mv

shopt -s globstar
rename 's/Teeny/Coco/' **
# rename Teeny Coco **/*dbg*

for file in $(find . -name "*Teeny*")
do 
  echo mv $file `echo $file | sed s/Teeny$/Coco/`
done

find . -name "*Teeny*" -exec bash -c 'mv "$1" "$(sed "s/\Teeny$/Coco/" <<< "$1")"' - '{}' \;

ls -al ./CocoSynth/src/

exit 1

cd ${curr_dir}