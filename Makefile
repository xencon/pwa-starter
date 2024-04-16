#!make

NODE_VERSION = v21.6.1
HOMEBREW_INSTALL_SCRIPT = https://raw.githubusercontent.com/Homebrew/install/master/install
TOOLS = autoconf automake libtool
ACTIONLINT = actionlint
MOCKERY = mockery
RIMRAF = rimraf

#######################################################
# Pre-Requisites Scripts (normally only run once per machine)
#######################################################
prereqs:
# NVM & Node
	@./scripts/nvm.sh
	@. ${NVM_DIR}/nvm.sh && nvm use $(NODE_VERSION)

# Homebrew
	@echo
	@echo "****** Installing Homebrew ******"
	@echo "****** https://docs.brew.sh/Installation ******"
	@echo
	@/usr/bin/ruby -e "$(curl -fsSL $(HOMEBREW_INSTALL_SCRIPT))"
	@brew update
	@brew upgrade
	@brew cleanup

# Tools
	@echo
	@echo "****** Installing Tools ******"
	@echo
	@brew install $(TOOLS)
	@echo
	@echo "****** Installing ActionLint ******"
	@echo
	@brew install $(ACTIONLINT)
	@echo
	@echo "****** Installing mockery ******"
	@echo
	@brew install $(MOCKERY)
	@echo
	@echo "****** Installing rimraf ******"
	@echo
	@npm install $(RIMRAF)

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