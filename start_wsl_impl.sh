#!/bin/bash

SOLUTIONS="solutions"
TESTS="tests"
SURNAME="__last_name__"

PACKAGE="$1"
SOLUTION_CLASS="$2"
TESTER_CLASS="$3"

mkdir ~/jar-runner/
cp "${TESTS}/artifacts/"* "${HOME}/jar-runner/"
cp "${TESTS}/lib/"* "${HOME}/jar-runner/"
cp -r "${TESTS}/modules/info.kgeorgiy.java.advanced.${PACKAGE}/"* "${HOME}/jar-runner/"
mkdir -p "${HOME}/jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"
cp "${SOLUTIONS}/java-solutions/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"* "${HOME}/jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"

cd "${HOME}/jar-runner" || exit

javac info/kgeorgiy/ja/${SURNAME}/"${PACKAGE}"/*.java && java -cp . -p . -m info.kgeorgiy.java.advanced."${PACKAGE}" "${TESTER_CLASS}" info.kgeorgiy.ja.${SURNAME}."${PACKAGE}"."${SOLUTION_CLASS}"
