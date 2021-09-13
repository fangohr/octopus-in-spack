
# Install octopus via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile -t octopus-spack --build-arg SPACK_VERSION=develop  .

run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

# use particular versions of spack
spack-v0.16.2:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.16.2 \
   -t octopus-spack-v0.16.2 .

debian-11.1:
	docker build -f Dockerfile-native -t octopus .

debian-develop:
	docker build -f Dockerfile-native-develop -t octopus-develop .


.PHONY: octopus-spack-v0.16.2 octopus-spack run-spack debian-11.1 debian-develop
