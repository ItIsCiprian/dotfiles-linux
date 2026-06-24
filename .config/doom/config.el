;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; This is your private Doom Emacs configuration file.
;; You do not need to run 'doom sync' after modifying this file.

;;------------------------------------------------------------------------------
;; User Information
;;------------------------------------------------------------------------------
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;;------------------------------------------------------------------------------
;; Font Configuration
;;------------------------------------------------------------------------------
(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;;------------------------------------------------------------------------------
;; Theme Configuration
;;------------------------------------------------------------------------------
;; Set a default fallback theme
(setq doom-theme 'doom-one)

;; Use Catppuccin theme
(use-package! catppuccin-theme
  :config
  ;; Set the Catppuccin flavour (latte, frappe, macchiato, or mocha)
  (setq catppuccin-flavour 'macchiato)
  (load-theme 'catppuccin t))

;;------------------------------------------------------------------------------
;; Line Numbers Configuration
;;------------------------------------------------------------------------------
(setq display-line-numbers-type t)

;;------------------------------------------------------------------------------
;; Org-mode Configuration
;;------------------------------------------------------------------------------
(setq org-directory "~/org/")

;;------------------------------------------------------------------------------
;; Package Configuration
;;------------------------------------------------------------------------------
;; Add other packages below using `use-package!` if necessary
