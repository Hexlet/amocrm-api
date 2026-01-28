compile:
	pnpm exec tsp compile .

publish:
	stl builds create --branch main
