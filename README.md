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

# import reference:
bin/prepare-refseqs.pl /data/reference.fasta

# import features (GFF)
bin/flatfile-to-json.pl \
  --gff /data/annotation.gff \
  --traceType CanvasFeatures \
  --trackLabel "RAST Annotation"

# disconnect from container
exit
```

You can now commit the container with your data so that it will already be there
the next time you start it up:

```sh
docker commit <container id>
docker tag <container id> my-genome-jbrowse
```

The next time you want to start JBrowse with your data:

```sh
docker start my-genome-jbrowse
```
