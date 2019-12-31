# Bash snippets
## Docker
### Bulld
Build Docker image from local Dockerfile with name and tag ubuntu:mine

``` docker build -t ubuntu:mine .```

### Run
Run Docker image ubuntu:mine interactive /bin/bash, don't keep changes and mount local directory to /project

```docker run --rm -it -v $(pwd -P |sed 's#/mnt##'):/project ubuntu:mine /bin/bash```

