#!/bin/bash

SOURCE=""
LIBRARY=""

PATH_RUNNER="jar-runner"
PATH_RUNNER_CURRENT="${PATH_RUNNER}/$(date '+%d-%m-%Y_%H-%M-%S')"

SOLUTIONS="__solutions__"
TESTS="__tests__"
LAST_NAME="__last_name__"

PACKAGE_SOLUTIONS="$1"
PACKAGE_TESTS="$2"
CLASS_SOLUTIONS="$3"
CLASS_TESTS="$4"

if [[ "$OSTYPE" != "darwin"* ]]; then
  if grep -qi microsoft /proc/version; then
    SOURCE="${PWD}/"
    cd ~ || exit 1
  fi
fi

[[ ! -d "${PATH_RUNNER}"/ ]] && mkdir "${PATH_RUNNER}"/
mkdir "${PATH_RUNNER_CURRENT}"/

cp "${SOURCE}${TESTS}/artifacts/"* "${PATH_RUNNER_CURRENT}/"
cp "${SOURCE}${TESTS}/lib/"* "${PATH_RUNNER_CURRENT}/"

for MODULE in "${SOURCE}${TESTS}"/modules/*
do
  cp -r "${MODULE}/"* "${PATH_RUNNER_CURRENT}/"
done

mkdir -p "${PATH_RUNNER_CURRENT}/info/kgeorgiy/ja/${LAST_NAME}/${PACKAGE_SOLUTIONS}/"
cp "${SOURCE}${SOLUTIONS}/java-solutions/info/kgeorgiy/ja/${LAST_NAME}/${PACKAGE_SOLUTIONS}/"* "${PATH_RUNNER_CURRENT}/info/kgeorgiy/ja/${LAST_NAME}/${PACKAGE_SOLUTIONS}"

cd "${PATH_RUNNER_CURRENT}" || exit

if [[ "${OSTYPE}" == "linux-gnu"* || "${OSTYPE}" == "darwin"* || "${OSTYPE}" == "freebsd"* ]]
then
  LIBRARY="junit-4.11.jar:jsoup-1.8.1.jar:hamcrest-core-1.3.jar:quickcheck-0.6.jar:./info/kgeorgiy/java/advanced/${PACKAGE_TESTS}/:./info/kgeorgiy/java/advanced/${PACKAGE_SOLUTIONS}/:."
fi

if [[ "${OSTYPE}" == "msys" || "${OSTYPE}" == "cygwin" ]]
then
  LIBRARY="junit-4.11.jar;jsoup-1.8.1.jar;hamcrest-core-1.3.jar;quickcheck-0.6.jar;./info/kgeorgiy/java/advanced/${PACKAGE_TESTS}/;./info/kgeorgiy/java/advanced/${PACKAGE_SOLUTIONS}/;."
fi

javac -encoding utf8 -classpath "${LIBRARY}" info/kgeorgiy/java/advanced/base/*.java info/kgeorgiy/java/advanced/"${PACKAGE_TESTS}"/*.java info/kgeorgiy/java/advanced/"${PACKAGE_SOLUTIONS}"/*.java info/kgeorgiy/ja/"${LAST_NAME}"/"${PACKAGE_SOLUTIONS}"/*.java
java -Dfile.encoding=UTF-8 -cp . -p . -m info.kgeorgiy.java.advanced."${PACKAGE_TESTS}" "${CLASS_TESTS}" info.kgeorgiy.ja."${LAST_NAME}"."${PACKAGE_SOLUTIONS}"."${CLASS_SOLUTIONS}"

cd ../..

if [[ "${OSTYPE}" == "msys" || "${OSTYPE}" == "cygwin" ]]
then
  # shellcheck disable=SC2162
  read
  exit
fi
