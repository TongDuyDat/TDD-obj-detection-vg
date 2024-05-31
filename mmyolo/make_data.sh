# !/bin/bash


URL1="https://cs.stanford.edu/people/rak248/VG_100K_2/images.zip"
URL2="https://cs.stanford.edu/people/rak248/VG_100K_2/images2.zip"

FILE1="images.zip"
FILE2="images2.zip"

GDRIVE_FILE_ID_FILE_IMG1="1hAJDDyVH1asiZgh0w21IPVJyPVewB7Ji"
GDRIVE_FILE_ID_FILE_IMG2="1aHM6xgDG7PL3igcKYO0bjLnES6UaOYlW"

gdown --id $GDRIVE_FILE_ID_FILE_IMG1
gdown --id $GDRIVE_FILE_ID_FILE_IMG2

GDRIVE_FILE="annotations.zip"

DEST_DIR="data/vg"

IMAGES_DIR="data/vg/images"

mkdir -p $DEST_DIR
mkdir -p $IMAGES_DIR


# wget -O $FILE1 $URL1

# if [ $? -eq 0 ]; then
#     echo "File $FILE1 đã được tải về thành công."
# else
#     echo "Có lỗi khi tải file $FILE1."
#     exit 1
# fi


unzip -o $FILE1 -d $DEST_DIR


# if [ $? -eq 0 ]; then
#     echo "File $FILE1 đã được giải nén thành công vào thư mục $DEST_DIR."
# else
#     echo "Có lỗi khi giải nén file $FILE1."
#     exit 1
# fi


# wget -O $FILE2 $URL2


# if [ $? -eq 0 ]; then
#     echo "File $FILE2 đã được tải về thành công."
# else
#     echo "Có lỗi khi tải file $FILE2."
#     exit 1
# fi


unzip -o $FILE2 -d $DEST_DIR


if [ $? -eq 0 ]; then
    echo "File $FILE2 đã được giải nén thành công vào thư mục $DEST_DIR."
else
    echo "Có lỗi khi giải nén file $FILE2."
    exit 1
fi


find $DEST_DIR -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec mv {} $IMAGES_DIR \;


if [ $? -eq 0 ]; then
    echo "Tất cả các ảnh đã được di chuyển vào thư mục $IMAGES_DIR."
else
    echo "Có lỗi khi di chuyển các ảnh."
    exit 1
fi

echo "Quá trình tải, giải nén và di chuyển ảnh hoàn tất."

# URL tải file từ Google Drive
curl "https://public.bl.files.1drv.com/y4mMl49S8HqWbiyj829OZTrA5TQR4NpdxRnajEwLY_gaN9fkzxofzxi11BMwDXrF3DyDsCGywtW6jo6zwgbDunWmtcq7NSeSJHQoCpEOX0YuxUqvmktYaLvgzpefSdEiFaixXtI3K9AoG2VoIhYHj7808S_0JipQnxAQcQYNw0EUNHeNWUjZN9Be5gsAPCOUovGX_tv2gVEUPExplFwxf_4tr2a9Ujebc61XiTlN4tGAgs?AVOverride=1"  --output $GDRIVE_FILE
unzip -o $GDRIVE_FILE -d $DEST_DIR

rm -f $FILE1 $FILE2 $GDRIVE_FILE

#!/usr/bin/env bash

