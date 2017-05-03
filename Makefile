build:
	docker build -t devops .
test: build
	docker run --entrypoint rspec \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PWD)/tests:/app-code/tests \
		-w /app-code/tests \
		devops spec/Dockerfile_spec.rb
