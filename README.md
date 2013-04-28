SLINGSHOT
=========

[![travis-ci status](https://secure.travis-ci.org/gvvaughan/slingshot.png?branch=master)](http://travis-ci.org/gvvaughan/slingshot/builds)

[Slingshot][] releases rocks!

The files shipped with this project form the common foundation I use
to manage [LuaRocks][] releases from github for my other projects, to
save having to propagate changes to the release process between them
every-time I make an update.

Installation
------------

Using it involves copying whichever of the following files you want to
make use of into your project, and checking them in:

 * `bootstrap`:
   a complete rewrite of the [GNU Gnulib][] `bootstrap` script, for
   figuring out what autotools need to be run, in what order, and with
   what arguments to bootstrap a newly checked out working copy. This
   version is much more robust, a lot more user friendly, slightly
   faster, and a little more portable than the GNU version.  It's also
   quite a lot larger than the GNU implementation.
 * `bootstrap.texi`:
   texinfo documentation for `bootstrap`.
 * `gitlog-to-changelog`, `do-release-commit-and-tag`:
   adapted from the [GNU Gnulib][] project, with changes for portability
   and applicability to a Lua based projects.
 * `ax_lua.m4`, `ax_compare_version.m4`:
   taken from the [GNU Autoconf Archive][], to help autoconf discover
   where Lua and its files are installed on your system.
 * `ax_with_prog.m4`:
   also from the [GNU Autoconf Archive][], to simplify the process of
   finding other programs for your project.
 * `configure.ac`:
   wrapper for the macros above, currently generates a `configure` that
   turns `mkrockspecs.in` into `mkrockspecs`, and generates a manual
   page for the same - though you can use it as the basis for your own
   `configure.ac` with a little editing.
 * `mkrockspecs`:
   take a set of defaults (see slingshot's own `rockspec.conf`) from
   a [YAML][] format specification, fill in the missing entries, and
   output a full [LuaRocks][] rockspec file.
 * `rockspecs.mk`:
    a portable make fragment to drive the `mkrockspecs` script, which
    you can include in your `Makefile.am`.
 * `release.mk`:
   a set of GNU make maintainer rules to run pre-release checks, build
   a distribution tarball, and then switch to the git release branch
   and check-in the unpacked distribution files.  Finally, the resulting
   release check-in is tagged so that the rockspecs files generated by
   `mkrockspecs` can fetch the associated github generated zipball
   attached to that tag.
 * `mail`:
   a POSIX mail interface wrapper for mutt, in case your machine
   doesn't have one.  Used by `release.mk`, so you needn't check this
   in to your project, just put it along your command seach path if
   `make release` fails to email announcements properly without it.
 * `GNUmakefile`:
   a wrapper for `release.mk`, along with auto-rebootstrap rules.
 * `Makefile.am`:
   a wrapper for `rockspecs.mk`, as a starter for your own Makefile.am.
 * `travis.yml.in`:
   configuration for the free gitub Travis CI service.

In addition to the files above, slingshot expects you to maintain your
release notes in a GNU format NEWS file, such as the one used by
slingshot itself, and a revision controlled `.prev-version` file with
the previous release version number.  `release.mk` will maintain these
files for you once you have them in place.

You'll also need a `rockspec.conf` file to feed the `mkrockspecs`
script.

Usage
-----

Use `./bootstrap` to run autotools (you can customize the behaviour of
this script with a `bootstrap.conf` file, as described in the
`bootstrap.texi` documentation).

`GNUmakefile` will run `bootstrap` for you, even in a freshly checked
out tree, provided you pass it a target to build.

Use `make rockspecs` to trigger the rules in `rockspecs.mk` which will
use the values from `AC_INIT` in `configure.ac` and `rockspec.conf` to
build project specific rockspec files, suitable for uploading to
luarocks.org.

Use `make stable` (or `make alpha`, or `make beta` if appropriate) to
locall run the pre-release sanity checks, the release itself, and some
post-release administration.  These rules only affect your local git
repository, and don't push the changes back to origin.

Use `make release RELEASE_TYPE=stable` to perform a full release
process, including pushing changes back to origin, and mailing an
announcements taken from the NEWS file using woger.


[gnu gnulib]: http://gnu.org/s/gnulib
[gnu autoconf archive]: http://gnu.org/s/autoconf-archive
[lua]:        http://www.lua.org
[luarocks]:   http://www.luarocks.org
[slingshot]:  http://github.org/gvvaughan/slingshot
[yaml]:       http//yaml.org
