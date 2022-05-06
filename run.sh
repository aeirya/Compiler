#!/bin/bash
echo " *** !SAG TOO WINDOWS! ***"
OUTPUT_DIRECTORY="out/"
TEST_DIRECTORY="tests/"
REPORT_DIRECTORY="report/"
SOURCE_DIRECTORY="src/"
NUMBER_OF_PASSED=0
NUMBER_OF_FAILED=0
mkdir -p $OUTPUT_DIRECTORY
mkdir -p $REPORT_DIRECTORY

cd $SOURCE_DIRECTORY
make clean
make
cd ../

# echo "[Phase 1]: Lexer Started"
# TEST_DIR=${TEST_DIRECTORY}Lexer/
# OUT_DIR=${OUTPUT_DIRECTORY}Lexer/
# REP_DIR=${REPORT_DIRECTORY}Lexer/

# mkdir -p $OUT_DIR
# mkdir -p $REP_DIR
# cd $TEST_DIR
# prefix="t" ;
# dirlist=(`ls ${prefix}*.in`) ;
# cd ../..

# for filelist in ${dirlist[*]}
# do
#     filename=`echo $filelist | cut -d'.' -f1`;
#     output_filename="$filename.out"
#     report_filename="$filename.report.txt"
#     echo "Running Test $filename -------------------------------------"
#     cd $SOURCE_DIRECTORY
#     if [ $? -eq 1 ]; then
#         cd ..
#         echo "Code did not Compile"
#     else
#         cd ..
#         echo "Code compiled successfuly"
#         ./lexer -i $TEST_DIR$filelist -o $OUT_DIR$output_filename
#         if [ $? -eq 0 ]; then
#             echo "Code Executed Successfuly!"
#             if command -v python3 > /dev/null; then
#                 python3 comp.py -a "$OUT_DIR$output_filename" -b "$TEST_DIR$output_filename" -o "$REP_DIR$report_filename"
#             else
#                 python comp.py -a "$OUT_DIR$output_filename" -b "$TEST_DIR$output_filename" -o "$REP_DIR$report_filename"
#             fi
#             if [[ $? = 0 ]]; then
#                 ((NUMBER_OF_PASSED++))
#                 echo "++++ test passed"
#             else
#                 ((NUMBER_OF_FAILED++))
#                 echo "---- test failed !"
#             echo
#             fi 
#         else
#             echo "Code did not execute successfuly!"
#             ((NUMBER_OF_FAILED++))
#         fi
#     fi


# done

# echo "[Phase 1]: Lexer Completed:"
# echo "Passed : $NUMBER_OF_PASSED"
# echo "Failed : $NUMBER_OF_FAILED"

# echo "--------------------------------------------"

echo "[Phase 2]: Parser Started"
TEST_DIR=${TEST_DIRECTORY}Parser/
OUT_DIR=${OUTPUT_DIRECTORY}Parser/
REP_DIR=${REPORT_DIRECTORY}Parser/

mkdir -p $OUT_DIR
mkdir -p $REP_DIR
cd $TEST_DIR
prefix="t" ;
dirlist=(`ls ${prefix}*.in`) ;
cd ../..

for filelist in ${dirlist[*]}
do
    filename=`echo $filelist | cut -d'.' -f1`;
    output_filename="$filename.out"
    report_filename="$filename.report.txt"
    echo "Running Test $filename -------------------------------------"
    cd $SOURCE_DIRECTORY
    if [ $? -eq 1 ]; then
        cd ..
        echo "Code did not Compile"
    else
        cd ..
        echo "Code compiled successfuly"
        ./parser < $TEST_DIR$filelist > $OUT_DIR$output_filename
        if [ $? -eq 0 ]; then
            echo "Code Executed Successfuly!"
            if command -v python3 > /dev/null; then
                python3 comp.py -a "$OUT_DIR$output_filename" -b "$TEST_DIR$output_filename" -o "$REP_DIR$report_filename"
            else
                python comp.py -a "$OUT_DIR$output_filename" -b "$TEST_DIR$output_filename" -o "$REP_DIR$report_filename"
            fi
            if [[ $? = 0 ]]; then
                ((NUMBER_OF_PASSED++))
                echo "++++ test passed"
            else
                ((NUMBER_OF_FAILED++))
                echo "---- test failed !"
            echo
            fi 
        else
            echo "Code did not execute successfuly!"
            ((NUMBER_OF_FAILED++))
        fi
    fi


done