


Octopus in spack
================

.. sectnum::

.. contents::

Octopus-in-spack
================

Support repository for getting the `OCTOPUS code <http://octopus-code.org>`__ package into
`Spack <http://spack.readthedocs.io>`__.

Mostly aimed for maintainers of the Octopus package in spack: to test changes to
the `octopus/spack.py` file before request merges in spack upstream.

There is a related effort to run some tests on the Octopus package in spack for older versions of spack at https://github.com/fangohr/spack-ci-octopus.

We also provide some hints on how to install Octopus with Spack (see below).

Status
------

Compile Octopus on Linux with Spack. Spack's preferred version of Octopus is 12.2 at the
moment (if you follow `Compilation of Octopus using Spack`_):

|spack-develop-octopus-stable| Spack develop version, preferred version of Octopus

|spack-develop-octopus-develop| Spack develop version, develop version of Octopus

|diff-with-upstream| A check to see if this repository is in sync with the upstream spack repository.


Octopus and Spack - Quick start
===============================

Compilation of Octopus using Spack
----------------------------------

At the moment, this is under development, and we need two lines:

-  get spack: ``git clone https://github.com/spack/spack``
-  activate spack: ``source spack/share/spack/setup-env.sh``

Then compile octopus (this could take some time). For this example, we
want to include netcdf support:

-  ``spack install octopus +netcdf``

Ideally, there are no errors. This should install Octopus 12.2

There are further *variants* you can install. For example:

- ``spack install octopus +netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt``

To see an overview of available variants, use ``spack show octopus``.

This should install the last Octopus release available in spack. (Use ``spack info octopus`` to see available versions.)

To use Octopus after installation
---------------------------------

1. Activate spack:

-  ``source spack/share/spack/setup-env.sh``

2. Load octopus

-  ``spack load octopus``

3. Use octopus (it should be in the ``$PATH``). You can check the octopus version using ``octopus version``.


Octopus in Docker container
===========================

See https://github.com/fangohr/octopus-in-docker .


Compile Octopus on Debian Linux (without spack)
===============================================

See for example the steps in
`this Dockerfile <https://github.com/fangohr/octopus-in-docker/blob/main/Dockerfile>`__
on
https://github.com/fangohr/octopus-in-docker



.. |spack-develop-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml

.. |spack-develop-octopus-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop-octopus-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop-octopus-develop.yml

.. |diff-with-upstream| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/diff-with-upstream.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/sdiff-with-upstream.yml

.. comment: Outdated badges to follow

.. |spack-latest-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-latest.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-latest.yml


.. |spack-latest-octopus-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-latest-octopus-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-latestoctopus-develop.yml

