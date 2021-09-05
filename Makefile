
# Install octopus via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile -t octopus-spack --build-arg SPACK_VERSION=develop  .

run-spack:
	docker run --rm -ti octopus-spack 

# use particular versions of spack
spack-v0.16.2:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.16.2 \
   -t octopus-spack-v0.16.2 .

native:
	docker build -f Dockerfile-native -t octopus .


.PHONY: octopus-spack-v0.16.2 octopus-spack run-spack 
