# Docker Compose command
DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml

# Volume directories
VOLUME_DIR = /Users/aguediri/Documents/GitHub/inception/volumes

# Default target
all: up

# Target to create necessary directories
create_dirs:
	@echo "Creating volume directories..."
	@mkdir -p ${VOLUME_DIR}/mariadb
	@mkdir -p ${VOLUME_DIR}/wordpress

# Build target
build: create_dirs
	@echo "Building Docker containers..."
	${DOCKER_COMPOSE} build

# Up target
up: build
	@echo "Starting Docker containers..."
	${DOCKER_COMPOSE} up

# Down target
down:
	@echo "Stopping and removing Docker containers..."
	${DOCKER_COMPOSE} down

# Stop target
stop:
	@echo "Stopping Docker containers..."
	${DOCKER_COMPOSE} stop

# Start target
start:
	@echo "Starting Docker containers..."
	${DOCKER_COMPOSE} start

# Clean target
clean:
	@echo "Cleaning up Docker containers and volumes..."
	@docker rm -f mariadb wordpress nginx
	@docker rmi -f mariadb wordpress nginx
	@docker volume rm $(shell docker volume ls -q)
	@docker system prune -a -f

# Rebuild target
re: clean all

# Restart target
restart:
	@echo "Restarting Docker containers..."
	${DOCKER_COMPOSE} restart

# Phony targets
.PHONY: all build up down stop start clean re restart create_dirs
