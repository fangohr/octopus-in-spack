.. sectnum::

.. contents::

Octopus-in-spack
================

Support repository for getting the `OCTOPUS code <http://octopus-code.org>`__ package into
`Spack <http://spack.readthedocs.io>`__.

Mostly aimed for maintainers of the Octopus package in spack: to test changes to
Spack's `package.py file <https://github.com/fangohr/octopus-in-spack/blob/main/spack/package.py>`_ for Octopus, before requesting merges
in `spack upstream <https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/octopus/package.py>`_.

There is a related effort to run some tests on the Octopus package in spack for older versions of spack at https://github.com/fangohr/spack-ci-octopus.

We also provide some hints on how to install Octopus with Spack (see below).

Status
------

Compile Octopus on Debian with Spack.

+----------------------------------+-------------------------------------------------------------+
| Badge                            | Description                                                 |
+==================================+=============================================================+
| |spack-develop-octopus-stable|   | Build ``latest`` octopus using spack develop branch         |
+----------------------------------+-------------------------------------------------------------+
| |spack-develop-octopus-develop|  | Build develop branch of Octopus using spack develop branch  |
+----------------------------------+-------------------------------------------------------------+
| |diff-with-upstream|             | A check to see if our ``octopus/package.py`` file is in sync with the `upstream spack repository <https://github.com/spack/spack/blob/develop/var/spack/repos/builtin/packages/octopus/package.py>`_ |
+----------------------------------+-------------------------------------------------------------+


Octopus and Spack - Quick start
===============================

Compilation of Octopus using Spack
----------------------------------

-  get spack: ``git clone https://github.com/spack/spack``
-  activate spack: ``source spack/share/spack/setup-env.sh``

Then compile octopus (this could take some time). For this example, we
want to include netcdf support:

-  ``spack install octopus +netcdf``

This should install the last Octopus release available in spack. (Use ``spack info octopus`` to see available versions.)

To install a particular Octopus version, for example 14.0, you can use this notation:

-  ``spack install octopus@14.0 +netcdf``

There are further *variants* you can install. For example:

- ``spack install octopus +netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt``

To see an overview of available variants, use ``spack info octopus``.



To use Octopus after installation
---------------------------------

1. Activate spack:

-  ``source spack/share/spack/setup-env.sh``

2. Load octopus

-  ``spack load octopus``

3. Use octopus (it should be in the ``$PATH``). You can check the octopus version using ``octopus --version``.



Other ways to compile / use Octopus
===================================

- use a pre-built Docker container: https://github.com/fangohr/octopus-in-docker
- compile Octopus from source on Debian Linux (without spack): See for example the steps in
  `this Dockerfile <https://github.com/fangohr/octopus-in-docker/blob/main/Dockerfile>`__
  on https://github.com/fangohr/octopus-in-docker


.. |spack-develop-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml

.. |spack-develop-octopus-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop-octopus-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop-octopus-develop.yml

.. |diff-with-upstream| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/diff-with-upstream.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/sdiff-with-upstream.yml
