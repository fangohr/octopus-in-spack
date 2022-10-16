
# Install octopus via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile --build-arg SPACK_VERSION=develop -t octopus-spack  .

run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

# use particular versions of spack
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest -t octopus-spack .

run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

debian-octopusstable:
	docker build -f Dockerfile-debian -t octopus .

debian-octopusdevelop:
	docker build -f Dockerfile-debian-develop -t octopus-develop .

container-make-check:
	docker build -f Dockerfile-debian-make-check -t octopus .

container-make-check-short:
	docker build -f Dockerfile-debian-make-check-short -t octopus .


.PHONY: spack-latest run-spack debian-octopusstable debian-octopusdevelop spack-develop

diff:
	@echo "Compare (diff) spack/package.py with current package.py from spack develop"
	wget --output-document=spack/package-upstream.py https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/octopus/package.py
	diff spack/package-upstream.py spack/package.py || true

dockerhub-update-12.1:
	docker build -f Dockerfile-debian -t fangohr/octopus:12.1 .
	@echo "If the container has built successfully, do this to push to dockerhub:"
	@echo "Run 'docker login'"
	@echo "Run 'docker push fangohr/octopus:12.1'"
	@echo "Run 'docker tag fangohr/octopus:12.1 fangohr/octopus:latest'"
	@echo "Run 'docker push fangohr/octopus:latest'"
