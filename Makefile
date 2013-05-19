all: css

SASS = sass _3.2.9_
STYLE = expanded
INPUT = _sass/hecticjeff.scss
OUTPUT = css/hecticjeff.css

css:
	$(SASS) --style $(STYLE) $(INPUT) $(OUTPUT)

watch:
	$(SASS) --style $(STYLE) --watch $(INPUT):$(OUTPUT)

.PHONY: css watch
