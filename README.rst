


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


Compile Octopus on Linux with Spack. Spack's preferred option is 11.1 at the
moment (if you follow `Compilation of Octopus using Spack`_):

|spack-v0.16.2-oct-11.1| Spack release 0.16.2, preferred version of Octopus

|spack-v0.16.3-oct-11.1| Spack release 0.16.3, preferred version of Octopus

|spack-develop-oct-11.1| Spack develop version, preferred version of Octopus. The spack `develop` branch is relatively unstable regarding successful building of Octopus. We have a `separate spack-develop <https://github.com/fangohr/octopus-in-spack/tree/spack-develop>`__ branch for this (so that the pass/fail of actions for the main branch does not depend on it), and show the result with this badge here for information.

Compile Octopus on Debian Linux:

|debian-11.1| Debian Bullseye (11), Octopus release 11.1

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

This should install Octopus 11.1

To use Octopus after installation
---------------------------------

1. Activate spack:

-  ``source spack/share/spack/setup-env.sh``

2. Load octopus

-  ``spack load octopus``

3. Use octopus (it should be in the ``$PATH``)

.. |spack-v0.16.2-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.16.2.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.16.2.yml
.. |spack-v0.16.3-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.16.3.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.16.3.yml

.. |debian-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml
.. |debian-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml

.. |spack-develop-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg?branch=spack-develop
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml
