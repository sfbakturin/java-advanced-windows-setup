#!/bin/bash

REAL_PATH=""
LIBS=""

SOLUTIONS="solutions"
TESTS="tests"
SURNAME="__last_name__"

PACKAGE_SOLUTIONS="$1"
PACKAGE_TESTS="$2"
CLASS_SOLUTIONS="$3"
CLASS_TESTS="$4"

# Windows Git Bash
if [[ "${OSTYPE}" == "msys" ]]
then
  REAL_PATH=""
fi

# Linux (WSL)
if [[ "${OSTYPE}" == "linux-gnu"* ]]
then
  REAL_PATH="${PWD}/"
  cd ~ || exit
fi

[[ ! -d jar-runner/ ]] && mkdir jar-runner/

cp "${REAL_PATH}${TESTS}/artifacts/"* "jar-runner/"
cp "${REAL_PATH}${TESTS}/lib/"* "jar-runner/"
cp -r "${REAL_PATH}${TESTS}/modules/info.kgeorgiy.java.advanced.base/"* "jar-runner/"
cp -r "${REAL_PATH}${TESTS}/modules/info.kgeorgiy.java.advanced.${PACKAGE_SOLUTIONS}/"* "jar-runner/"
cp -r "${REAL_PATH}${TESTS}/modules/info.kgeorgiy.java.advanced.${PACKAGE_TESTS}/"* "jar-runner/"

mkdir -p "jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE_SOLUTIONS}/"

cp "${REAL_PATH}${SOLUTIONS}/java-solutions/info/kgeorgiy/ja/${SURNAME}/${PACKAGE_SOLUTIONS}/"* "jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE_SOLUTIONS}"

cd jar-runner || exit

# Windows Git Bash
if [[ "${OSTYPE}" == "msys" ]]
then
  LIBS="junit-4.11.jar;jsoup-1.8.1.jar;hamcrest-core-1.3.jar;quickcheck-0.6.jar;./info/kgeorgiy/java/advanced/${PACKAGE_TESTS}/;./info/kgeorgiy/java/advanced/${PACKAGE_SOLUTIONS}/;."
fi

# Linux (WSL)
if [[ "${OSTYPE}" == "linux-gnu" ]]
then
  LIBS="junit-4.11.jar:jsoup-1.8.1.jar:hamcrest-core-1.3.jar:quickcheck-0.6.jar:./info/kgeorgiy/java/advanced/${PACKAGE_TESTS}/:./info/kgeorgiy/java/advanced/${PACKAGE_SOLUTIONS}/:."
fi

javac -encoding utf8 -verbose -classpath "${LIBS}" info/kgeorgiy/java/advanced/base/*.java info/kgeorgiy/java/advanced/"${PACKAGE_TESTS}"/*.java info/kgeorgiy/java/advanced/"${PACKAGE_SOLUTIONS}"/*.java info/kgeorgiy/ja/"${SURNAME}"/"${PACKAGE_SOLUTIONS}"/*.java
java -Dfile.encoding=UTF-8 -cp . -p . -m info.kgeorgiy.java.advanced."${PACKAGE_TESTS}" "${CLASS_TESTS}" info.kgeorgiy.ja."${SURNAME}"."${PACKAGE_SOLUTIONS}"."${CLASS_SOLUTIONS}"

cd ..

# Windows Git Bash
if [[ "${OSTYPE}" == "msys" ]]
then
  read
  exit
fi
