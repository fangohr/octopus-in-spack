Use Octopus through Docker
==========================

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

- (i) build the container image (only once)

- (ii) use the container to execute Octopus inside the container



How to compile and execute `OCTOPUS code <http://octopus-code.org>`__ in a Docker container
-------------------------------------------------------------------------------------------

We provide a `Dockerfile-debian <Dockerfile-debian>`__ to compile Octopus 11.1
and `Dockerfile-debian-develop <Dockerfile-debian-develop>`__ to compile the ``develop`` branch of the Octopus
repository in a container.

The following examples are for the 11.1 release version. (To build a container
for the latest Octopus version from the ``develop`` branch, replace
``Dockerfile-debian`` with ``Dockerfile-debian-develop``.)

Build the Docker image
~~~~~~~~~~~~~~~~~~~~~~

First clone this repository. Then run::

  docker build -f Dockerfile-debian -t octimage .

On Linux, you need to prefix all docker calls with ``sudo``::

  sudo docker build -f Dockerfile-debian -t octimage .

This will take some time to complete.

Instead of building it yourself, for Octopus 11.1, you can also pull an image from Dockerhub using::

  docker pull fangohr/octopus:11.1

and then move on to using this image in the next section, where you replace ``octimage`` with ``fangohr/octopus:11.1``.


Use the Docker image
~~~~~~~~~~~~~~~~~~~~

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


Typical workflow with octopus in container
------------------------------------------

- edit your ``inp`` file and save it  (on the host computer)
- call Octopus (in the container) by running ``docker run --rm -ti -v $PWD:/io
  octimage octopus``. Only the ``octopus`` command will be carried out in the
  container. Any output files are written to the current directory on the host.
- carry out data analysis on the host

If you want to work interactively in the container, replace the name of the executable with ``bash``::

  docker run --rm -ti -v $PWD:/io octimage octopus



Status
------

Compile Octopus on Debian Linux:

|debian-11.1| Debian Bullseye (11), Octopus release 11.1

|debian-develop| Debian Bullseye (11), Octopus develop branch

.. |spack-develop-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg
  :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml
.. |spack-v0.16.2-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.16.2.yml/badge.svg
  :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.16.2.yml
.. |debian-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml/badge.svg
  :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml
.. |debian-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml/badge.svg
  :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml
