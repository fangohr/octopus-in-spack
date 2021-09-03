# Octopus-in-spack

Support repository for getting the [OCTOPUS code](http://octopus-code.org) package into [Spack](http://spack.readthedocs.io).

## Status

Compile Octopus in Debian (without spack): [![debian-compile-octopus-natively](https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-compile-octopus-natively.yml/badge.svg)](https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-compile-octopus-natively.yml)

Compile Octopus on (Debian) Linux with spack:

[![debian-spack-develop](https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-develop.yml/badge.svg)](https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-develop.yml)
[![debian-spack-v0.16.2](https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-v0.16.2.yml/badge.svg)](https://github.com/fangohr/octopus-in-spack/actions/workflows/debian-spack-v0.16.2.yml)


# Required commands

## Compilation of Octopus

At the moment, this is under development, and we need two lines:

- get spack: `git clone https://github.com/fangohr/spack`
- checkout the right branch: `git checkout octopus-review-2021-08`

Then activate spack:

- `source spack/share/spack/setup-env.sh`

The compile octopus (this could take some time)

- `spack install octopus`

Ideally, there are no errors.

This should install Octopus 11.1 


## To use Octopus after installation

1. Activate spack:

- `source spack/share/spack/setup-env.sh`

2. Load octopus

- `spack load octopus`

3. Use octopus (it should be in the `$PATH`)






