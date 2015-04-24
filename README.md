# docker-jbrowse

Docker recipe for JBrowse

## Instructions

### Building & Running

```sh
docker build .
docker run --publish 8080:80 --volume $PWD/my-data:/data <image id>
```

### Importing Data

(example using Bacterial genome annotated using RAST)

```sh
# connect to running Docker container:

docker exec -t -i <container id> /bin/bash

# now, from the container
bin/prepare-refseqs.pl /data/reference.fasta
bin/flatfile-to-json/pl --gff /data/annotation.gff --traceType CanvasFeatures --trackLabel "RAST Annotation"
```
