build:
	docker build -t devops-fat .
publish:
	docker tag devops-fat sebradloff/devops-fat
	docker push sebradloff/devops-fat:latest
	docker rmi sebradloff/devops-fat
test: build
	docker run --entrypoint rspec \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PWD)/tests:/app-code/tests \
		-w /app-code/tests \
		devops-fat spec/Dockerfile_spec.rb
local-test:
	docker run --entrypoint rspec \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PWD)/tests:/app-code/tests \
		-w /app-code/tests \
		devops-fat spec/Dockerfile_spec.rb
