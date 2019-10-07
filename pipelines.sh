dvc run -f pipelines/farmacia.dvc \
        -d data/original/hi_farmacia.csv \
        -d src/preprocessing/farmacia.R \
        -o data/stable/farmacia.csv \
        Rscript src/preprocessing/farmacia.R

dvc run -f pipelines/historial.dvc \
        -d data/original/hi_historial.csv \
        -d src/preprocessing/historial.R \
        -o data/stable/historial.csv \
        Rscript src/preprocessing/historial.R

dvc run -f pipelines/internacion.dvc \
        -d data/original/hi_internacion.csv \
        -d src/preprocessing/internacion.R \
        -o data/stable/internacion.csv \
        Rscript src/preprocessing/internacion.R

dvc run -f pipelines/polifarmacia.dvc \
        -d data/stable/farmacia.csv \
        -d src/features/polifarmacia.R \
        -o data/features/polifarmacia.csv \
        Rscript src/features/polifarmacia.R

dvc run -f pipelines/status.dvc \
        -d data/stable/internacion.csv \
        -d src/features/status.R \
        -o data/features/sex.csv \
        -o data/features/age.csv \
        -o data/features/weight.csv \
        -o data/features/smoker.csv \
        Rscript src/features/status.R

dvc run -f pipelines/cvrisk.dvc \
        -d data/stable/historial.csv \
        -d src/features/cvrisk.R \
        -o data/features/cvrisk.csv \
        Rscript src/features/cvrisk.R

dvc run -f pipelines/labels.dvc \
        -d data/stable/internacion.csv \
        -d src/labels/labels.R \
        -o data/labels/labels.csv \
        Rscript src/labels/labels.R

dvc run -f pipelines/traintest.dvc \
        -d data/features \
        -d data/labels/labels.csv \
        -d src/build/traintest.R \
        -o data/build/traintest.csv \
        Rscript src/build/traintest.R

dvc run -f pipelines/training.dvc \
        -d data/build/traintest.csv \
        -d src/training/glmPois.R \
        -o data/models/glmPois.rds \
        -o data/models/auc.txt \
        Rscript src/training/glmPois.R