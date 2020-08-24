start_db:
	docker-compose up -d

stop_db:
	docker-compose stop

db_console:
	docker-compose exec db psql -U postgres
