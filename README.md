# [vmux](http://github.com/kylo252/vmux)
neovim session handler within tmux

# Demo

[![asciicast](https://asciinema.org/a/46634.png)](https://asciinema.org/a/46634)

# Features

* Each `tmux` session has its own editor session
* One global editor session can be started
* Supports [neovim](http://neovim.org/) 
* Seamless integration with `nvim` through wrapper scripts
  that directly call `vmux` - keep your muscle's memory :-)
* Once a session has been started in one editor, e.g. `nvim`, the session will
  be reused even if another editor is called.
* A new session is started if the old session doesn't exist anymore
* Automatically select tmux pane running the local or global vim session

# Installation

Python3 is required as well as `tmux` and `nvim`.

## Via PyPI

Install `vmux` using `pip`:

  ```shell
  pip install --user vmux
  # or 
  pipx install vmux
  ```

## From Source

Clone the repository and install vmux:

    git clone https://github.com/jceb/vmux.git
    cd vmux
    make DESTDIR=~/.local install

    # if wrapper scripts are desired, install them as well
    make DESTDIR=~/.local all

    # add ~/.local/bin to PATH variable
    export PATH="${HOME}/.local/bin:${PATH}"

# Usage

Start editor session through `vmux` 
wrapper scripts:

    tmux
    vmux MYFILE
    # split tmux window
    vmux MY_OTHERFILE

Once a session has been started, it doesn't matter anymore which editor has been
used.  `vmux` will open every file in the existing session even if a wrapper
script of a different editor is used.

# Customization

Define default editor:

    # export environment variable VMUX_EDITOR, either vim or nvim
    export VMUX_EDITOR=nvim

Define path to the real editor executables.  This is required if the wrapper
scripts are used that will hide the real editors in `$PATH`.

    export VMUX_REALEDITOR_NVIM=/usr/bin/nvim


Define that a global session should be started.  One global and multiple local
sessions can exists next to one another:

    export VMUX_GLOBAL=1

Define that the tmux pane shall not be selected automatically:

    export VMUX_NOT_SELECT_PANE=1

Define socket path for `nvim`:

    export VMUX_NVIM_SESSION_DIR=~/.cache/nvim_sessions

Turn on debugging:

    export VMUX_DEBUG=1

# How it works

When `vmux` is called, it defines a variable `VMUX_SESSION_<ID>` that is unique
to the current `tmux` session.  The value of the variable is set to `<ID>` that
is used as session name for `vim.vmux` and `nvim.vmux`.  Furthermore, the global
session that is started through `gvim.vmux` is stored in the environment
variables `VMUX_SESSION` and `VMUX_GLOBAL_PANE`.  The session name is set to
`global`.

# Known issues

I noticed with neovim that the session socket doesn't always get removed when it
ends.  This might causes vmux to permanently fail to start a new session.  It
can be manually resolved by deleting the stalled socket file in neovim's session
folder.

# Similar projects

* [tmux-omnivim](https://github.com/andy-lang/tmux-omnivim) creates one global
  session while `vmux` creates one session per `tmux` session and it also
  supports one global session next to multiple local sessions.
