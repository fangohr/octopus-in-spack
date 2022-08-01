


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


Compile Octopus on Linux with Spack. Spack's preferred option is 11.4 at the
moment (if you follow `Compilation of Octopus using Spack`_):
|spack-latest-octopus-stable| Spack latest release, preferred version of Octopus; Compiled every Monday 2PM CET

|spack-v0.18.0-octopus-stable| Spack release 0.18.0, preferred version of Octopus

|spack-v0.17.2-octopus-stable| Spack release 0.17.2, preferred version of Octopus


|spack-develop-octopus-stable| Spack develop version, preferred version of Octopus. 

Compile Octopus on Debian Linux:

|debian-octopusstable| Debian Bullseye (11), Last octopus release (11.4)

|debian-octopusdevelop| Debian Bullseye (11), Octopus develop branch

Octopus in Container
====================

Please see `here <docker.rst>`__.


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

Ideally, there are no errors. This should install Octopus 11.4

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

.. |spack-latest-octopus-stable| image:: https://github.com/iamashwin99/octopus-in-spack/actions/workflows/spack-latest.yml/badge.svg
   :target: https://github.com/iamashwin99/octopus-in-spack/actions/workflows/spack-latest.yml
   
.. |spack-v0.18.0-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.18.0.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.18.0.yml
.. |spack-v0.17.2-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.2.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.2.yml

.. |debian-octopusstable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusstable.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusstable.yml
.. |debian-octopusdevelop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusdevelop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml

.. |spack-develop-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg?branch=spack-develop
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml
