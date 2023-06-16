# java-advanced-windows-setup

Здесь представлена инструкция, вдохновленная [другой инструкцией](https://telegra.ph/Kak-podgotovitsya-k-JavaAdvanced-02-16), дополненная лишь ещё несколькими методами запуска на операционной системе Windows. Ниже приведены следующие виды запусков:

* компиляция и запуск через классы на Windows (локально);
* компиляция на Windows и запуск через классы на Ubuntu (по SSH-ключу);
* компиляция и запуск через тестирующие `jar`-файлы на Windows (локально, git bash);
* компиляция и запуск через тестирующие `jar`-файлы на подсистеме Windows для Linux (локально, terminal).

## Компиляция и запуск через классы на Windows

1. Скачайте и установите [JetBrains Intellij IDEA](https://www.jetbrains.com/ru-ru/idea/download/#section=windows) и [JDK17+](https://adoptium.net/).
2. Создайте пустой проект *java-advanced*.
    1. В поле **Name** положим *java-advanced*.
    2. В поле **Location** выберем место, куда мы положим проект.
    3. В **Language** выставим `Java`.
    4. В **Build system** выставим `Intellij`.
    5. Снимем галочку с `Add sample code`.
    6. В созданном проекте удалим директорию `src/`.
3. Склонируйте Git-репозитории.
    1. Зайдите в директорию проекта.
    2. C командной строки склонируем Git-репозиторий с тестами и персональный репозиторий.
    3. Для удобства переименуем репозиторий с тестам в `tests/`, персональный же - `solutions/`.
4. Пометьте директории проекта.
    1. Директорию `tests/lib/` пометьте как *Resources Root*.
    2. Директорию `solutions/java-solutions/` пометьте как *Sources Root*.
5. Импортируйте библиотеку и модули.
    1. Зайдите в структуру проекта (`File` -> `Project Structure...`).
    2. Во вкладке `Project Settings` выберите `Libraries`.
        1. Нажмите на плюсик.
        2. В появившемся окне нажмите `Java`.
        3. Выберите директорию `tests/lib/`.
        4. В появившемся окне нажмите `OK`.
    3. Во вкладке `Project Settings` выберите `Modules`.
        1. Выберите под наименованием модуля `Dependencies`.
        2. Нажмите на верхний плюсик.
        3. В появившемся окне нажмите `Import Module`.
        4. Выберите директорию `tests/modules/info.kgeorgiy.java.advanced.base`.
        5. В появляющихся окнах подтверждаем создание.
        6. Добавим еще один модуль, также повторим действия пунктов **1**-**4** и выберем директорию `tests/modules/info.kgeorgiy.java.advanced.walk`.
    4. Все остальные модули добавляются также по пункту **`3`**.
6. Настройте зависимости модулей.
    1. Настройте базовый модуль.
        1. Выберите модуль `info.kgeorgiy.java.advanced.base`.
        2. В окне правее нажмем плюсик.
        3. В появившемся окне нажмите `Library`.
        4. Далее выберите добавленный ранее `lib`.
    2. Настройте модуль первого домашнего задания.
        1. Выберите модуль `info.kgeorgiy.java.advanced.walk`. Для него проделаем те же действия, что и для модуля `info.kgeorgiy.java.advanced.base`.
        2. Нажмите снова на плюсик и выберите `Module Dependency...`.
        3. В появившемся окне выберите модуль `info.kgeorgiy.java.advanced.base`.
    3. Настройте общий модуль.
        1. Выберите модуль `java-advanced`.
        2. Добавьте в зависимости все существующие модули, кроме модуля `info.kgeorgiy.java.advanced.base`, иначе будут проблемы при компиляции.
    4. Все остальные модули добавляются также по пункту **`2`** и **`3`**. *Обратите внимание*: для некоторых домашних заданий/модулей понадобятся другие модули, помимо `info.kgeorgiy.java.advanced.base`.
7. Добавьте конфигурацию запуска.
    1. В поле **Name** зададим *ClassWalkTestWindows*, где префикс *Class* означает, что мы компилируем и запускаем тесты через классы; *WalkTest* - версию домашнего задания (easy/hard/bonus); суффикс *Windows* - тестирование проходит на Windows.
    2. В поле `module not specified` выберем версию JDK.
    3. В поле `-cp <no module>` выберем модуль `java-advanced`.
    4. В поле **Main class** мы положим полное название класса тестирования, например, *info.kgeorgiy.java.advanced.walk.Tester*.
    5. В поле **Program arguments** мы положим первым аргументом версию домашнего задания, вторым - полное название разработанного класса, например, *Walk info.kgeorgiy.ja.bakturin.walk.Walk*.

## Компиляция на Windows и запуск через классы на Ubuntu

1. Скачайте и установите [VirtualBox](https://www.virtualbox.org/wiki/Download_Old_Builds_6_1) и скачайте образ диска [Ubuntu Server](https://ubuntu.com/download/server).
2. Установка операционной системы *Ubuntu Server*
    * Создание новой машины, **`New`**.
        * в поле **Name** зададим имя машины, например, *JRunner*.
        * в поле **Type** выберем `Linux`.
        * в поле **Version** выставим `Ubuntu (64-bit)` или `Ubuntu (32-bit)`.
    * Далее нажимаете всё время `Next`. Из интересного стоит выделить количество места для операционной системы - хватает и 10 ГБ (утверждается, что можно поставить чуть поменьше).
    * Настройка виртуальной машины, **`Settings`**. В разделе *Storage*, в *Empty* нажмите на значок *диска* - *Choose a disk file* - выберите скачанный `.iso`.
    * Запуск виртуальной машины., **`Start`**. В разделе *Guided storage configuration* рекомендуется убрать пункт `Set up this disk as an LVM group`.
    * Во всех оставшихся разделах нажимаете всё `Next`, по дороге создайте пользователя и ничего лишнего не выбирайте для экономия места и времени.
3. Обновление операционной системы. Введите в терминале следующее:

    ```bash
    sudo apt update
    sudo apt upgrade -y
    ```

4. Установите все необходимые для дальнейшей работы *зависимости*

    ```bash
    sudo apt install -y openjdk-17-jdk-headless net-tools openssh-server
    ```

5. Выключите виртуальную систему (желательно, через команду `poweroff`) и зайдите в настройки: в разделе *Network* перед **Attached to** разверните список и выберите `Host-only Adapter`, это нужно, для того, чтобы IP-адрес, по которому будет якобы располагаться наш сервер, никогда не менялся, при этом, доступ к Интернету на виртуальной машине Вы потеряете.
6. Запустите машину и после входа в терминал введите следующее

    ```bash
    ifconfig
    ```

    Чуть ниже на одну строку и левее надписи `enp0s3` вы уведите IP-адрес после надписи `inet`. Запомните его.
7. Добавьте конфигурацию запуска.
    * В поле `**Name** зададим *ClassWalkTestLinux*, где префикс *Class* означает, что мы компилируем и запускаем тесты через классы; *WalkTest* - версию домашнего задания (easy/hard/bonus); суффикс *Linux* - тестирование проходит на Linux (Ubuntu Server).
    * Напротив **Run on** выберем `SSH`.
        * в появившемся окне, в поле **Host** мы вставим IP-адрес виртуальной машины, в поле **Username** вписываем заданный на этапе установки системы *username* для входа в систему;
        * далее, если появилось окно о предложении добавления SSH-ключа, значит, вы всё сделали правильно; в поле **Password** впишем пароль от *username* для входа в систему;
        * после успешной проверки нажимаем `Create` и тестирование на Ubuntu готово.
    * В поле `module not specified` выберем версию JDK.
    * В поле `-cp <no module>` выберем модуль `java-advanced`.
    * В поле **Main class** мы положим полное название класса тестирования, например, *info.kgeorgiy.java.advanced.walk.Tester*.
    * В поле **Program arguments** мы положим первым аргументом версию домашнего задания, вторым - полное название разработанного класса, например, *Walk info.kgeorgiy.ja.bakturin.walk.Walk*.
8. Для запуска системы *JRunner* без интерфейса можно воспользоваться скриптом [`vm-run.bat`](vm-run.bat). Обратите внимание, что в скрипте в качестве пути к программе выбран путь по умолчанию.

## Компиляция и запуск через тестирующие `jar`-файлы на Windows

1. Скачайте и установите, если не установлено, [Git Bash](https://git-scm.com/).
2. Добавьте в директорию проекта *java-advanced* скрипт [`start.sh`](start.sh).
3. Отредактируйте файл под Вашу настройку проекта:
    * В поле **SOLUTIONS** следует вписать путь-директорию к персональному репозиторию, то есть тот, по которому лежит `java-solutions`.
    * В поле **TESTS** следует вписать путь-директорию к репозиторию с тестами, то есть тот, по которому лежат `artifacts/`, `lib/`, `modules/`.
    * В поле **SURNAME** следует вписать Вашу фамилию, то есть то, что Вы подставляли вместо *\_\_last_name\_\_*.
4. Добавьте конфигурацию запуска.
    * В поле **Name** зададим *JarWalkTestGitBash*, где префикс *Jar* означает, что мы компилируем и запускаем тесты через .jar-файлы; *WalkTest* - версию домашнего задания (easy/hard/bonus); суффикс *GitBash* - тестирование проходит через приложение Git Bash.
    * В поле `Script path` укажите путь до файла *start.sh*.
    * В поле `Script options` укажите аргументы к скрипту:
        1. Наименование пакета, в котором лежит Ваше решение домашнего задания.
        2. Наименование пакета, в котором лежат тесты к домашнему заданию.
        3. "Чистое" наименование класса, являющийся Вашим решением домашнего задания, то есть, например, `Walk` или `RecursiveWalk`.
        4. Идёт наименование версии тестирования домашнего задания (easy/hard/bonus).

## Компиляция и запуск через тестирующие `jar`-файлы на подсистеме Windows для Linux

1. Активируйте соответствующие компоненты Windows.
    * Откройте *Панель управления*, далее *Все элементы панели управления* и *Программы и компоненты* и нажмите ***Включение и отключение компонентов Windows***.
    * В списке найдите пункт ***Подсистема Windows для Linux*** и убедитесь, что перед пунктом стоит галочка. В ином случае: поставьте, сохраните изменения и перезагрузите компьютер.
2. В Microsoft Store установите приложение ***Подсистема Windows для Linux***, запустите его, введите в терминал и перезагрузите компьютер:

    ```cmd
    wsl.exe --update
    wsl.exe --set-default-version 2
    ```

3. После установки по пути домашнего каталога текущего пользователя должен появится файл `.wslconfig`, в котором лежат основные глобальные настройки для WSL2. Содержимое `.wslconfig` предлагается установить таким:

    ```config
    [wsl2]
    nestedVirtualization=true
    memory=512MB
    processors=2
    ```

    Первые две строки должны быть по умолчанию после установки версии WSL на 2. Значение `memory` ограничивает подсистеме использование памяти; полезно, если у Вас старый компьютер/ноутбук. Значение `processors`, соответственно, на количество процессоров компьютера/ноутбука.
4. В Microsoft Store установите приложение ***Ubuntu 20.04.6 LTS*** (утверждается, что подойдет любой дистрибутив и любая LTS, поддерживающая JDK17), запустите его, проследуйте инструкциям установки и введите в терминал:

    ```bash
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y openjdk-17-jdk-headless
    ```

5. Добавьте в директорию проекта *java-advanced* скрипты [`start.sh`](start.sh) и [`start_wsl.bat`](start_wsl.bat).
6. Отредактируйте файл *start.sh* под Вашу настройку проекта:
    * В поле **SOLUTIONS** следует вписать путь-директорию к персональному репозиторию, то есть тот, по которому лежит `java-solutions`.
    * В поле **TESTS** следует вписать путь-директорию к репозиторию с тестами, то есть тот, по которому лежат `artifacts/`, `lib/`, `modules/`.
    * В поле **LAST_NAME** следует вписать Вашу фамилию, то есть то, что Вы подставляли вместо *\_\_last_name\_\_*.
7. Добавьте конфигурацию запуска.
    * В поле **Name** зададим *JarWalkTestWSL*, где префикс *Jar* означает, что мы компилируем и запускаем тесты через `.jar`-файлы; *WalkTest* - версию домашнего задания (easy/hard/bonus); суффикс *WSL* - тестирование проходит через WSL.
    * В поле `Script path` укажите путь до файла *start_wsl.bat*.
    * В поле `Script options` укажите аргументы к скрипту:
        1. Наименование пакета, в котором лежит Ваше решение домашнего задания.
        2. Наименование пакета, в котором лежат тесты к домашнему заданию.
        3. "Чистое" наименование класса, являющийся Вашим решением домашнего задания, то есть, например, `Walk` или `RecursiveWalk`.
        4. Идёт наименование версии тестирования домашнего задания (easy/hard/bonus).
