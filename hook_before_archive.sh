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
shopt -s globstar
rename -n 's/Teeny/Coco/' **

cd ${curr_dir}