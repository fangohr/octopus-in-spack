FROM debian:bullseye

# # which spack version are we using now? Default is develop
# # but other strings can be given to the docker build command
# # (for example docker build --build-arg SPACK_VERSION=v0.16.2)
ARG SPACK_VERSION=develop
ARG OCT_VERSION=14.1
ARG BERKELEYGW_VER=""
RUN echo "Building with spack version ${SPACK_VERSION}"

# Any extra packages to be installed in the host
ARG EXTRA_PACKAGES
RUN echo "Installing EXTRA_PACKAGES ${EXTRA_PACKAGES} on container host"

# general environment for docker
ENV SPACK_ROOT=/home/user/spack \
	  SPACK=/home/user/spack/bin/spack \
	  FORCE_UNSAFE_CONFIGURE=1

RUN apt-get -y update
# Convenience tools, if desired for debugging etc
# RUN apt-get -y install wget time nano vim emacs git

# From https://github.com/ax3l/dockerfiles/blob/master/spack/base/Dockerfile:
# install minimal spack dependencies
RUN apt-get install -y --no-install-recommends \
              autoconf \
              build-essential \
              ca-certificates \
              coreutils \
              curl \
              environment-modules \
	            file \
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

# copy our package.py into the spack tree (and also example files and test scripts)
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/octopus/package.py
RUN ls -l $SPACK_ROOT/var/spack/repos/builtin/packages/octopus
COPY spack/test/ $SPACK_ROOT/var/spack/repos/builtin/packages/octopus/test
RUN ls -l $SPACK_ROOT/var/spack/repos/builtin/packages/octopus/test
COPY spack_test_install.sh $SPACK_ROOT

# Install and test serial and MPI versions of ocoptus via spack
# # serial version

# we use the berkeleygw@3.0.1 as newer versions are not downloadable at the moment
# see https://github.com/spack/spack/issues/43122
# TODO: remove the version number when the issue is resolved
RUN   OCTOPUS_SPEC="octopus@${OCT_VERSION} ~mpi+netcdf+arpack+cgal+python+likwid+libyaml+elpa+nlopt+etsf-io+sparskit+berkeleygw+nfft~debug~cuda~metis ^berkeleygw${BERKELEYGW_VER}" && \
      bash ${SPACK_ROOT}/spack_test_install.sh --spec ${OCTOPUS_SPEC} --spack-root ${SPACK_ROOT} --test-name octopus-serial

# # MPI version

RUN   OCTOPUS_SPEC="octopus@${OCT_VERSION} +mpi +netcdf+parmetis+arpack+cgal+pfft+pnfft+python+likwid+libyaml+elpa+nlopt+etsf-io+sparskit+berkeleygw+nfft~debug~cuda~metis~scalapack ^berkeleygw${BERKELEYGW_VER}"  && \
      bash ${SPACK_ROOT}/spack_test_install.sh --spec ${OCTOPUS_SPEC} --spack-root ${SPACK_ROOT} --test-name octopus-mpi

# Provide bash in case the image is meant to be used interactively
CMD /bin/bash -l

