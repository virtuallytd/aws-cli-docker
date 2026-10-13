# AWS CLI Docker Image

Multi-arch Docker image for the AWS CLI v2, supporting both `amd64` and `arm64` (Apple Silicon).

Published to GitHub Container Registry: `ghcr.io/virtuallytd/aws-cli-docker`

## Usage

### Using credentials file

Configure credentials interactively:

```
docker run --rm -it -v $HOME/.aws:/root/.aws ghcr.io/virtuallytd/aws-cli-docker configure
```

Then run commands with your saved credentials:

```
docker run --rm -v $HOME/.aws:/root/.aws ghcr.io/virtuallytd/aws-cli-docker s3 ls
```

### Using environment variables

```
docker run --rm \
  -e AWS_ACCESS_KEY_ID=my-key-id \
  -e AWS_SECRET_ACCESS_KEY=my-secret-access-key \
  -v $(pwd):/aws \
  ghcr.io/virtuallytd/aws-cli-docker s3 ls
```

### Shell alias

Set up `aws` as an alias so the container is transparent:

```
alias aws='docker run --rm -it -v $HOME/.aws:/root/.aws -v $(pwd):/aws ghcr.io/virtuallytd/aws-cli-docker'
```

## Building locally

```bash
# Build for your current architecture
docker build -t aws-cli .

# Build with a specific CLI version
docker build --build-arg CLI_VERSION=2.37.13 -t aws-cli .

# Multi-arch build
docker buildx build --platform linux/amd64,linux/arm64 -t aws-cli .
```

## CI/CD

- **Build workflow** (`.github/workflows/build.yml`): Builds and pushes multi-arch images to GHCR on every push to `master`. PRs get a build check without pushing.
- **Update workflow** (`.github/workflows/update-cli.yml`): Runs daily at 08:00 UTC to check for new AWS CLI v2 releases. Opens a PR automatically when a new version is found.
