.DEFAULT_GOAL: init

init:
	make drop-cache
	
drop-cache:
	chmod -R 777 var/

drop-db:
	rm -rf database/

start:
	docker compose --env-file .env.local up

down: 
	docker compose down