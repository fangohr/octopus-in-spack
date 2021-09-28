# Copyright 2013-2021 Lawrence Livermore National Security, LLC and other
# Spack Project Developers. See the top-level COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

import llnl.util.tty as tty

from spack import *


class Octopus(Package, CudaPackage):
    """A real-space finite-difference (time-dependent) density-functional
    theory code."""

    homepage = "https://octopus-code.org/"
    url      = "http://octopus-code.org/down.php?file=6.0/octopus-6.0.tar.gz"
    git      = "https://gitlab.com/octopus-code/octopus"

    

    version('11.1',  sha256='d943cc2419ca409dda7459b7622987029f2af89984d0d5f39a6b464c3fc266da')

    version('develop', branch='develop')

    version('10.5',  sha256='deb92e3491b0c6ac5736960d075b44cab466f528b69715ed44968ecfe2953ec4')
    version('10.4',  sha256='4de9dc6f5815a45e43320e4abc7ef3e501e34bc327441376ea20ca1a992bdb72')
    version('10.3',  sha256='4633490e21593b51b60a8391b8aa0ed17fa52a3a0030630de123b67a41f88b33')
    version('10.2',  sha256='393e2ba7b18af1b736ad6deb339ba0cef18c6417671da7a6f1fcc3a5d8f7586b')
    version('10.1',  sha256='b6a660a99ed593c1d491e2d11cfff9ce87f0d80d527d9ff47fd983533d45adc6')
    version('10.0',  sha256='ccf62200e3f37911bfff6d127ebe74220996e9c09383a10b1420c81d931dcf23')
    version('7.3',   sha256='ad843d49d4beeed63e8b9a2ca6bfb2f4c5a421f13a4f66dc7b02f6d6a5c4d742')
    version('6.0',   sha256='4a802ee86c1e06846aa7fa317bd2216c6170871632c9e03d020d7970a08a8198')
    version('5.0.1', sha256='3423049729e03f25512b1b315d9d62691cd0a6bd2722c7373a61d51bfbee14e0')

    variant('scalapack', default=False,
            description='Compile with Scalapack')
    variant('metis', default=False,
            description='Compile with METIS')
    variant('parmetis', default=False,
            description='Compile with ParMETIS')
    variant('netcdf', default=False,
            description='Compile with Netcdf')
    variant('arpack', default=False,
            description='Compile with ARPACK')
    variant('cgal', default=False,
            description='Compile with CGAL library support')
    variant('pfft', default=False,
            description='Compile with PFFT')
    variant('poke', default=False,
            description='Compile with poke (not available in spack yet)')
    variant('python', default=False,
            description='Activates Python support')
    variant('likwid', default=False,
            description='Compile with likwid')
    variant('libvdwxc', default=False,
            description='Compile with libvdwxc')
    variant('libyaml', default=False,
            description='Compile with libyaml')
    variant('elpa', default=False,
            description='Compile with ELPA')
    variant('nlopt', default=False,
            description='Compile with nlopt')
    variant('debug', default=False,
            description='Compile with debug flags')

    depends_on('autoconf', type='build')
    depends_on('automake', type='build')
    depends_on('libtool',  type='build')
    depends_on('m4',       type='build')

    depends_on('blas')
    depends_on('gsl@1.9:')
    depends_on('lapack')
    depends_on('libxc@2:2.99', when='@:5.99')
    depends_on('libxc@2:3.99', when='@6:7.99')
    depends_on('libxc@2:4.99', when='@8:9.99')
    depends_on('libxc@4.3.0:', when='@10:')
    depends_on('libxc@4.3.0:', when='@develop')
