#!make

#######################################################
# Pre-Requisites Scripts (normally only run once per machine)
#######################################################
prereqs:
# NVM & Node
	@./scripts/nvm.sh
	@. ${NVM_DIR}/nvm.sh && nvm use 20

# Homebrew
	@echo
	@echo "****** Installing Homebrew ******"
	@echo "****** https://docs.brew.sh/Installation ******"
	@echo
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew update
	@brew upgrade
	@brew cleanup

# Tools
	@echo
	@echo "****** Installing Tools ******"
	@echo
	@brew install autoconf automake libtool
	@echo
	@echo "****** Installing ActionLint ******"
	@echo
	@brew install actionlint
	@echo
	@echo "****** Installing mockery ******"
	@echo
	@brew install mockery

# Yarn
	@echo
	@echo "****** Installing Yarn ******"
	@echo
	@brew install yarn

# Jest
	@echo
	@echo "****** Installing Jest ******"
	@echo
	@yarn add --dev jest

# Cypress
	@echo
	@echo "****** Installing Cypress ******"
	@echo
	@yarn add cypress @cypress/react @cypress/webpack-dev-server --dev

#######################################################
#######################################################
#######################################################
# Clean Up Scripts
#######################################################
clean:
	@echo "****** Cleaning local build, cache and dependency files ******"
	@yarn nx run-many --all --target=clean
	@yarn nx clear-cache
	@rm -rf node_modules
	@rm -rf coverage reports
	@find . -type d -name node_modules -exec rm -rf '{}' +
	@find . -type f \( -name .eslintcache \) -delete

cleanLock:
	@echo "****** Cleaning lock files ******"
	@find . -type f \( -name *.lock -o -name *-lock.json \) -delete

#######################################################
# Lint Scripts
#######################################################
typecheck:
	@echo "****** Typechecking All Packages ******"
	@yarn nx run-many --all --target=typecheck
	
prettier:
	@yarn prettier . --write

#######################################################
# Test Scripts
#######################################################

testUnit:
	@echo "****** Testing All Packages ******"
	@yarn nx run-many --all --target=testUnit

testApi:
	@echo "****** Running API Tests ******"
	@cd packages/test-api && yarn testApi

teste2e:
	@echo "****** Running End-to-End Tests ******"
	@cd packages/test-ui && yarn test-e2e-pr-app

#######################################################
# Build & Run Scripts
#######################################################
build:
	@echo "****** Building Portable Web Application ******"
	@yarn

start:
	@echo "****** Starting Portable Web Application ******"
	@pwa start

#######################################################
# Github Action Scripts
#######################################################

lintWorkflows:
	@echo
	@echo "****** Linting Github Actions Workflows ******"
	@actionlint

generateWorkflows:
	@echo
	@echo "****** Generating Github Actions Workflows ******"
	@rm -rf .github/workflows/*
	@cd packages/noah-cicd && yarn gen
	@make lintWorkflows

prepr: install lint typecheck testUnit prettier
