# TetraCube Backend

## Sign key creation
```shell
openssl genrsa -out rsaPrivateKey.pem 2048
openssl rsa -pubout -in rsaPrivateKey.pem -out publicKey.pem
openssl pkcs8 -topk8 -nocrypt -inform pem -in rsaPrivateKey.pem -outform pem -out privateKey.pem
```

## Containers initialization

### Database container

In first instance you need create a volume for database to persist data over containers construction/
destruction

```shell
podman volume create db-data-volume
```

Then the network to interact between the services

```shell
podman network create tetracube-net
```

Launch PostgreSQL database, ensure to change password, other parameters **must remain the same**.
Bind the `5432` port on your local machine if you want interact for various reasons with db with bare metal 
machine.

```shell
podman run --name tetracube-db \
  -e POSTGRES_PASSWORD=changeme \
  -e POSTGRES_USER=tetracube_usr \
  -e POSTGRES_DB=tetracube_db \
  -p 5432:5432 \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v db-data-volume:/var/lib/postgresql/data \
  --network tetracube-net \
  -d postgres
```

Finally run sql query scripts contained in **sql_scripts** to initialize the database 