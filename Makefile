all: css

SASS = sass _3.2.14_
STYLE = compressed
INPUT = _sass/hecticjeff.scss
OUTPUT = css/hecticjeff.css

css:
	$(SASS) --style $(STYLE) $(INPUT) $(OUTPUT)

watch:
	$(SASS) --style $(STYLE) --watch $(INPUT):$(OUTPUT)

.PHONY: css watch
