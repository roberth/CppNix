# CppNix

CppNix is a Nix-based C preprocessor.

# Why?

The C preprocessor is a powerful tool, but it has some limitations.
For example, it is not possible to use the C preprocessor to generate a list of files in a directory.
CppNix is a custom preprocessor that is more flexible and extensible.

Is it a good idea? Probably not, but it's fun.

# How?

CppNix comes with a setup hook that intercepts `cc1` invocations to perform extra preprocessing.
It also configures the environment to allow Nix itself to run in the build sandbox.

# Example

See [./example](./example) for an example of how to use CppNix in a Nix build and dev shell.

```console
$ nix build .#example
```

```console
$ nix develop .#example
$ cd example/src
$ make
$ ./example
```