#    depends_on('libxc@5.1.0:', when='@10:')
#    depends_on('libxc@5.1.0:', when='@develop')
    depends_on('mpi')

    depends_on('fftw@3:+mpi+openmp', when='@8:9.99')
    depends_on('fftw-api@3:', when='@10:')
    depends_on('metis@5:', when='+metis')
    depends_on('parmetis', when='+parmetis')
    depends_on('py-numpy', when='+python')
    depends_on('py-mpi4py', when='+python')
    depends_on('scalapack', when='+scalapack')
    depends_on('netcdf-fortran', when='+netcdf')
    depends_on('arpack-ng', when='+arpack')
    depends_on('cgal', when='+cgal')
    depends_on('pfft', when='+pfft')
    depends_on('poke', when='+poke')
    depends_on('likwid', when='+likwid')
    depends_on('libvdwxc', when='+libvdwxc')
    depends_on('libyaml', when='+libyaml')
    depends_on('elpa', when='+elpa')
    depends_on('nlopt', when='+nlopt')

    # optional dependencies:
    # TODO: etsf-io, sparskit,
    # feast, libfm, pfft, isf, pnfft

    def install(self, spec, prefix):
        lapack = spec['lapack'].libs
        blas = spec['blas'].libs
        args = []
        args.extend([
            '--prefix=%s' % prefix,
            '--with-blas=%s' % blas.ld_flags,
            '--with-lapack=%s' % lapack.ld_flags,
            '--with-gsl-prefix=%s' % spec['gsl'].prefix,
            '--with-libxc-prefix=%s' % spec['libxc'].prefix,
            'CC=%s' % spec['mpi'].mpicc,
            'FC=%s' % spec['mpi'].mpifc,
            '--enable-mpi',
        ])
        if '^fftw' in spec:
            args.extend([
                '--with-fftw-prefix=%s' % spec['fftw'].prefix,
            ])
        elif '^mkl' in spec:
            # As of version 10.0, Octopus depends on fftw-api instead
            # of FFTW. If FFTW is not in the dependency tree, then
            # it ought to be MKL as it is currently the only providers
            # available for fftw-api.
            args.extend([
                'FCFLAGS_FFTW=-I%s' % spec['mkl'].prefix.include.fftw
            ])
        else:
            # To be foolproof, fail with a proper error message
            # if neither FFTW nor MKL are in the dependency tree.
            tty.die('Unsupported "fftw-api" provider, '
                    'currently only FFTW and MKL are supported.\n'
                    "Please report this issue on Spack's repository.")
        if '+metis' in spec:
            args.extend([
                '--with-metis-prefix=%s' % spec['metis'].prefix,
            ])
        if '+parmetis' in spec:
            args.extend([
                '--with-parmetis-prefix=%s' % spec['parmetis'].prefix,
            ])
        if '+netcdf' in spec:
            args.extend([
                '--with-netcdf-prefix=%s' % spec['netcdf-fortran'].prefix,
                '--with-netcdf-include=%s' %
                spec['netcdf-fortran'].prefix.include,
            ])
        if '+arpack' in spec:
            arpack_libs = spec['arpack-ng'].libs.joined()
            args.extend([
                '--with-arpack={0}'.format(arpack_libs),
            ])
            if '+mpi' in spec['arpack-ng']:
                args.extend([
                    '--with-parpack={0}'.format(arpack_libs),
                ])

        if '+scalapack' in spec:
            args.extend([
                '--with-blacs=%s' % spec['scalapack'].libs,
                '--with-scalapack=%s' % spec['scalapack'].libs
            ])

        if '+cgal' in spec:
            args.extend([
                '--with-cgal-prefix=%s' % spec['cgal'].prefix,
            ])

        if '+likwid' in spec:
            args.extend([
                '--with-likwid-prefix=%s' % spec['likwid'].prefix,
            ])

        if '+pfft' in spec:
            args.extend([
                '--with-pfft-prefix=%s' % spec['pfft'].prefix,
            ])

        if '+poke' in spec:
            args.extend([
                '--with-poke-prefix=%s' % spec['poke'].prefix,
            ])

        if '+libvdwxc' in spec:
            args.extend([
                '--with-libvdwxc-prefix=%s' % spec['libvdwxc'].prefix,
            ])

        if '+libyaml' in spec:
            args.extend([
                '--with-libyaml-prefix=%s' % spec['libyaml'].prefix,
            ])

        if '+elpa' in spec:
            args.extend([
                '--with-elpa-prefix=%s' % spec['elpa'].prefix,
            ])

        if '+nlopt' in spec:
            args.extend([
                '--with-nlopt-prefix=%s' % spec['nlopt'].prefix,
            ])

        if '+cuda' in spec:
            args.extend([
                '--enable-cuda'
            ])

        if '+python' in spec:
            args.extend('--enable-python')

        # --with-etsf-io-prefix=
        # --with-sparskit=${prefix}/lib/libskit.a
        # --with-pfft-prefix=${prefix} --with-mpifftw-prefix=${prefix}
        # --with-berkeleygw-prefix=${prefix}

        # When preprocessor expands macros (i.e. CFLAGS) defined as quoted
        # strings the result may be > 132 chars and is terminated.
        # This will look to a compiler as an Unterminated character constant
        # and produce Line truncated errors. To overcome this, add flags to
        # let compiler know that the entire line is meaningful.
        # TODO: For the lack of better approach, assume that clang is mixed
        # with GNU fortran.
        if (spec.satisfies('%apple-clang') or
                spec.satisfies('%clang') or
                spec.satisfies('%gcc')):
            # In case of GCC version 10, we will have errors because of argument mismatching.
            # Need to provide a flag to turn this into a warning and build sucessfully
            if (spec.satisfies('%gcc@10:')):
                args.extend([
                    'FCFLAGS=-O2 -ffree-line-length-none -fallow-argument-mismatch -fallow-invalid-boz',
                    'FFLAGS=-O2 -ffree-line-length-none -fallow-argument-mismatch -fallow-invalid-boz'])
            else:
                args.extend([
                    'FCFLAGS=-O2 -ffree-line-length-none',
                    'FFLAGS=-O2 -ffree-line-length-none'
                ])

        autoreconf('-i')
        configure(*args)
        make()
        # short tests take forever...
        # make('check-short')
        make('install')
