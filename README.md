# Bash snippets
## Docker
### Bulld
Build Docker image from local Dockerfile with name and tag ubuntu:mine

``` docker build -t ubuntu:mine .```

### Run
Run Docker image ubuntu:mine interactive /bin/bash, don't keep changes and mount local directory to /project
From Linux etc.:

```docker run --rm -it -v $(pwd -P |sed 's#/mnt##'):/project ubuntu:mine /bin/bash```

From Windows cmd: (replace <windows path> with where you checked out this project)
```docker run --rm -it -v c:<windows path>:/project ubuntu:mine /bin/bash```
