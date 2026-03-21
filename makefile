dev:
	docker compose up --build

test:
	docker build --target test -t fastapi-test . && docker run --rm fastapi-test

prod:
	docker build --target prod -t fastapi-prod .