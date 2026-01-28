compile-openapi:
	pnpm exec tsp compile .

publish:
	stl builds create --branch main --pull # --allow-empty 
