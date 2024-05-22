#!/bin/bash
# ловим ошибки и прекращаем выполнение скрипта
set -e
# Определяем переменные для путей
BASE_DIR="task"
DIR1="${BASE_DIR}/dir1"
DIR2="${BASE_DIR}/dir2"
DIR3="${BASE_DIR}/dir3"
DIR4="${DIR3}/dir4"
EMPTY_FILE="${DIR2}/empty"
HELLO_SCRIPT="${DIR2}/hello.sh"
LIST_FILE="${DIR2}/list.txt"
SUMMARY_FILE="${DIR1}/summary.txt"
FINAL_FILE="${BASE_DIR}/Практическое задание"
# создаём каталог task с вложенными директориями
# task
#   dir1
#   dir2
#   dir3
#       dir4
mkdir -p "$DIR1"
mkdir -p "$DIR2"
mkdir -p "$DIR4"
# изменяем текущую директорию на task
cd "$BASE_DIR"
# создаём пустой файл task/dir2/empty
touch "$EMPTY_FILE"
# создаём файл task/dir2/hello.sh с таким содержанием:
# #!/bin/bash
# echo "$1, привет!"
cat << 'EOF' > "$HELLO_SCRIPT"
#!/bin/bash
echo "$1, привет!"
EOF
# устанавливаем для task/dir2/hello.sh права rwxrw-r--
chmod 764 "$HELLO_SCRIPT"
# сохраняем список файлов task/dir2 в task/dir2/list.txt
ls "$DIR2" > "$LIST_FILE"
# копируем содержимое каталога task/dir2 в каталог task/dir3/dir4
cp -r "$DIR2"/* "$DIR4/"
# записываем в task/dir1/summary.txt список файлов с расширением *.txt
# находящихся в task, включая поддиректории
find . -type f -name "*.txt" > "$SUMMARY_FILE"
# дописываем в task/dir1/summary.txt содержимое task/dir2/list.txt
cat "$LIST_FILE" >> "$SUMMARY_FILE"
# определяем переменную окружения NAME со значением "Всем студентам"
export NAME="Всем студентам"
# запускаем task/dir2/hello.sh с переменной окружения NAME в качестве аргумента
# вывод скрипта должен дописаться в файл task/dir1/summary.txt
./"$HELLO_SCRIPT" "$NAME" >> "$SUMMARY_FILE"
# перемещаем с переименованием task/dir1/summary.txt в task/Практическое задание
# перемещаем с переименованием task/dir1/summary.txt в task/Практическое задание
mv "$SUMMARY_FILE" "$FINAL_FILE"
# выводим на консоль содержимое файла task/Практическое задание
cat "$FINAL_FILE"
# ищем в файле "Практическое задание" строки, которые содержат слово "dir"
# и затем отсортировываем их
grep "dir" "$FINAL_FILE" | sort
# меняем текущую директорию на родительскую для task
cd ..
# удаляем директорию task со всем содержимым
rm -rf "$BASE_DIR"