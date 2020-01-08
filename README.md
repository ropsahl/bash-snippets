# Bash snippets
Content and tools for a Agitec developers meeting
# Preparations
Those who want to be prepared to take part in practical sessions using Docker here is some helping commands:
## Docker
### Build
Build Docker image from local Dockerfile with name and tag ubuntu:mine

``` docker build -t ubuntu:mine .```

### Run
Run Docker image ubuntu:mine interactive /bin/bash, don't keep changes and mount local directory to /project
From Linux etc.:

```docker run --rm -it -v $(pwd -P |sed 's#/mnt##'):/home -v /c:/c ubuntu:mine /bin/bash```

From Windows cmd: (replace <windows path> with where you checked out this project)
```docker run --rm -it -v c:<windows path>:/home -v c:/:/c ubuntu:mine /bin/bash```


# Agenda
My plans for today

- Motivation (I really like unix cmd line...)
- Example: What code is used to build "this app"

```eval "$(oc get dc mtw-m-settings -n mtw-atest -o json |jq -r '.spec.template.spec.containers[]|.image'|sed 's;.*5000/\(.*\)/\(.*\);oc get isimage -n \1 \2 -o json;')" | jq '.image.dockerImageMetadata.Config.Labels|to_entries[]|select(.key|startswith("io.openshift.build.commit"))'```

- find
- grep
- sed
- curl
- jq
- for
- while
- xargs
- variable ops

