# ==============================================================================
# Makefile - Expenser Landing Page
# ==============================================================================
# Robust makefile for development and production environments
# ==============================================================================

.PHONY: help dev dev-build dev-up dev-down dev-logs dev-restart dev-rebuild dev-shell prod prod-build prod-up prod-down prod-logs prod-restart prod-shell install lint build clean clean-all health check-docker check-docker-compose check-env-dev check-env-prod check-prerequisites-dev check-prerequisites-prod

# Variables
DOCKER_COMPOSE_DEV = docker compose -f docker-compose.development.yml
DOCKER_COMPOSE_PROD = docker compose -f docker-compose.production.yml
CONTAINER_DEV = expense-manager-landing-development
CONTAINER_PROD = expense-manager-landing-production

# Environment files
ENV_DEV := .env
ENV_PROD := .env.production

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

## help: Display this help message
help:
	@echo "$(GREEN)Expenser Landing - Makefile Commands$(NC)"
	@echo ""
	@echo "$(YELLOW)Development Commands:$(NC)"
	@echo "  make dev              - Start development environment (build + up)"
	@echo "  make dev-build        - Build development image"
	@echo "  make dev-up           - Start development containers"
	@echo "  make dev-down         - Stop development containers"
	@echo "  make dev-logs         - View development logs"
	@echo "  make dev-restart      - Restart development containers"
	@echo "  make dev-rebuild      - Rebuild and restart development containers"
	@echo "  make dev-shell        - Open shell in development container"
	@echo ""
	@echo "$(YELLOW)Production Commands:$(NC)"
	@echo "  make prod             - Start production environment (build + up)"
	@echo "  make prod-build       - Build production Docker image"
	@echo "  make prod-up          - Start production containers"
	@echo "  make prod-down        - Stop production containers"
	@echo "  make prod-logs        - View production logs"
	@echo "  make prod-restart     - Restart production containers"
	@echo "  make prod-shell       - Open shell in production container"
	@echo ""
	@echo "$(YELLOW)Local Development Commands:$(NC)"
	@echo "  make install          - Install dependencies locally"
	@echo "  make build            - Build static export locally"
	@echo "  make lint             - Run linter"
	@echo ""
	@echo "$(YELLOW)Utility Commands:$(NC)"
	@echo "  make clean            - Remove containers and volumes"
	@echo "  make clean-all        - Remove everything including images"
	@echo "  make health           - Check container health"
	@echo ""

# ============================================================================
# Prerequisite Checks
# ============================================================================

## check-docker: Check if Docker is installed and running
check-docker:
	@which docker >/dev/null 2>&1 || { echo "$(RED)❌ Error: Docker is not installed!$(NC)"; exit 1; }
	@docker info >/dev/null 2>&1 || { echo "$(RED)❌ Error: Docker daemon is not running!$(NC)"; exit 1; }
	@echo "$(GREEN)✅ Docker is installed and running$(NC)"

## check-docker-compose: Check if Docker Compose is available
check-docker-compose:
	@docker compose version >/dev/null 2>&1 || { echo "$(RED)❌ Error: Docker Compose is not available!$(NC)"; exit 1; }
	@echo "$(GREEN)✅ Docker Compose is available$(NC)"

## check-env-dev: Check if development environment file exists
check-env-dev:
	@if [ ! -f $(ENV_DEV) ]; then \
		echo "$(RED)❌ Error: $(ENV_DEV) not found!$(NC)"; \
		echo "$(YELLOW)Please create $(ENV_DEV) with required variables$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)✅ $(ENV_DEV) exists$(NC)"

## check-env-prod: Check if production environment file exists
check-env-prod:
	@if [ ! -f $(ENV_PROD) ]; then \
		echo "$(RED)❌ Error: $(ENV_PROD) not found!$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)✅ $(ENV_PROD) exists$(NC)"

## check-prerequisites-dev: Check all development prerequisites
check-prerequisites-dev: check-docker check-docker-compose check-env-dev

## check-prerequisites-prod: Check all production prerequisites
check-prerequisites-prod: check-docker check-docker-compose check-env-prod

# ============================================================================
# Development Commands
# ============================================================================

