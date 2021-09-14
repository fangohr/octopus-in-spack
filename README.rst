Octopus-in-spack
================

Support repository for getting the `OCTOPUS code <http://octopus-code.org>`__ package into
`Spack <http://spack.readthedocs.io>`__.

Status
------

Compile Octopus on Linux with Spack:

|spack-develop-oct-11.1| Development branch of Spack, preferred version of Octopus 

|spack-v0.16.2-oct-11.1| Spack release 0.16.2, preferred version of Octopus 

Compile Octopus on Debian Linux:

|debian-11.1| Debian Bullseye (11), Octopus release 11.1

|debian-develop| Debian Bullseye (11), Octopus develop branch

Required commands
=================

Compilation of Octopus using Spack
----------------------------------

At the moment, this is under development, and we need two lines:

-  get spack: ``git clone https://github.com/fangohr/spack``
-  check out the right branch: ``git checkout octopus-review-2021-08``

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

.. |spack-develop-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-develop.yml
.. |spack-v0.16.2-oct-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-v0.16.2.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-v0.16.2.yml
.. |debian-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml
.. |debian-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml
