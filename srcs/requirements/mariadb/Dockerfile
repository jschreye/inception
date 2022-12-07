FROM 	alpine:3.14

# telecharge les nouveaux paqueage si besoin
RUN 	apk update

# telecharge mariadb et mysql-client sans retelechager les paquages deja installer
RUN 	apk add --no-cache --quiet --update mariadb mysql-client

COPY 	./conf/create_db.sql /tmp/create_db.sql

COPY	./tools/entrypoint.sh ./

COPY 	./conf/mariadb-server.cnf /etc/my.cnf.d/

RUN 	chmod +x ./entrypoint.sh

# cherche ou se trouve mysql et ensuite le run en tache de fond et demarre le serveur
RUN		mysql_install_db --datadir=/var/lib/mysql \
			--auth-root-authentication-method=normal

# Donne les droits de pouvoir lire/ecrire dans la db
RUN		chown -R mysql:mysql /var/lib/mysql 

# execute le scripte
ENTRYPOINT [ "sh", "entrypoint.sh" ]