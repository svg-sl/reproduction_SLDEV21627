# reproduction_SLDEV21627 - gunicorn coverage issue

Problem:

When gunicorn app starts up, a unit test stage is always opened, even when no unit test stage is configured/no unit tests exist. 

Component test stage is opened via command, but coverage is always 0%, potentially because there is always a unit test stage opened at the same time.

To Reproduce:

Reproduction assumes running the project locally with pipenv and Docker.

```bash
# initialize the project locally
pipenv install --dev

# Run sl-python config on the project
pipenv run sl-python config --appname c1-test/tryout-python-fargate-gunicorn --branchname 16April2025 --buildname 001 --exclude "*venv*,*tests*" --token $SL_TOKEN_POC

# Run sl-python scan
pipenv run sl-python scan --buildsessionidfile buildSessionId.txt --token $SL_TOKEN_POC --scm none

# Build the docker image
docker build -t c1-reproduction/gunicorn:002 .

# Run the docker container. Unit Test stage is opened automatically
docker run -it -p 8080:8080 c1-reproduction/gunicorn:002

```

Any time the gunicorn app is running, the unit test stage is open.

Opening a component test stage works, but coverage is not correctly shown:

```bash
# While the container is still running, start a test stage. In the dashboard, see both the Unit Test stage and the Component test stage are open

# Run a test
curl localhost:8080/example 
curl localhost:8080/health

# Close the test stage
pipenv run sl-python end --token $SL_TOKEN_POC
```
