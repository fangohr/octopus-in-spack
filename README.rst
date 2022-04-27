


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

|spack-v0.17.0-octopus-stable| Spack release 0.17.0, preferred version of Octopus

|spack-v0.17.2-octopus-stable| Spack release 0.17.2, preferred version of Octopus


|spack-develop-octopus-stable| Spack develop version, preferred version of Octopus. 
The spack `develop` branch is relatively unstable regarding successful building 
of Octopus. We have a 
`separate spack-develop <https://github.com/fangohr/octopus-in-spack/tree/spack-develop>`__ 
branch for this (so that the pass/fail of actions for the main branch does not depend on 
it), and show the result with this badge here for information.

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

-  get spack: ``git clone https://github.com/fangohr/spack``
-  check out the right branch::

    cd spack
    git checkout octopus-update-to-11.4-and-add-tests
    cd ..

Then activate spack:

-  ``source spack/share/spack/setup-env.sh``

Then compile octopus (this could take some time). For this example, we
want to include netcdf support:

-  ``spack install octopus +netcdf``

Ideally, there are no errors. This should install Octopus 11.4

There are further *variants* you can install. For example:

- ``spack install octopus +netcdf+parmetis+arpack+cgal+pfft+python+likwid+libyaml+elpa+nlopt``

To see an overview of available variants, use ``spack show octopus``.


To use Octopus after installation
---------------------------------

1. Activate spack:

-  ``source spack/share/spack/setup-env.sh``

2. Load octopus

-  ``spack load octopus``

3. Use octopus (it should be in the ``$PATH``)

.. |spack-v0.17.0-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.0.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.0.yml
.. |spack-v0.17.2-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.2.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-v0.17.2.yml

.. |debian-octopusstable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusstable.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusstable.yml
.. |debian-octopusdevelop| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-octopusdevelop.yml/badge.svg
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-develop.yml

.. |spack-develop-octopus-stable| image:: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml/badge.svg?branch=spack-develop
   :target: https://github.com/fangohr/octopus-in-spack/actions/workflows/spack-develop.yml
