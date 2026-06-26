
.PHONY: setup update compile-openapi

setup:
	pnpm install

update:
	npx ncu -u
	pnpm update

compile-openapi:
	pnpm exec tsp compile .
