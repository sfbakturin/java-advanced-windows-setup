# java-advanced-windows-setup

Здесь представлена инструкция, вдохновленная [другой основной инструкцией](https://telegra.ph/Kak-podgotovitsya-k-JavaAdvanced-02-16), дополненная лишь ещё несколькими методами запуска на операционной системе Windows (local/remote/wsl/ssh).

## Тестирование с Intellij IDEA

1. Установите [Intellij IDEA](https://www.jetbrains.com/ru-ru/idea/download/#section=windows) и [JDK17+](https://adoptium.net/).
2. Создайте пустой проект `java-advanced` с выбранным Build system как Intellij и сразу удалите папку `src/` из-за ненадобности.
3. Зайдите в директорию проекта и склонируйте туда Git-репозиторий с тестами, переименуем её в `tests/`, также склонируем туда персональный репозиторий, переименуем её в `solutions/`.
4. В проводнике проекта пометьте `tests/lib/` как `Resources Root` (ПКМ по `tests/lib/`, `Mark Directory as -> Resources Root`), `solutions/java-solutions/` - `Sources Root` (ПКМ по `solutions/java-solutions/`, `Mark Directory as -> Sources Root`).
5. Зайдем в структуру проекта (`File -> Project Structure`), в вкладке `Libraries` добавьте используемые библиотеки (`+ -> Java -> tests/lib/ -> OK`).
6. В вкладке `Modules` добавим все существующие модули (сверху `+ -> Import Module -> tests/modules/info.kgeorgiy.java.advanced.*`, далее `Next` и `Create`).
7. Теперь зайдем в модуль `info.kgeorgiy.java.advanced.base` и добавим туда добавленную библиотеку (`+ -> Library`), проделаем ту же схему и для оставшихся модулей. Также, во всех оставшихся, кроме `base` и `java-advanced`, мы добавим зависимость модулей, у всех не-`base` и  не-`java-advanced` должна быть подключена зависимость с `base` (`+ -> Module Dependency -> info.kgeoriy.java.advanced.base`).
8. Откроем модуль `java-advanced`, добавим туда библиотеку и все не-`base` модули в зависимости.
9. Зайдем в конфигурации запуска и добавим новый `Application`, назовём его `WalkTest (Windows)`
    * `module not specified` заменяем на версию установленного JDK;
    * `-cp <no module>` заменяем на `java-advanced`;
    * в `Main class` вставим строку вида `info.kgeorgiy.java.advanced.walk.Tester`;
    * в `Program arguments` вставим строку вида `Walk info.kgeorgiy.ja.__last_name__.walk.Walk`, где первый `Walk` - наименование тестера (easy/hard), второе - это полное наименование вашего класса.

## Скрипт запуска `.jar`-файлов

1. Добавим в директорию проекта скрипт [`start.sh`](start.sh), который выглядит так:

    ```sh
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
    mkdir -p "jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"
    cp "${SOLUTIONS}/java-solutions/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"* "jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"

    cd jar-runner || exit

    javac info/kgeorgiy/ja/${SURNAME}/"${PACKAGE}"/*.java && java -cp . -p . -m info.kgeorgiy.java.advanced."${PACKAGE}" "${TESTER_CLASS}" info.kgeorgiy.ja.${SURNAME}."${PACKAGE}"."${SOLUTION_CLASS}"

    cd ..

    read
    ```

    Разберём подробнее, что здесь происходит. В переменную `SOLUTIONS` и `TESTS` загоняются наименования каталогов, которые мы создали предыдущим шагом, в `SURNAME` пишется ваша фамилия, как в персональном репозитории. При  запуске в той же директории создаётся `jar-runner`, туда копируется всё, что нужно, компилируется и сразу запускается. По завершении от пользователя, чтобы закрыть окно Git, требуется прожать enter (см. `read`), ибо при запуске скрипта запускается обработчик `.sh` Git Bash, который после завершения, сразу же закрывает окно.
2. Зайдем в конфигурации запуска в Intellij IDEA и добавим новый `Shell Script`, именуем его как `JarWalkTest`
    * в `Script path` укажем путь к нашему `start.sh`;
    * в `Script options` укажем следующие параметры: *пакет, в котором лежит решение и тесты*; *наименование класса решения*; *наименование класса тестера*.

## Запуск `jar`-файлов через `WSL`

1. Активация компоненты Windows.
    * Откройте *Панель управления*, далее *Все элементы панели управления* и *Программы и компоненты* и нажмите ***Включение и отключение компонентов Windows***.
    * В списке найдите пункт ***Подсистема Windows для Linux*** и убедитесь, что перед пунктом стоит галочка. В ином случае: поставьте, сохраните изменения и перезагрузите компьютер.
2. В Microsoft Store установите приложение ***Подсистема Windows для Linux***, запустите его и введите туда:

    ```cmd
    wsl.exe --update
    ```

3. В Microsoft Store установите приложение ***Ubuntu 22.04.2 LTS***, запустите его, проследуйте инструкция установки и введите туда:

    ```sh
    sudo apt-get update
    sudo apt-get upgade -y
    sudo apt-get install openjdk-17-jdk-headless
    ```

4. Создадим два скрипта [start_wsl_impl.sh](start_wsl_impl.sh) и [start_wsl.bat](start_wsl.bat). Рассмотрим `start_wsl.bat`

    ```bat
    @echo off

    bash start_wsl_impl.sh "%1" "%2" "%3"
    ```

    Здесь мы запускаем через WSL скрипт `start_wsl_impl.sh` и передаём три аргумента, переданные ему. Уже в WSL мы исполняем следующий код:

    ```sh
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
    mkdir -p "${HOME}/jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"
    cp "${SOLUTIONS}/java-solutions/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"* "${HOME}/jar-runner/info/kgeorgiy/ja/${SURNAME}/${PACKAGE}/"

    cd "${HOME}/jar-runner" || exit

    javac info/kgeorgiy/ja/${SURNAME}/"${PACKAGE}"/*.java && java -cp . -p . -m info.kgeorgiy.java.advanced."${PACKAGE}" "${TESTER_CLASS}" info.kgeorgiy.ja.${SURNAME}."${PACKAGE}"."${SOLUTION_CLASS}"
    ```

    Этот скрипт в IDEA запускается в терминале и не требует дальнейшего нажатия enter, как было выше. Действия аналогичны.

5. Теперь в конфигурациях запусков мы добавим `JarWalkTestWSL`
    * в `Script path` укажем путь к `start_wsl.bat`;
    * в `Script options` укажем те же аргументы, что и при `JarWalkTest`.
