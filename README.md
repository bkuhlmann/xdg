<p align="center">
  <img src="xdg.png" alt="XDG Icon"/>
</p>

# XDG

[![Gem Version](https://badge.fury.io/rb/xdg.svg)](http://badge.fury.io/rb/xdg)
[![Code Climate Maintainability](https://api.codeclimate.com/v1/badges/73c8f06ae65cbe663e1c/maintainability)](https://codeclimate.com/github/bkuhlmann/xdg/maintainability)
[![Code Climate Test Coverage](https://api.codeclimate.com/v1/badges/73c8f06ae65cbe663e1c/test_coverage)](https://codeclimate.com/github/bkuhlmann/xdg/test_coverage)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/xdg.svg?style=svg)](https://circleci.com/gh/bkuhlmann/xdg)

Provides a Ruby implementation of the [XDG Base Directory
Specification](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html).

:bulb: If you write a lot of Command Line Interfaces and would like additional syntactic
sugar that includes what is found in this gem, make sure to check out the
[Runcom](https://github.com/bkuhlmann/runcom) gem too.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Features](#features)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Usage](#usage)
      - [Overview](#overview)
      - [Variable Defaults](#variable-defaults)
      - [Variable Behavior](#variable-behavior)
        - [`$XDG_*_DIRS`](#xdg__dirs)
        - [`$XDG_*_HOME`](#xdg__home)
      - [Variable Priority](#variable-priority)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Features

- Provides a `XDG::Environment` object that adheres to the *XDG Base Directory Specification* with
  access to the following environment settings:
  - `$XDG_CACHE_HOME`
  - `$XDG_CONFIG_HOME`
  - `$XDG_CONFIG_DIRS`
  - `$XDG_DATA_HOME`
  - `$XDG_DATA_DIRS`

## Requirements

1. [Ruby 2.6.3](https://www.ruby-lang.org)

## Setup

To install, run:

    gem install xdg

Add the following to your Gemfile:

    gem "xdg"

## Usage

The following describes how to use this XDG implementation.

#### Overview

To get up and running quickly, use `XDG::Environment` as follows:

    xdg = XDG::Environment.new
    xdg.cache_home # <= Answers computed `$XDG_CACHE_HOME` value.
    xdg.config_home # <= Answers computed `$XDG_CONFIG_HOME` value.
    xdg.config_dirs # <= Answers computed `$XDG_CONFIG_DIRS` value.
    xdg.data_home # <= Answers computed `$XDG_DATA_HOME` value.
    xdg.data_dirs # <= Answers computed `$XDG_DATA_DIRS` value.

The *computed* value, in this case, is either the user-defined value of the key or the default
value, per specification, when the key is not defined or empty. For more on this, scroll down to the
*Variable Defaults* section to learn more.

The `XDG::Environment` wraps the following objects which can be used individually if you
don't want to load the entire environment:

    cache = XDG::Cache.new
    config = XDG::Config.new
    data = XDG::Data.new

The `cache`, `config`, and `data` objects share the same API which means you can ask each the
following messages:

- `#home` - Answers the home directory as computed via the `$XDG_*_HOME` key.
- `#directories` - Answers an array directories as computed via the `$XDG_*_DIRS` key.
- `#all` - Answers an array of *all* directories as computed from the combined `$XDG_*_HOME` and
  `$XDG_*_DIRS` values (with `$XDG_*_HOME` prefixed at the start of the array).

#### Variable Defaults

The *XDG Base Directory Specification* defines environment variables and associated default values
when not defined or empty. The following defaults, per specification, are implemented by the
`XDG` objects:

- `$XDG_CACHE_HOME="$HOME/.cache"`
- `$XDG_CONFIG_HOME="$HOME/.config"`
- `$XDG_CONFIG_DIRS="/etc/xdg"`
- `$XDG_DATA_HOME="$HOME/.local/share"`
- `$XDG_DATA_DIRS="/usr/local/share/:/usr/share/"`
- `$XDG_RUNTIME_DIR`

The `$XDG_RUNTIME_DIR` deserves special mention as it's not, *currently*, implemented as part of
this gem because it is more user/environment specific. Here is how the `$XDG_RUNTIME_DIR` is meant
to be used should you choose to use it:

- *Must* reference user-specific non-essential runtime files and other file objects (such as
  sockets, named pipes, etc.)
- *Must* be owned by the user with *only* the user having read and write access to it.
- *Must* have a Unix access mode of `0700`.
- *Must* be bound to the user when logging in.
- *Must* be removed when the user logs out.
- *Must* be pointed to the same directory when the user logs in more than once.
- *Must* exist from first login to last logout on the system and not removed in between.
- *Must* not allow files in the directory to survive reboot or a full logout/login cycle.
- *Must* keep the directory on the local file system and not shared with any other file systems.
- *Must* keep the directory fully-featured by the standards of the operating system. Specifically,
  on Unix-like operating systems AF_UNIX sockets, symbolic links, hard links, proper permissions,
  file locking, sparse files, memory mapping, file change notifications, a reliable hard link count
  must be supported, and no restrictions on the file name character set should be imposed. Files in
  this directory *may* be subjected to periodic clean-up. To ensure files are not removed,
  they should have their access time timestamp modified at least once every 6 hours of monotonic
  time or the 'sticky' bit should be set on the file.
- When not set, applications should fall back to a replacement directory with similar capabilities
  and print a warning message. Applications should use this directory for communication and
  synchronization purposes and should not place larger files in it, since it might reside in runtime
  memory and cannot necessarily be swapped out to disk.

#### Variable Behavior

The behavior of most XDG environment variables can be lumped into two categories:

- `$XDG_*_HOME`
- `$XDG_*_DIRS`

Each is described in detail below.

##### `$XDG_*_DIRS`

These variables are used to define a colon (`:`) delimited list of directories. Order is important
as the first directory defined will take precedent over the following directory and so forth. For
example, here is a situation where the `XDG_CONFIG_DIRS` key has a custom value:

    XDG_CONFIG_DIRS="/example/one/.config:/example/two/.settings:/example/three/.configuration"

    # Yields the following, colon delimited, array:
    [
      "/example/one/.config",
      "/example/two/.settings",
      "/example/three/.configuration"
    ]

In the above example, the `"/example/one/.config"` path takes *highest* priority since it was
defined first.

##### `$XDG_*_HOME`

These variables take precidence over the corresponding `$XDG_*_DIRS` environment variables. Using a
modified version of the `$XDG_*_DIRS` example, shown above, we could have the following setup:

    XDG_CONFIG_HOME="/example/priority"
    XDG_CONFIG_DIRS="/example/one/.config:/example/two/.settings"

    # Yields the following, colon delimited, array:
    [
      "/example/priority",
      "/example/one/.config",
      "/example/two/.settings"
    ]

Due to `XDG_CONFIG_HOME` taking precidence over the `XDG_CONFIG_DIRS`, the path with the *highest*
priority in this example is: `"/example/priority"`.

#### Variable Priority

Path precedence is determined in the following order (with the first taking highest priority):

1. `$XDG_*_HOME` - Will be used if defined. Otherwise, falls back to specification default.
1. `$XDG_*_DIRS` - Iterates through directories in order defined (with first taking highest
   priority). Otherwise, falls back to specification default.

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2019 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
