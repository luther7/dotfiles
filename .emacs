;;
;; .emacs
;;

;;
;; Packages:
;;

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;
;; Nord Theme:
;;

(use-package nord-theme :ensure t)

(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(load-theme 'nord t)

;;
;; Powerline:
;;

(use-package powerline :ensure t)
(use-package powerline-evil :ensure t)

(powerline-evil-center-color-theme)

;;
;; Doom Modeline:
;;

;; (use-package doom-modeline
;;       :ensure t
;;       :hook (after-init . doom-modeline-mode))
;; 
;; (doom-modeline-mode 1)

;;
;; Customize:
;;

(set-default-font "Source Code Pro 14")
(setq default-frame-alist '((font . "Source Code Pro 14")))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq default-tab-width 2)

;;
;; Daemon
;;
(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (select-frame frame)
            (load-theme 'nord t)
            (menu-bar-mode -1)
            (tool-bar-mode -1)
            (toggle-scroll-bar -1))))

;;
;; Terminals:
;;

(use-package multi-term :ensure t)

(setq multi-term-program "/bin/bash")

;;
;; Dashboard:
;;

(use-package page-break-lines :ensure t)
(use-package all-the-icons :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(setq dashboard-startup-banner 'logo)
(setq dashboard-set-footer nil)
(setq dashboard-items '((bookmarks . 5)
			(recents  . 5)
			(projects . 5)
                        (registers . 5)
			))

;;
;; Evil:
;;

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(setq evil-want-keybinding nil)

(use-package evil-collection
  :after evil
  :ensure t
  :custom
  (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

(evil-set-initial-state 'term-mode "emacs")

;;
;; Swiper/Ivy/Counsel:
;;

(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))


(use-package swiper
  :ensure t
  :bind (("C-s" . swiper-isearch)
	 ("C-r" . swiper-isearch)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

;;
;; Ace Window:
;;

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window))

;;
;; Parens
;;

(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode)
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config))

(show-paren-mode t)

;;
;; iBuffer:
;;

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("org" (name . "^.*org$"))
	       ("magit" (mode . magit-mode))
	       ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
	       ("programming" (or
			       (mode . elisp-mode)
			       (mode . go-mode)
			       (mode . python-mode)
			       (mode . c-mode)
			       (mode . c++-mode)))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-auto-mode 1)
	    (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-expert t)
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))

;;
;; Git:
;;

(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)
    ))

(use-package evil-magit :ensure t)

(setq magit-status-margin
      '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
(use-package git-timemachine
  :ensure t
  )
(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

;;
;; Flycheck:
;;

(use-package flycheck
  :init
  (global-flycheck-mode t)
  (progn
    (define-fringe-bitmap 'my-flycheck-fringe-indicator
      (vector #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00011100
              #b00111110
              #b00111110
              #b00111110
              #b00011100
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000))
    (flycheck-define-error-level 'error
      :severity 2
      :overlay-category 'flycheck-error-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-error)
    (flycheck-define-error-level 'warning
      :severity 1
      :overlay-category 'flycheck-warning-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-warning)
    (flycheck-define-error-level 'info
      :severity 0
      :overlay-category 'flycheck-info-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-info)))

(defun flycheck-face-customizations ()
  (set-face-attribute 'flycheck-error
                      nil
                      :underline
                      (append (list :style 'line)
                              (when (plist-get (face-attribute 'flycheck-error :underline) :color)
                                (list :color (plist-get (face-attribute 'flycheck-error :underline) :color)))))
  (set-face-attribute 'flycheck-warning
                      nil
                      :underline
                      (append (list :style 'line)
                              (when (plist-get (face-attribute 'flycheck-warning :underline) :color)
                                (list :color (plist-get (face-attribute 'flycheck-warning :underline) :color)))))
  (set-face-attribute 'flycheck-info
                      nil
                      :underline
                      (append (list :style 'line)
                              (when (plist-get (face-attribute 'flycheck-info :underline) :color)
                                (list :color (plist-get (face-attribute 'flycheck-info :underline) :color))))))

(add-hook 'flycheck-mode-hook #'flycheck-face-customizations)

;;
;; Yasnippet:
;;

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets :ensure t)
(use-package yasnippet-classic-snippets :ensure t)

;;
;; LSP:
;;

(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil)
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((go-mode python-mode c-mode c++-mode) . lsp))


(use-package lsp-ui
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind (:map lsp-ui-mode-map
	      ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	      ([remap xref-find-references] . lsp-ui-peek-find-references)
	      ("C-c u" . lsp-ui-imenu))
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-border (face-foreground 'default)))

;;
;; Projectile:
;;

(use-package projectile :ensure t)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/workspace/personal" "~/silverpond/"))
(setq projectile-switch-project-action #'projectile-dired)
(setq projectile-mode-line "Projectile")

;;
;; Company:
;;

(use-package company
  :ensure t
  :config
  (add-to-list 'company-backends 'company-elisp)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode t)
  )

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends)
  )

;;
;; Languages:
;;

;; Dockerfile
(use-package dockerfile-mode :ensure t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Go
(use-package go-mode :ensure t)
(add-hook 'go-mode-hook 'lsp-deferred)

;;
;; End.
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-setup-minibuffer t)
 '(lsp-auto-guess-root nil)
 '(lsp-prefer-flymake nil)
 '(lsp-ui-doc-border "#D8DEE9" t)
 '(lsp-ui-doc-enable t t)
 '(lsp-ui-doc-header t t)
 '(lsp-ui-doc-include-signature t t)
 '(lsp-ui-doc-position (quote top) t)
 '(lsp-ui-sideline-enable t t)
 '(lsp-ui-sideline-ignore-duplicate t t)
 '(lsp-ui-sideline-show-code-actions t t)
 '(package-selected-packages
   (quote
    (multi-term go-mode dockerfile-mode powerline-evil powerline company company-mode helm-projectile projectile helm nord-theme use-package evil)))
 '(sp-escape-quotes-after-insert nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))
