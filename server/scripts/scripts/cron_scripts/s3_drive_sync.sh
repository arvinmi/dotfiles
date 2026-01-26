#!/bin/sh

# s3_drive-documents

rsync -av --delete-before "${HOME}/Documents/" "/mnt/data/backup/Documents"

# s3_drive-build

rsync -av --delete-before "${HOME}/build/" "/mnt/data/backup/build"

# s3_drive-personal

rsync -av --delete-before "${HOME}/personal/" "/mnt/data/backup/personal"