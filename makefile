name = mortalidad

build_env:
	docker create --name $(name) \
		-it \
		-p 8787:8787 \
		-v $(CURDIR):/home/rstudio/dev \
		-e PASSWORD=123 \
		rdvc:latest

run_env:
	docker start -ia $(name)

reset_env:
	docker rm $(name)
	make build_env

stop_env:
	docker stop $(name)

reproduce_tree:
	find src/preprocessing/*.R | xargs -L 1 Rscript
	find src/features/*.R | xargs -L 1 Rscript
	find src/labels/*.R | xargs -L 1 Rscript
	find src/build/*.R | xargs -L 1 Rscript
	find src/training/*.R | xargs -L 1 Rscript

clean:
	rm data/stable/*.csv
	rm data/features/*.csv
	rm data/labels/*.csv
	rm data/build/*.csv
	rm data/models/*
