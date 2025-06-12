#!/bin/bash

# Параметры подключения к базе данных
DB_USER="postgres"  # Пользователь PostgreSQL
DB_NAME="dostup"  # Имя базы данных
BACKUP_DIR="/opt/dostup-server/backup"  # Папка для хранения бэкапов
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S)"  # Имя файла с датой и временем

# Создание папки для бэкапов, если не существует
mkdir -p $BACKUP_DIR

# Выполнение бэкапа с помощью pg_dump
pg_dump -U $DB_USER $DB_NAME > $BACKUP_FILE

# Проверка успешности выполнения
if [ $? -eq 0 ]; then
  echo "Бэкап успешно создан: $BACKUP_FILE"
else
  echo "Ошибка при создании бэкапа"
  exit 1
fi

# (Опционально) Удаление старых бэкапов (например, старше 7 дней)
find $BACKUP_DIR -name "backup_*.sql" -mtime +7 -delete
