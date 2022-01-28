# RKD Challenge (Mariano Zalazar)

## Python Challenge

Guia para iniciar la base de datos y el script de carga:
- En el directorio python_challenge donde se encuentra el docker_compose.yml ejecutar el comando:
```
docker compose up -d
```
- Esperar unos segundos hasta que el container este activo.
- Una vez completado la inicializacion del container, para entrar dentro de la base de datos ejecutar el comando:
```
docker exec -it python_challenge-postgres-1 psql -U mariano -W test
```
- La contraseña es 'mariano'
- Una vez dentro ya podremos ejecutar codigo PSQL para navegar

## SQL Challenge

Guia para iniciar la base de datos y el script de carga:
- En el directorio sql_challenge donde se encuentra el docker_compose.yml ejecutar el comando:
```
docker compose up -d
```
- Esperar unos segundos hasta que el container este activo.
- Una vez completado la inicializacion del container, para entrar dentro de la base de datos ejecutar el comando:
```
docker exec -it sql_challenge-postgres-1 psql -U mariano -W meli
```
- La contraseña es 'mariano'
- Una vez dentro ya podremos ejecutar codigo PSQL para navegar
- Abriendo la carpeta scripts podremos copiar y pegar los ejercicios para comprobar su funcionamiento
