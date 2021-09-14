Octopus-in-spack
================

Support repository for getting the `OCTOPUS code <http://octopus-code.org>`__ package into
`Spack <http://spack.readthedocs.io>`__.

Status
------

Compile Octopus on (Debian) Linux with spack:

|debian-spack-develop| |debian-spack-v0.16.2|

Compile Octopus on Debian Linux:

|debian-11.1| |debian-develop|

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

.. |debian-spack-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-develop.yml
.. |debian-spack-v0.16.2| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-v0.16.2.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-v0.16.2.yml
.. |debian-11.1| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-11.1.yml
.. |debian-develop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml
