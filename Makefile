all: css

SASS = sass _3.2.9_
INPUT = _sass/hecticjeff.scss
OUTPUT = css/hecticjeff.css

css:
	$(SASS) $(INPUT) $(OUTPUT)

watch:
	$(SASS) --watch $(INPUT):$(OUTPUT)

.PHONY: css watch
