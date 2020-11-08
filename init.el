;; MISC
(setq inhibit-startup-message t) ;; Disable start screen

(scroll-bar-mode -1) ;; Disable scrollbar
(tool-bar-mode -1)   ;; Disable toolbar
(tooltip-mode -1)    ;; Disable tooltip (whatever it is)
(menu-bar-mode -1)   ;; Disable menubar

(set-fringe-mode 10) ;; Give some breathing room

(column-number-mode)
(global-display-line-numbers-mode 1) ;; Enable line numbers
(setq display-line-numbers 'relative) ;; Enable relative line numbers

(show-paren-mode 1) 

(server-start)

;; EMACS X WINDOW MANAGER
(require 'exwm)
(require 'exwm-config)
(require 'exwm-randr)
(exwm-config-default)
(setq exwm-randr-workspace-output-plist '(0 "eDP-1"))
(add-hook 'exwm-randr-screen-change-hook
	  (lambda ()
	    (start-process-shell-command
	     "xrandr" nil "xrandr --output eDP-1 --mode 1366x768 --pos 0x0 --rotate normal")))
(exwm-randr-enable)
(require 'exwm-systemtray)
(exwm-systemtray-enable)

(exwm-input-set-key (kbd "C-x C-k") (lambda ()
				      (interactive)
				      (kill-this-buffer)))

(exwm-input-set-key (kbd "s-q") (defun reload-emacs ()
				   (interactive)
				   (load-file "~/.emacs.d/init.el")))

(exwm-input-set-key (kbd "C-x C-m") (lambda ()
				      (interactive)
				      (exwm-layout-set-fullscreen)))

(exwm-input-set-key (kbd "s-y") (lambda ()
				  (interactive)
				  (save-window-excursion
				    (shell-command "yvlc &"))))

(exwm-input-set-key (kbd "s-s") (lambda ()
				  (interactive)
				  (split-window-horizontally)))

(exwm-input-set-key (kbd "s-v") (lambda ()
				  (interactive)
				  (split-window-vertically)))

(exwm-input-set-key (kbd "s-o o") (lambda ()
				   (interactive)
				   (save-window-excursion
				     (shell-command "mpc toggle"))))

(exwm-input-set-key (kbd "s-o i") (lambda ()
				   (interactive)
				   (save-window-excursion
				     (shell-command "mpc prev"))))

(exwm-input-set-key (kbd "s-o p") (lambda ()
				   (interactive)
				   (save-window-excursion
				     (shell-command "mpc next"))))

(exwm-input-set-key (kbd "s-o z") (lambda ()
				   (interactive)
				   (save-window-excursion
				     (shell-command "mpc random"))))

;; Org Mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; APPEARANCE
(set-face-attribute 'default nil :font "Source Code Pro for Powerline" :height 110) ;; Font
(load-theme 'gruvbox-dark-soft t) ;; Set up gruvbox

;; PACKAGES SETUP
(require 'package)

(setq package-archives '(("melpa"    . "http://melpa.org/packages/")
			 ("org"      . "https://orgmode.org/elpa/")
			 ("elpa"     . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; PACKAGES INSTALL
;;(use-package package-name)

;; Make emacs menus look better and be easier to use with autocompletion
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("RET" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("RET" . ivy-done)
	 ("C-c" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1))

;; Search in a buffer
(use-package swiper)

;; Required by evil mode
(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

;; Evil
(use-package evil
  :ensure t
  :diminish
  :init (setq evil-search-mode 'evil-search)
	(setq evil-undo-system 'undo-tree)
	(setq evil-vsplit-window-right t)
	(setq evil-split-window-below t)
	(setq evil-want-keybinding nil)
	(setq evil-want-integration t)
  :config (evil-mode 1))

;; Evil-collection
(use-package evil-collection
  :after evil
  :ensure t
  :config (evil-collection-init))

;; Evil Nerd Commenter
(use-package evil-nerd-commenter)

;; Doom-modeline
(use-package doom-modeline
 :ensure t
 :init (doom-modeline-mode 1))

;; Idk
(use-package counsel)

;; Treemacs
(use-package treemacs)

;; Haskell
(use-package haskell-mode)

;; Exwm
(use-package exwm)

;; Volume
(use-package pulseaudio-control
  :ensure t)

;; Vterm
(use-package vterm
  :ensure t)

;; Pdf
(use-package pdf-tools
  :ensure t)

;; Magit
(use-package transient
  :ensure t)
(use-package magit
  :ensure t)
(use-package evil-magit
  :ensure t)

;; KEYBINDINGS
(global-set-key (kbd "C-x C-b") 'counsel-switch-buffer) ;; Use counsel to switch buffers
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-l") 'display-line-numbers-mode)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x M-l") 'shrink-window-horizontally)
(global-set-key (kbd "C-x M-h") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x M-j") 'shrink-window)
(global-set-key (kbd "C-x M-k") 'enlarge-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("939ea070fb0141cd035608b2baabc4bd50d8ecc86af8528df9d41f4d83664c6a" default))
 '(display-time-mode t)
 '(doom-modeline-mode t)
 '(exwm-input-global-keys
   '(([8388722]
      . exwm-reset)
     ([8388727]
      . exwm-workspace-switch)
     ([8388646]
      lambda
      (command)
      (interactive
       (list
	(read-shell-command "-> ")))
      (start-process-shell-command command nil command))
     ([8388656]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 0))
     ([8388657]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 1))
     ([ignore]
      . ignore)
     ([8388658]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 2))
     ([8388659]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 3))
     ([8388660]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 4))
     ([8388661]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 5))
     ([8388662]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 6))
     ([8388663]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 7))
     ([8388664]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 8))
     ([8388665]
      lambda nil
      (interactive)
      (exwm-workspace-switch-create 9))
     ("" lambda nil
      (interactive)
      (kill-this-buffer))
     ([8388721]
      . reload-emacs)
     ("" lambda nil
      (interactive)
      (exwm-layout-set-fullscreen))
     ([8388729]
      lambda nil
      (interactive)
      (let
	  ((wconfig
	    (current-window-configuration)))
	(unwind-protect
	    (progn
	      (shell-command "yvlc &"))
	  (set-window-configuration wconfig))))
     ([8388712]
      . windmove-left)
     ([8388714]
      . windmove-down)
     ([8388715]
      . windmove-up)
     ([8388716]
      . windmove-right)
     ([8388616]
      . windmove-swap-states-left)
     ([8388618]
      . windmove-swap-states-down)
     ([8388619]
      . windmove-swap-states-up)
     ([8388620]
      . windmove-swap-states-right)
     ([XF86AudioRaiseVolume]
      . pulseaudio-control-increase-volume)
     ([XF86AudioLowerVolume]
      . pulseaudio-control-decrease-volume)
     ([XF86AudioPrev]
      lambda nil
      (interactive)
      (let
	  ((wconfig
	    (current-window-configuration)))
	(unwind-protect
	    (progn
	      (shell-command "playerctl prev"))
	  (set-window-configuration wconfig))))
     ([XF86AudioPlay]
      lambda nil
      (interactive)
      (let
	  ((wconfig
	    (current-window-configuration)))
	(unwind-protect
	    (progn
	      (shell-command "playerctl play-pause"))
	  (set-window-configuration wconfig))))
     ([XF86AudioNext]
      lambda nil
      (interactive)
      (let
	  ((wconfig
	    (current-window-configuration)))
	(unwind-protect
	    (progn
	      (shell-command "playerctl next"))
	  (set-window-configuration wconfig))))))
 '(exwm-input-prefix-keys
   '("" "" ""
     [134217848]
     [134217824]
     [134217766]
     [134217786]
     [8388719]))
 '(exwm-manage-force-tiling nil)
 '(global-undo-tree-mode t)
 '(ivy-mode t)
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-w3m))
 '(package-selected-packages
   '(magit-gh-pulls transient evil-magit magit pulseaudio-control pdf-tools vterm evil-nerd-commenter exwm haskell-mode god-mode counsel-web counsel-css treemacs undo-tree doom-modeline use-package gruvbox-theme evil counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
