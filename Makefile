PARTS := $(sort $(wildcard parts/*.md))

primer.md: $(PARTS)
	@for f in $(PARTS); do \
		sed '/^<!--/,/^-->$$/d' "$$f" | sed '/./,$$!d'; \
		echo; \
	done | sed '$${/^$$/d}' > $@

.PHONY: check
check: primer.md
	@git diff --exit-code -- primer.md || \
		{ echo "primer.md is out of date: run make and commit it"; exit 1; }
