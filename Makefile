
# Install octopus via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile -t octopus-spack --build-arg SPACK_VERSION=develop  .

run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

# use particular versions of spack
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest \
	-t octopus-spack

run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

debian-octopusstable:
	docker build -f Dockerfile-debian -t octopus .

debian-octopusdevelop:
	docker build -f Dockerfile-debian-develop -t octopus-develop .

.PHONY: spack-latest run-spack debian-octopusstable debian-octopusdevelop spack-develop


dockerhub-update-12.0:
	@echo "Run 'docker login'"
	docker build -f Dockerfile-debian -t fangohr/octopus:12.0 .
  @echo "Run 'docker push fangohr/octopus:12.0' "

dockerhub-update-11.4:
	@echo "Run 'docker login'"
	docker build -f Dockerfile-debian -t fangohr/octopus:11.4 .
	# docker build -f Dockerfile --build-arg SPACK_VERSION=v0.17.2 -t fangohr/octopus:11.4 .
  @echo "Run 'docker push fangohr/octopus:11.4' "
