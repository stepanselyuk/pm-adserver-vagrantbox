#!/usr/bin/env bash

# prepare & install db
mysql -e "GRANT ALL ON *.* TO ''@'localhost';"
mysql -e "DROP DATABASE IF EXISTS test"
mysql -e "UPDATE mysql.user SET Password = PASSWORD('123456') WHERE User = 'root'"
mysql -e "FLUSH PRIVILEGES"