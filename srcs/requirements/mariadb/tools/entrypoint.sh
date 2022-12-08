# controle si la bd est deja cree
cat .setup 2> /dev/null
# $? valeur de retour
if [ $? -ne 0 ]; then
	# & pour effectuer une "modification sur le serveur MySQL" - mysql driver avec des options
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &

	# attendre que la base de donnee soit bien accessible, mysql lance
	while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
    	sleep 1
	done

# execute le ficher sql dans mariadb et cree un fichier .setup pour confirmer qu il la bien cree et eviter de le refaire  
	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
	touch .setup
fi
# Lancement du serveur mysql de facon la plus securisee sur Uinix
usr/bin/mysqld_safe --datadir=/var/lib/mysql