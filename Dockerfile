FROM debian:bullseye

# # which spack version are we using now? Default is develop
# # but other strings can be given to the docker build command
# # (for example docker build --build-arg SPACK_VERSION=v0.16.2)
ARG SPACK_VERSION=develop
RUN echo "Building with spack version ${SPACK_VERSION}"

# Any extra packages to be installed in the host
ARG EXTRA_PACKAGES
RUN echo "Installing EXTRA_PACKAGES ${EXTRA_PACKAGES} on container host"

# general environment for docker
ENV SPACK_ROOT=/home/user/spack \
	  SPACK=/home/user/spack/bin/spack \
	  FORCE_UNSAFE_CONFIGURE=1

RUN apt-get -y update
# Convenience tools
# RUN apt-get -y install wget time nano vim emacs git

# From https://github.com/ax3l/dockerfiles/blob/master/spack/base/Dockerfile:
# install minimal spack dependencies
RUN        apt-get install -y --no-install-recommends \
              autoconf \
              build-essential \
              ca-certificates \
              coreutils \
              curl \
              environment-modules \
              gfortran \
              git \
              openssh-server \
              python \
              unzip \
              vim \
           && rm -rf /var/lib/apt/lists/*

# load spack environment on login
RUN echo "source $SPACK_ROOT/share/spack/setup-env.sh" \
           > /etc/profile.d/spack.sh

RUN adduser user
USER user
WORKDIR /home/user

# install spack
RUN git clone https://github.com/spack/spack.git
# default branch is develop
RUN cd spack && git checkout $SPACK_VERSION

# # show which version we use
RUN $SPACK --version

# build octopus
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/octopus
# RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec octopus +netcdf
# RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install octopus +netcdf

RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec octopus +netcdf+parmetis+arpack+cgal+pfft+poke+python+likwid+libyaml+elpa+nlopt
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install octopus +netcdf+parmetis+arpack+cgal+pfft+poke+python+likwid+libyaml+elpa+nlopt


CMD /bin/bash -l

