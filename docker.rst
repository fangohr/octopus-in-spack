Use Octopus through Docker
==========================


.. contents::

Introduction
------------

If you have difficulties compiling Octopus, it might be useful to be able to run
it in a container (for example on Windows or OSX).

The container provides a mini (Linux) Operating system, in which we can compile
Octopus using a recipe (this is the Dockerfile, see below).

One can then use the editor and analysis tools of your normal operating system
and computer, and carry out the running of the actual Octopus calculations
inside the container.

There are two steps required:

- Step 1: build the container image (only once) or download it (only once)

- Step 2: use the container to execute Octopus inside the container



Step 1: How obtain a Docker container image with Octopus
--------------------------------------------------------

We provide a `Dockerfile-debian <Dockerfile-debian>`__ to compile Octopus 12.2
and `Dockerfile-debian-develop <Dockerfile-debian-develop>`__ to compile the ``develop`` branch of the Octopus
repository in a container.

The following examples are for the 12.2 release version. (To build a container
for the latest Octopus version from the ``develop`` branch, replace
``Dockerfile-debian`` with ``Dockerfile-debian-develop``.)

Option A: Build the Docker image on your computer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First clone this repository. Then run::

  docker build -f Dockerfile-debian -t octimage .

On Linux, you need to prefix all docker calls with ``sudo``::

  sudo docker build -f Dockerfile-debian -t octimage .

This will take some time to complete.

Option B: Download Docker image from Dockerhub
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instead of building it yourself, you can also pull an image from Dockerhub
(`available versions <https://hub.docker.com/r/fangohr/octopus/tags>`__) using::

  docker pull fangohr/octopus:12.2

and then move on to using this image in the next section, where you replace
``octimage`` with ``fangohr/octopus:12.2``.

[You should only use this "Option B" if your processor is x86 type. This is true
for most CPUs - with the exception of the 'new' Apple M1 computers (which have
the ARM64 architecture). If you have a M1 Mac, you could also download and use
this docker image *but* it will execute very slowly (because the x86 hardware
needs to be emulated). You are much better advised to follow "Option A" to build
the image yourself (on your M1 Mac), and then it will execute fast.

This advice and this documentation will change when we have managed to upload an
ARM64 image to Dockerhub.]


Step 2: Use the Docker image
----------------------------

To use the Docker image::

  docker run --rm -ti -v $PWD:/io octimage octopus
  
Meaning of the switches:

- ``--rm`` remove docker container after it has been carried out (good practice to reduce disk usage).
- ``-ti`` allow to make the Terminal session Interactive
- ``-v $PWD:/io``: take the current working directory (``$PWD``) and mount it in
  the container in the location ``/io``. This is also the default directory of
  the container.
- ``octimage`` is the name of the container image. The next 
- ``octopus`` is the name of the executable to run in the container. 

This is tested and known to work on OSX. On Linux, there is a permissions issue
if (numerical) user id on the host system and in the container deviate.

If you want to use multiple MPI processes (for example 4), change the above line to::

    docker run --rm -ti -v $PWD:/io octimage mpirun -np 4 octopus


Typical workflow with Octopus in container
------------------------------------------

- edit your ``inp`` file and save it  (on the host computer)
- call Octopus (in the container) by running ::

      docker run --rm -ti -v $PWD:/io octimage octopus
  
  Only the ``octopus`` command will be carried out in the
  container. Any output files are written to the current directory on the host.
- carry out data analysis on the host

If you want to work interactively *inside* the container, replace the name of the executable with ``bash``::

  docker run --rm -ti -v $PWD:/io octimage bash
  
You are then the root user in the container. Octopus was compiled in ``/opt/octopus*``. There are also some trivial examples in ``/opt/octopus-examples``.


Status
------

Compile Octopus on Debian Linux (in Docker container):

|debian-octopusstable| Debian Bullseye (11), last Octopus release (`Dockerfile <Dockerfile-debian>`__)

|debian-octopusdevelop| Debian Bullseye (11), Octopus develop branch (`Dockerfile <Dockerfile-debian-develop>`__)

.. |debian-octopusstable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusstable.yml/badge.svg
  :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusstable.yml
.. |debian-octopusdevelop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusdevelop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml
