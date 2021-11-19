#!/bin/bash

# Made by Tommy Zaft

python3 create_tests.py # create the main2_test911.c and the correct_funcs.c functions files

gcc main2_test911.c correct_funcs.c -o correct_911
./correct_911 > correct_results.txt
rm -f correct_911 # delete the unnecessary binary

gcc main2_test911.c ex2.s -o p2_911
./p2_911 > results_got.txt
rm -f p2_911 # delete the unnecessary binary

diff -s correct_results.txt results_got.txt # compare your results to the correct ones
