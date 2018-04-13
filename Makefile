
NODE = node --harmony
BABEL = ./node_modules/.bin/babel
MOCHA = node --harmony node_modules/.bin/mocha --reporter spec --require test/setup.js --compilers js:babel-core/register
ESLINT = node_modules/.bin/eslint --config '.eslintrc.js' --ignore-pattern '!.eslintrc.js'
NPM_ENV_VARS = npm_config_registry=https://registry.npmjs.org
NPM = $(NPM_ENV_VARS) npm
XYZ = $(NPM_ENV_VARS) node_modules/.bin/xyz --repo git@github.com:pbernasconi/react-plaid-link.git

TEST_FILES = $(shell find test -name '*.js' | sort)
SRC_FILES  = $(shell find src -name '*.js' | sort)


.PHONY: build
build:
	@mkdir -p dist
	@$(BABEL) "./src/PlaidLink.js" > "./dist/PlaidLink.js"


.PHONY: clean
clean:
	@rm -rf dist


.PHONY: lint
lint:
	@$(ESLINT) -- $(SRC) $(TEST_FILES) .eslintrc.js


.PHONY: lint-fix
lint-fix:
	@$(ESLINT) --fix -- $(LINT_FILES) .eslintrc.js

.PHONY: setup
setup:
	@$(NPM) install


.PHONY: start
start:
	@$(NODE) server.js


.PHONY: test
test:
	@$(MOCHA) -- test/components/PlaidLink.spec.js


.PHONY: release-major release-minor release-patch
release-major release-minor release-patch: build
	@$(XYZ) --increment $(@:release-%=%)
