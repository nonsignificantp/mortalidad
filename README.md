# DVC workshop

## Descargar el repositorio

```bash
$ git clone https://github.com/nonsignificantp/dvc_workshop.git
$ cd dvc_workshop
```

## Cargar imagen, crear container e iniciar docker
```bash
$ docker build -t rdvc:latest .
$ docker create --name mortalidad -it \
        -p 8787:8787 \
        -v $PWD:/home/rstudio/dev \
        -e PASSWORD=123 \
        rdvc:latest
$ docker start -ia mortalidad
```

## Iniciar pipelines