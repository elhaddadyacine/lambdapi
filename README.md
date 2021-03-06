Lambdapi, a proof assistant based on the λΠ-calculus modulo rewriting
=====================================================================

Lambdapi is a proof assistant based on the λΠ-calculus modulo rewriting,
mostly compatible with the proof checker Dedukti. More details are given
in the [documentation](doc/DOCUMENTATION.md).

Installation via [Opam](http://opam.ocaml.org/)
---------------------

```bash
opam install lambdapi
```

Dependencies and compilation
----------------------------

Lambdapi requires a Unix-like system. It should work on Linux as well as on
MacOS. It might also be possible to make it work on Windows with Cygwin or
with "bash on Windows".

List of dependencies:
 - GNU make
 - ocaml >= 4.04.1
 - dune >= 1.2.0
 - odoc (for documentation only)
 - [bindlib](https://github.com/rlepigre/ocaml-bindlib) >= 5.0.0
 - [earley](https://github.com/rlepigre/ocaml-earley) >= 2.0.0
 - [timed](https://github.com/rlepigre/ocaml-timed) >= 1.0
 - menhir
 - yojson >= 1.6.0
 - cmdliner
 - ppx\_inline\_test
 - why3 >= 1.2.0

Using Opam, a suitable OCaml environment can be setup as follows.
```bash
opam switch 4.05.0
eval `opam config env`
opam install dune odoc menhir yojson cmdliner bindlib.5.0.0 timed.1.0 earley.2.0.0 ppx_inline_test why3.1.2.0
```

To compile Lambdapi, just run the command `make` in the source directory.
This produces the `_build/install/default/bin/lambdapi` binary, which can
be run on files with the `.dk` or `.lp` extension (use the `--help` option
for more information).

```bash
make               # Build lambdapi.
make doc           # Build the documentation.
make install       # Install the program.
make install_vim   # Install vim support.
make install_emacs # Install emacs (>= 26.1) support (needs the eglot package)
```

**Note:** you can run `lambdapi` without installing with `dune exec -- lambdapi`.

The following commands can be used for cleaning up the repository:
```bash
make clean     # Removes files generated by OCaml.
make distclean # Same as clean, but also removes library checking files.
make fullclean # Same as distclean, but also removes downloaded libraries.
```
