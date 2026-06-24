;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; This is your Doom Emacs package configuration file. Declare packages here
;; and run 'doom sync' on the command line, then restart Emacs for the changes
;; to take effect -- or use 'M-x doom/reload'.

;;------------------------------------------------------------------------------
;; Package Installation
;;------------------------------------------------------------------------------
;; To install a package from MELPA, ELPA, or emacsmirror:
;; (package! some-package)

;;------------------------------------------------------------------------------
;; Installing Packages from Remote Git Repositories
;;------------------------------------------------------------------------------
;; To install a package directly from a remote git repository, specify a `:recipe'.
;; Documentation on `:recipe' format can be found here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;;
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;;------------------------------------------------------------------------------
;; Specifying Files for Packages
;;------------------------------------------------------------------------------
;; If the package you are trying to install does not contain a PACKAGENAME.el file,
;; or is located in a subdirectory of the repo, specify `:files' in the `:recipe':
;;
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;;------------------------------------------------------------------------------
;; Disabling Built-in Packages
;;------------------------------------------------------------------------------
;; To disable a package included with Doom, use the `:disable' property:
;; (package! builtin-package :disable t)

;;------------------------------------------------------------------------------
;; Overriding Recipes of Built-in Packages
;;------------------------------------------------------------------------------
;; You can override the recipe of a built-in package without specifying all the
;; properties for `:recipe'. These will inherit the rest of its recipe from Doom
;; or MELPA/ELPA/Emacsmirror:
;;
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;;------------------------------------------------------------------------------
;; Specifying Branch or Commit for Packages
;;------------------------------------------------------------------------------
;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (see
;; radian-software/straight.el#279):
;;
;; (package! builtin-package :recipe (:branch "develop"))
;;
;; Use `:pin' to specify a particular commit to install:
;; (package! builtin-package :pin "1a2b3c4d5e")

;;------------------------------------------------------------------------------
;; Unpinning Packages
;;------------------------------------------------------------------------------
;; Doom's packages are pinned to specific commits and updated from release to release.
;; The `unpin!' macro allows you to unpin single packages:
;; (unpin! pinned-package)
;; ...or multiple packages:
;; (unpin! pinned-package another-pinned-package)
;; ...or *all* packages (NOT RECOMMENDED; this will likely break things):
;; (unpin! t)

;;------------------------------------------------------------------------------
;; Example Package Installation
;;------------------------------------------------------------------------------
;; Install the Catppuccin theme from GitHub
(package! catppuccin-theme
  :recipe (:host github :repo "catppuccin/emacs")
  :pin "COMMIT_HASH")