## dev: Start development environment
dev: check-prerequisites-dev dev-build dev-up

## dev-build: Build development Docker image
dev-build: check-prerequisites-dev
	@echo "$(GREEN)Building development image...$(NC)"
	$(DOCKER_COMPOSE_DEV) build

## dev-up: Start development containers
dev-up: check-prerequisites-dev
	@echo "$(GREEN)Starting development containers...$(NC)"
	$(DOCKER_COMPOSE_DEV) up -d
	@echo "$(GREEN)✅ Development environment is running!$(NC)"
	@echo "$(YELLOW)Landing page: http://localhost:8000$(NC)"

## dev-down: Stop development containers
dev-down:
	@echo "$(YELLOW)Stopping development containers...$(NC)"
	$(DOCKER_COMPOSE_DEV) down

## dev-logs: View development logs
dev-logs:
	$(DOCKER_COMPOSE_DEV) logs -f

## dev-restart: Restart development containers
dev-restart:
	@echo "$(YELLOW)Restarting development containers...$(NC)"
	$(DOCKER_COMPOSE_DEV) restart

## dev-rebuild: Rebuild and restart development
dev-rebuild: check-prerequisites-dev
	@echo "$(YELLOW)Rebuilding and restarting development...$(NC)"
	$(DOCKER_COMPOSE_DEV) down
	$(DOCKER_COMPOSE_DEV) build --no-cache
	$(DOCKER_COMPOSE_DEV) up -d

## dev-shell: Open shell in development container
dev-shell:
	docker exec -it $(CONTAINER_DEV) /bin/sh

# ============================================================================
# Production Commands
# ============================================================================

## prod: Start production environment
prod: check-prerequisites-prod prod-build prod-up

## prod-build: Build production Docker image
prod-build: check-prerequisites-prod
	@echo "$(GREEN)Building production image...$(NC)"
	$(DOCKER_COMPOSE_PROD) build

## prod-up: Start production containers
prod-up: check-prerequisites-prod
	@echo "$(GREEN)Starting production containers...$(NC)"
	$(DOCKER_COMPOSE_PROD) up -d
	@echo "$(GREEN)✅ Production environment is running!$(NC)"

## prod-down: Stop production containers
prod-down:
	@echo "$(YELLOW)Stopping production containers...$(NC)"
	$(DOCKER_COMPOSE_PROD) down

## prod-logs: View production logs
prod-logs:
	$(DOCKER_COMPOSE_PROD) logs -f

## prod-restart: Restart production containers
prod-restart:
	@echo "$(YELLOW)Restarting production containers...$(NC)"
	$(DOCKER_COMPOSE_PROD) restart

## prod-shell: Open shell in production container
prod-shell:
	docker exec -it $(CONTAINER_PROD) /bin/sh

# ============================================================================
# Local Development Commands
# ============================================================================

## install: Install dependencies locally
install:
	@echo "$(GREEN)Installing dependencies...$(NC)"
	npm install -g pnpm@9
	pnpm install

## build: Build production static export locally
build:
	@echo "$(GREEN)Building static export...$(NC)"
	pnpm build

## lint: Run linter
lint:
	@echo "$(GREEN)Running linter...$(NC)"
	pnpm run lint

# ============================================================================
# Utility Commands
# ============================================================================

## clean: Remove containers and volumes
clean:
	@echo "$(YELLOW)Cleaning up containers and volumes...$(NC)"
	$(DOCKER_COMPOSE_DEV) down -v 2>/dev/null || true
	$(DOCKER_COMPOSE_PROD) down -v 2>/dev/null || true
	@echo "$(GREEN)✅ Cleanup complete$(NC)"

## clean-all: Remove everything including images
clean-all: clean
	@echo "$(YELLOW)Removing Docker images...$(NC)"
	docker rmi expense-manager-landing:development 2>/dev/null || true
	docker rmi expense-manager-landing:production 2>/dev/null || true
	@echo "$(GREEN)✅ All cleaned up$(NC)"

## health: Check container health
health:
	@echo "$(GREEN)Checking container health...$(NC)"
	@docker ps --filter name=expense-manager-landing --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
