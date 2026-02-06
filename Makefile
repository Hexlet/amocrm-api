STL_PROJECT ?= amocrm
STL_BRANCH ?= main

.PHONY: setup update compile-openapi publish stl-build-ruby stl-build-ruby-pull

setup:
	pnpm install

update:
	npx ncu -u
	pnpm update

compile-openapi:
	pnpm exec tsp compile .

publish:
	stl builds create --branch main # --pull # --allow-empty 

# Non-interactive build trigger for Ruby SDK generation.
stl-build-ruby:
	stl builds create --project $(STL_PROJECT) --branch $(STL_BRANCH) --target ruby --oas tsp-output/schema/openapi.yaml --config .stainless/stainless.yml --allow-empty --wait=false

# Interactive local build + pull of generated Ruby SDK changes.
stl-build-ruby-pull:
	stl builds create --project $(STL_PROJECT) --branch $(STL_BRANCH) --target ruby --oas tsp-output/schema/openapi.yaml --config .stainless/stainless.yml --allow-empty --pull
