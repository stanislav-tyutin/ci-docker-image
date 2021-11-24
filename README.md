# ci-docker-image

A Docker image meant for use with CI/CD pipelines

## Supported CI Systems

Assuming a Docker image can be run as a CI task with environment variables
injected, the following CI systems will have their variables automatically
detected:

- [circleci](https://circleci.com/)
- [cloudbees](https://www.cloudbees.com/)
- [drone](https://www.drone.io/)
- [github actions](https://github.com/features/actions)
- [gitlab-ci](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/)
- [semaphoreci](https://semaphoreci.com/)
- [travisci](https://travis-ci.com/)

## Usage

This image provides two binaries for external usage:

- `dokku-deploy`: Triggers an app deploy at the configured `GIT_REMOTE_URL`
- `dokku-unlock`: Unlocks deploys for an app at the configured `GIT_REMOTE_URL`
- `dokku-config`: Configures environment variables for an app from `ENV_CONTENT` or from encrypted file

To run either binary, the following `docker` command can be used from a
directory containing a non-shallow clone of the repository being deployed:

```shell
# where the `.env` file contains `GIT_REMOTE_URL` and `SSH_PRIVATE_KEY`

# deploy
docker run --rm -v="$PWD:/app" --env-file=.env dokku/ci-docker-image dokku-deploy

# unlock
docker run --rm -v="$PWD:/app" --env-file=.env dokku/ci-docker-image dokku-unlock
```

## Configuration

The following environment variables are supported:

- `BRANCH`:
  - description: The branch to deploy when pushing to Dokku
  - required: false
  - default: ''master
- `CI_BRANCH_NAME`
  - description: The branch name that triggered the deploy. Interpolated if unavailable.
  - required: false
  - default: ''
- `CI_COMMIT`
  - description: The commit sha that will be pushed. Interpolated if unavailable.
  - required: false
  - default: ''
- `COMMAND`:
  - description: The command to run for the action
  - required: false
  - default: 'deploy'
- `GIT_REMOTE_URL:`
  - description: The dokku app's git repository url (in SSH format)
  - required: true
- `GIT_PUSH_FLAGS:`
  - description: A string containing a set of flags to set on push
  - required: false
- `REVIEW_APP_NAME`:
  - description: The name of the review app to create or destroy
  - required: false
  - default: 'review-$APP_NAME-$CI_BRANCH_NAME'
- `SSH_HOST_KEY`:
  - description: The results of running `ssh-keyscan -t rsa $HOST`
  - required: false
  - default: ''
- `SSH_PRIVATE_KEY`:
  - description: A private SSH key that has push acces to your Dokku instance
  - required: true
- `ENV_CONTENT`:
  - description:
  - required: false
  - default: ''
- `ENC_ENV_FILE`:
  - description:
  - required: false
  - default: ''
- `ENC_ENV_PASSWORD`:
  - description:
  - required: false
  - default: ''

## Building

```text
docker build dokku/ci-docker-image .
```
