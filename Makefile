all:


devserver:
	adev runserver mk --livereload --debug-toolbar -p 2600 --app-factory get_application
.PHONY: devserver


lint:
	mypy --ignore-missing-imports mk
.PHONY:lint
