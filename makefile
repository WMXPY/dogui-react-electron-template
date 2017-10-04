ifeq ($(OS),Windows_NT)
	UNAME := win32
else
	UNAME := $(shell uname)
endif

DRET : both

install :
	npm install
	npm install --only=dev

electron :
ifeq ($(UNAME), win32)
	.\node_modules\.bin\babel src/main --copy-files --source-maps --plugins=transform-es2015-modules-commonjs --extensions .es6,.es --out-dir build/main
	.\node_modules\.bin\electron .
else
	./node_modules/.bin/babel src/main --copy-files --source-maps --plugins=transform-es2015-modules-commonjs --extensions .es6,.es --out-dir build/main
	./node_modules/.bin/electron .
endif

renderer :
ifeq ($(UNAME), win32)
	.\node_modules\.bin\webpack-dev-server --config webpack.dev.js --open
else
	./node_modules/.bin/webpack-dev-server --config webpack.dev.js --open
endif
	
main :
ifeq ($(UNAME), win32)
	.\node_modules\.bin\electron .
else
	./node_modules/.bin/electron .
endif

both :
ifeq ($(UNAME), win32)
	.\node_modules\.bin\concurrently ".\node_modules\.bin\electron ." ".\node_modules\.bin\webpack-dev-server --config webpack.dev.js --open"
else
	./node_modules/.bin/concurrently "./node_modules/.bin/electron ." "./node_modules/.bin/webpack-dev-server --config webpack.dev.js --open"
endif

deploy :
ifeq ($(UNAME), win32)
	.\node_modules\.bin\electron-builder
else
	./node_modules/.bin/electron-builder
endif
	
clean :
ifeq ($(UNAME), win32)
else
	rm -rf build/main/*.js build/main/*.js.map  build/renderer/*.js build/renderer/*.js.map  build/renderer/*.html dist
endif
	