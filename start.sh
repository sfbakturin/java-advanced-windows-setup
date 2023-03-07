#!/bin/bash

SOLUTIONS="solutions"
TESTS="tests"
SURNAME="__last_name__"

PACKAGE="$1"
SOLUTION_CLASS="$2"
TESTER_CLASS="$3"

mkdir jar-runner
cp "${TESTS}/artifacts/"* "jar-runner/"
cp "${TESTS}/lib/"* "jar-runner/"
cp -r "${TESTS}/modules/info.kgeorgiy.java.advanced.${PACKAGE}/"* "jar-runner/"
mkdir -p "jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"
cp "${SOLUTIONS}/java-solutions/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"* "jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"

cd jar-runner || exit

javac info/kgeorgiy/ja/${SURNAME}/"${PACKAGE}"/*.java && java -cp . -p . -m info.kgeorgiy.java.advanced."${PACKAGE}" "${TESTER_CLASS}" info.kgeorgiy.ja.${SURNAME}."${PACKAGE}"."${SOLUTION_CLASS}"

cd ..

read
