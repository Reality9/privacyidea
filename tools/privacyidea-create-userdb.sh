#!/bin/bash
DATABASE=/etc/privacyidea/users.sqlite
echo "create table users (id INTEGER PRIMARY KEY ,\
	username TEXT UNIQUE,\
	surname TEXT, \
	givenname TEXT, \
	email TEXT, \
	password TEXT, \
	description TEXT, \
	mobile TEXT, \
	phone TEXT);" | sqlite3 $DATABASE

cat <<END > /etc/privacyidea/usersdb.install
{'Server': '/',
 'Driver': 'sqlite',
 'Database': '/etc/privacyidea/users.sqlite',
 'Table': 'users',
 'Limit': '500',
 'Editable': '1',
 'Map': '{"userid": "id", "username": "username", "email":"email", "password": "password", "phone":"phone", "mobile":"mobile", "surname":"name", "givenname":"givenname", "description": "description"}'
}
END
chown privacyidea $DATABASE

pi-manage.py resolver create localusers sqlresolver /etc/privacyidea/usersdb.install
pi-manage.py realm create localsql localusers
