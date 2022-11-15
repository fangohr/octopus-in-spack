FROM debian:bullseye

# # which spack version are we using now? Default is develop
# # but other strings can be given to the docker build command
# # (for example docker build --build-arg SPACK_VERSION=v0.16.2)
ARG SPACK_VERSION=develop
ARG OCT_VERSION=12.1
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

# copy our package.py into the spack tree (and also example files)
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/octopus/package.py
RUN ls -l $SPACK_ROOT/var/spack/repos/builtin/packages/octopus
COPY spack/test/ $SPACK_ROOT/var/spack/repos/builtin/packages/octopus/test
RUN ls -l $SPACK_ROOT/var/spack/repos/builtin/packages/octopus/test

# Install and test serial and MPI versions of ocoptus via spack
# # serial version

RUN . $SPACK_ROOT/share/spack/setup-env.sh && \
      # create a new environment for the serial version and activate it:
      spack env create octopus-serial && \
      spack env activate octopus-serial && \
      # display specs of upcoming spack installation:
      spack spec octopus@${OCT_VERSION} ~mpi+netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt~debug~cuda~metis~scalapack && \
      # run the spack installation (adding it to the environment):
      spack add octopus@${OCT_VERSION} ~mpi+netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt~debug~cuda~metis~scalapack && \
      spack install && \
      # run spack smoke tests for octopus. We get an error if any of the fails:
      spack test run --alias test_serial octopus && \
      # display output from smoke tests (just for information):
      spack test results -l test_serial && \
      # show which octopus version we use (for convenience):
      spack load octopus && octopus --version && \
      # deactivate the environment.
      spack env deactivate

# # MPI version

RUN . $SPACK_ROOT/share/spack/setup-env.sh && \
      # create a new environment for the MPI version and activate it:
      spack env create octopus-mpi && \
      spack env activate octopus-mpi && \
      # display specs of upcoming spack installation:
      spack spec octopus@${OCT_VERSION} +mpi +netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt~debug~cuda~metis~scalapack  && \
      # run the spack installation (adding it to the environment):
      spack add octopus@${OCT_VERSION} +mpi +netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt~debug~cuda~metis~scalapack  && \
      spack install && \
      # run spack smoke tests for octopus. We get an error if any of the fails:
      spack test run --alias test_MPI octopus && \
      # display output from smoke tests (just for information):
      spack test results -l test_MPI && \
      # show which octopus version we use (for convenience):
      spack load octopus && octopus --version && \
      # deactivate the environment.
      spack env deactivate

# Provide bash in case the image is meant to be used interactively
CMD /bin/bash -l

