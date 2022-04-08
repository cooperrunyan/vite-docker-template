current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
project_name := vite-docker-react
image_name := app

dev:
	docker-compose -f ./docker-compose.dev.yaml --env-file ./.env up --build --abort-on-container-exit --remove-orphans

start:
	@echo "Stopping any pre-existing version of this image"
	$(MAKE) stop

	@echo "Building image"
	docker-compose build

	@echo "Starting image"
	docker-compose up --detach  --remove-orphans

	$(MAKE) logs

stop:
	docker-compose down
	docker volume rm $(current_dir)_app_node_modules 2>/dev/null || true

logs:
	docker-compose logs --follow

# Prettifying tools
better:
	@echo "Running Prettier on ./src files"
	$(MAKE) pretty

	@echo "Running ESLint on ./src files"
	$(MAKE) lint

	@echo "Running tests"
	$(MAKE) test

pretty:
	prettier * --config ./.prettierrc --ignore-path ./.prettierignore --write --no-error-on-unmatched-pattern

lint:
	npx eslint src -c .eslintrc --ext .ts,.tsx,.js,.jsx,.json --fix

test:
	npx jest

term:
	docker exec -it $(project_name)_$(image_name)_1 /bin/sh
