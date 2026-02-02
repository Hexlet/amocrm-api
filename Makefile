setup:
	pnpm install

update:
	npx ncu -u
	pnpm update

compile-openapi:
	pnpm exec tsp compile .

publish:
	stl builds create --branch main # --pull # --allow-empty 
