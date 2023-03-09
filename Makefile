# Install octopus via spack.

# Using most recent spack version with preferred version of octopus
spack-develop:
	docker build -f Dockerfile --build-arg SPACK_VERSION=develop -t octopus-spack  .

# Using most recent spack version with most recent version of octopus
spack-develop-octopus-develop:
	docker build -f Dockerfile --build-arg SPACK_VERSION=develop --build-arg OCT_VERSION=develop -t octopus-spack .


# use particular versions of spack (these are not in the CI as older version of
# spack may not work with the most recent octopus/package.py file)
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest -t octopus-spack .

spack-latest-octopus-develop:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest --build-arg OCT_VERSION=develop -t octopus-spack .


run-spack:
	docker run --rm -ti -v $PWD:/io octopus-spack 

.PHONY: spack-develop spack-develop-octopus-develop spack-latest spack-latest-octopus-develop spack-latest run-spack 

diff:
	@echo "Compare (diff) spack/package.py with current package.py from spack develop"
	wget --output-document=spack/package-upstream.py https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/octopus/package.py
	diff spack/package-upstream.py spack/package.py || true
