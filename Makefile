#!make

NVM_DIR = ${NVM_DIR}
NODE_VERSION = v21.6.1
BREW = /usr/bin/ruby -e "$(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
TOOLS = autoconf automake libtool actionlint mockery
RM = rm -rf

.PHONY: prereqs clean cleanLock build start

#######################################################
# Pre-Requisites Scripts (normally only run once per machine)
#######################################################
prereqs:
# NVM & Node
    @./scripts/nvm.sh
    @. $(NVM_DIR)/nvm.sh && nvm use $(NODE_VERSION)

# Homebrew
    @echo
    @echo "****** Installing Homebrew ******"
    @echo "****** https://docs.brew.sh/Installation ******"
    @echo
    @$(BREW)
    @brew update && brew upgrade && brew cleanup

# Tools
    @echo
    @echo "****** Installing Tools ******"
    @echo
    @brew install $(TOOLS)
    @echo
    @echo "****** Installing rimraf ******"
    @echo
    @npm install rimraf

#######################################################
# Clean Up Scripts
#######################################################
clean:
    @echo "****** Cleaning local build, cache and dependency files ******"
    @find . -type d -name node_modules -exec $(RM) '{}' +
    @find . -type f \( -name .eslintcache \) -delete
    @npx rimraf node_modules
    @npm cache clean --force
    @npm cache verify
    @$(RM) node_modules
    @$(RM) coverage reports

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