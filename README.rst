


Octopus in spack
================

.. sectnum::

.. contents:: 

Octopus-in-spack
================

Support repository for getting the `OCTOPUS code <http://octopus-code.org>`__ package into
`Spack <http://spack.readthedocs.io>`__.

Also providing some hints on how to install Octopus with Spack.

Status
------


Compile Octopus on Linux with Spack. Spack's preferred option is 11.3 at the
moment (if you follow `Compilation of Octopus using Spack`_):

|spack-v0.17.0-oct-11.3| Spack release 0.17.0, preferred version of Octopus

|spack-v0.17.2-oct-11.3| Spack release 0.17.2, preferred version of Octopus

|spack-develop-oct-11.3| Spack develop version, preferred version of Octopus. 

|spack-osx-last-spack-release| Spack release 0.17.2, preferred version of Octopus, on OSX

|spack-osx-spack-develop| Spack develop version, preferred version of Octopus. 

Compile Octopus on Debian Linux (no Spack involved):

|debian-11.3| Debian Bullseye (11), Octopus release 11.3

|debian-develop| Debian Bullseye (11), Octopus develop branch

Octopus in Container
====================

Please see `here <docker.rst>`__.


Octopus and Spack - Quick start
===============================

Compilation of Octopus using Spack
----------------------------------

At the moment, this is under development, and we need two lines:

-  get spack: ``git clone https://github.com/fangohr/spack``
-  check out the right branch::

    cd spack
    git checkout octopus-review-2021-08
    cd ..

Then activate spack:

-  ``source spack/share/spack/setup-env.sh``

Then compile octopus (this could take some time). For this example, we
want to include netcdf support:

-  ``spack install octopus +netcdf``

Ideally, there are no errors.

This should install Octopus 11.3

To use Octopus after installation
---------------------------------

1. Activate spack:

-  ``source spack/share/spack/setup-env.sh``

2. Load octopus

-  ``spack load octopus``

3. Use octopus (it should be in the ``$PATH``)

.. |spack-v0.17.0-oct-11.3| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.0.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.0.yml
.. |spack-v0.17.2-oct-11.3| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.2.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.2.yml

.. |debian-11.3| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.3.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.3.yml
.. |debian-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml

.. |spack-develop-oct-11.3| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg?branch=spack-develop
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml

.. |spack-osx-last-spack-release| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/osx-spack-last-release/badge.svg

.. |spack-osx-spack-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/osx-spack-develop/badge.svg

