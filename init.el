;;; init --- init.el

;;; Commentary:

;;; Code:

(setq custom-file "~/.emacs.d/custom.el")
;(load custom-file)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package init-meta
  :defer t
  :init
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (add-hook 'text-mode-hook 'auto-fill-mode)
  (column-number-mode 1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (set-frame-size (selected-frame) 80 50)
  (set-language-environment "UTF-8")
  (setq auto-save-default nil)
  (setq indent-tabs-mode nil)
  (setq inhibit-startup-echo-area-message t)
  (setq inhibit-startup-message t)
  (setq major-mode 'text-mode)
  (setq make-backup-files nil)
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
  (setq require-final-newline t)
  (setq scroll-conservatively 101)
  (show-paren-mode 1)
  (size-indication-mode 1)
  (tool-bar-mode -1))

(use-package theme-meta
  :defer t
  :init
  (use-package apropospriate-theme :ensure t :defer t)
  (use-package autumn-light-theme :ensure t :defer t)
  (use-package faff-theme :ensure t :defer t)
  (use-package farmhouse-theme :ensure t :defer t)
  (use-package leuven-theme :ensure t :defer t)
  (use-package majapahit-theme :ensure t :defer t)
  (use-package moe-theme :ensure t :defer t)
  (use-package monokai-theme :ensure t :defer t)
  (use-package solarized-theme :ensure t :defer t)
  (use-package spacemacs-theme :ensure t :defer t)
  (use-package ubuntu-theme :ensure t :defer t)
  (use-package zenburn-theme :ensure t :defer t)
  (load-theme 'spacemacs-light 'no-confirm))

(use-package face-meta
  :defer t
  :init
  (set-face-attribute 'default nil
                      :font "Source Code Pro 8")
  (set-face-attribute 'fixed-pitch nil
                      :font "Source Code Pro 8")
  (set-face-attribute 'variable-pitch nil
                      :font "Noto Sans 8")
  (set-face-attribute 'Info-quoted nil
                      :font "Source Code Pro 8"
                      :background "lemon chiffon"
                      :foreground "indian red"))

(use-package bind-key-meta
  :defer t
  :init
  (bind-key "M-<left>" 'windmove-left)
  (bind-key "M-<right>" 'windmove-right)
  (bind-key "M-<up>" 'windmove-up)
  (bind-key "M-<down>" 'windmove-down))

(use-package agda2
  :defer t
  :init
  (let ((coding-system-for-read 'utf-8)
        (file (shell-command-to-string "agda-mode locate")))
    (when (file-exists-p file)
      (load-file file))))

(use-package company
  :ensure t
  :config (global-company-mode 1)
  :diminish company-mode)

(use-package eldoc
  :config (global-eldoc-mode 1))

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode 1))

(use-package golden-ratio
  :ensure t
  :config (golden-ratio-mode)
  :diminish golden-ratio-mode)

(use-package helm-meta
  :defer t
  :init
  (use-package helm-config
    :ensure helm
    :demand t
    :bind (("C-x C-f" . helm-find-files)
	   ("C-Z" . helm-buffers-list)
	   ("C-z" . helm-mini)
	   ("M-x" . helm-M-x))
    :config
    (use-package helm-mode
      :diminish helm-mode
      :init (helm-mode 1))))

(use-package hl-line
  :config (global-hl-line-mode 1))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package org
  :bind (("C-c o a" . org-agenda)
         ("C-c o b" . org-iswitchb)
         ("C-c o c" . org-capture)
         ("C-c o l" . org-store-link)))

(use-package slime
  :ensure t
  :commands (slime slime-mode))

(use-package haskell-meta
  :defer t
  :init
  (use-package haskell-mode
    :ensure t)
  (use-package flycheck-haskell
    :ensure t))

(eval-and-compile
  (defvar opam-site-lisp
    (concat
     (substring
      (shell-command-to-string "opam config var share 2> /dev/null")
      0 -1)
     "/emacs/site-lisp")))

(use-package ocaml-meta
  :defer t
  :init
  (use-package tuareg
    :ensure t
    :commands tuareg-mode)
  (use-package merlin
    :load-path opam-site-lisp
    :commands merlin-mode
    :init (add-hook 'tuareg-mode-hook 'merlin-mode))
  (use-package utop
    :load-path opam-site-lisp
    :commands (utop utop-minor-mode)
    :init (add-hook 'tuareg-mode-hook 'utop-minor-mode)
    :diminish utop-minor-mode)
  (use-package ocp-indent
    :load-path opam-site-lisp
    :commands ocp-setup-indent
    :init (add-hook 'tuareg-mode-hook 'ocp-setup-indent)))

(use-package proof-meta
  :defer t
  :init
  (use-package proof-site
    :load-path "~/.emacs.d/site-lisp/proof-general/ProofGeneral/generic")
  (use-package company-coq
    :ensure t
    :commands company-coq-initialize
    :init (add-hook 'coq-mode-hook 'company-coq-initialize)))

(use-package sml-meta
  :defer t
  :init
  (use-package sml-mode
    :ensure t
    :commands (sml-mode sml-run))
  (use-package ob-sml
    :ensure t))

(provide 'init)
;;; init.el ends here
