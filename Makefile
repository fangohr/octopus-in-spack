
# Install octopus via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile --build-arg SPACK_VERSION=develop -t octopus-spack  .

# use particular versions of spack
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest -t octopus-spack .

spack-latest-octopus-develop:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest --build-arg OCT_VERSION=develop -t octopus-spack .

spack-dev-build:
	docker build -f Docker-dev-build --build-arg SPACK_VERSION=dev-build -t octopus-spack-dev-build .

run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

.PHONY: spack-latest run-spack spack-develop

diff:
	@echo "Compare (diff) spack/package.py with current package.py from spack develop"
	wget --output-document=spack/package-upstream.py https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/octopus/package.py
	diff spack/package-upstream.py spack/package.py || true
