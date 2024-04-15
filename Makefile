#!make

#######################################################
# Pre-Requisites Scripts (normally only run once per machine)
#######################################################
prereqs:
# NVM & Node
	@if [ -z "$$(which nvm)" ]; then ./scripts/nvm.sh; fi
	@. ${NVM_DIR}/nvm.sh && nvm use v21.6.1 || echo "Failed to switch to Node v21.6.1"

# Homebrew
	@if [ -z "$$(which brew)" ]; then \
		echo "****** Installing Homebrew ******"; \
		echo "****** https://docs.brew.sh/Installation ******"; \
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; \
	fi
	@brew update || echo "Failed to update Homebrew"
	@brew upgrade || echo "Failed to upgrade Homebrew"
	@brew cleanup || echo "Failed to cleanup Homebrew"

# Tools
	@echo "****** Installing Tools ******"
	@brew install autoconf automake libtool || echo "Failed to install tools"

# ActionLint
	@echo "****** Installing ActionLint ******"
	@brew install actionlint || echo "Failed to install ActionLint"

# Mockery
	@echo "****** Installing mockery ******"
	@brew install mockery || echo "Failed to install Mockery"#!make

#######################################################
# Pre-Requisites Scripts (normally only run once per machine)
#######################################################
prereqs:
# NVM & Node
	@./scripts/nvm.sh
	@. ${NVM_DIR}/nvm.sh && nvm use v21.6.1

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
	@echo
	@echo "****** Installing rimraf ******"
	@echo
	@npm install rimraf

#######################################################
# Clean Up Scripts
#######################################################
clean:
	@echo "****** Cleaning local build, cache and dependency files ******"
	@find . -type d -name node_modules -exec rm -rf '{}' +
	@find . -type f \( -name .eslintcache \) -delete
	@npx rimraf node_modules
	@npm cache clean --force
	@npm cache verify
	@rm -rf node_modules
	@rm -rf coverage reports

cleanLock:
	@echo "****** Cleaning lock files ******"
	@find . -type f \( -name *.lock -o -name *-lock.json \) -delete

#######################################################
# Build & Run Scripts
#######################################################
build:
	@echo "****** Building Portable Web Application ******"
	@npm install

start:
	@echo "****** Starting Portable Web Application ******"
	@pwa start
