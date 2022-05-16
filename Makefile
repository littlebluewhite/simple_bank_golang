postgres:
	docker run --name testpostgres -p 5432:5432 -v postgres_volume:/var/lib/postgresql/data -v C:/Users/wwils/Documents/docker/mysql:/storage -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -d postgres:latest

createdb:
	docker exec -it testpostgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it testpostgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlcGenerate:
	docker run --rm -v C:\Users\wwils\Documents\project\simple_bank_golang:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migratedown migrateup, sqlcGenerate