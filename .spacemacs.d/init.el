;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation nil
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path (list (expand-file-name "layers/" dotspacemacs-directory))
   dotspacemacs-configuration-layers
   '(
     ansible
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence "df"
                      auto-completion-complete-with-key-sequence-delay 0.4
                      auto-completion-enable-snippets-in-popup nil
                      auto-completion-enable-help-tooltip t
                      company-tooltip-align-annotations t)
     command-log
     cscope
     docker
     evil-cleverparens
     evil-commentary
     gtags
     (ibuffer :variables
              ibuffer-group-buffers-by 'projects)
     imenu-list
     semantic
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     vinegar
     vim-empty-lines
     vim-powerline

     emacs-lisp
     systemd
     shell-scripts

     c-c++
     (haskell :variables
              haskell-completion-backend 'ghc-mod
              haskell-enable-hindent-style "fundamental")
     html
     java
     javascript
     latex
     markdown
     org
     php
     python
     sql
     yaml
     )
   dotspacemacs-additional-packages
   '(
     color-theme-sanityinc-solarized
     )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 3))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(solarized-dark)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 2)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 10
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom

   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'current
   dotspacemacs-persistent-server t
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (setq exec-path-from-shell-arguments '("-l"))

  ;; theme setup
  (setq solarized-distinct-fringe-background t)
  (setq solarized-emphasize-indicators t)
  (setq solarized-use-less-bold t)
  (setq solarized-distinct-doc-face t)
  (setq solarized-use-more-italic t)
  (setq solarized-use-variable-pitch t)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (setq create-lockfiles nil)

  (xterm-mouse-mode -1)

  (global-auto-revert-mode t)

  ;; (setq fci-rule-column 101)
  ;; (setq fci-rule-width 4)
  ;; (setq fci-rule-color "lightblue")
  ;; (add-hook 'prog-mode-hook #'fci-mode)

  (add-hook 'prog-mode-hook 'indent-guide-mode)

  (setq whitespace-line-column 100)
  (setq whitespace-style '(face tabs lines-tail trailing))
  (add-hook 'prog-mode-hook 'whitespace-mode)

  (add-hook 'imenu-after-jump-hook (lambda () (recenter 10)))

  (setq-default c-basic-offset 4)

  (setq geben-close-mirror-file-after-finish t)
  (setq geben-pause-at-entry-line t)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (powerline parent-mode pkg-info epl flx evil goto-chg diminish eclim company-auctex bind-map bind-key packed auctex f s avy popup package-build clojure-snippets clj-refactor inflections edn peg cider-eval-sexp-fu cider seq queue clojure-mode hydra spinner pcache iedit highlight insert-shebang hide-comnt helm-purpose window-purpose anzu undo-tree helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-gtags helm-flx helm-descbinds helm-css-scss helm-cscope helm-company helm-c-yasnippet helm-ag ace-jump-helm-line evil-snipe evil-commentary async flycheck smartparens helm helm-core projectile jade-mode counsel swiper ivy tabbar-ruler mode-icons tabbar origami org alert log4e gntp nlinum-relative nlinum markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode ibuffer-projectile haml-mode paredit php-mode web-completion-data dash-functional tern company-quickhelp pos-tip company command-log-mode yasnippet anaconda-mode pythonic auto-complete vi-tilde-fringe yapfify yaml-mode xcscope ws-butler window-numbering which-key wgrep web-mode web-beautify volatile-highlights uuidgen use-package toc-org tagedit systemd stickyfunc-enhance srefactor sql-indent spacemacs-theme spaceline solarized-theme smex slim-mode scss-mode sass-mode restclient restart-emacs request rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el paradox org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file ob-http neotree mwim move-text mmm-mode markdown-toc macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc ivy-hydra info+ indent-guide imenu-list ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-make google-translate golden-ratio gnuplot gh-md ggtags geben flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav dumb-jump drupal-mode disaster define-word cython-mode counsel-projectile company-web company-tern company-statistics company-shell company-emacs-eclim company-c-headers company-anaconda column-enforce-mode color-theme-sanityinc-solarized coffee-mode cmake-mode clean-aindent-mode clang-format auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (jinja2-mode intero hlint-refactor hindent helm-hoogle haskell-snippets flyspell-correct-helm flyspell-correct flycheck-haskell dockerfile-mode docker tablist magit-popup docker-tramp dante company-ghci company-ghc ghc haskell-mode company-cabal company-ansible cmm-mode auto-dictionary ansible-doc ansible symon string-inflection realgud test-simple loc-changes load-relative password-generator meghanada groovy-mode groovy-imports gradle-mode flycheck-bashate evil-lion ensime sbt-mode scala-mode editorconfig company-php ac-php-core eclim company-auctex auctex fuzzy winum dash powerline parent-mode pkg-info epl flx evil goto-chg diminish bind-map bind-key packed f s avy popup package-build clojure-snippets clj-refactor inflections edn peg cider-eval-sexp-fu cider seq queue clojure-mode hydra spinner pcache iedit highlight insert-shebang hide-comnt helm-purpose window-purpose anzu undo-tree helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-gtags helm-flx helm-descbinds helm-css-scss helm-cscope helm-company helm-c-yasnippet helm-ag ace-jump-helm-line evil-snipe evil-commentary async flycheck smartparens helm helm-core projectile jade-mode counsel swiper ivy tabbar-ruler mode-icons tabbar origami org alert log4e gntp nlinum-relative nlinum markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode ibuffer-projectile haml-mode paredit php-mode web-completion-data dash-functional tern company-quickhelp pos-tip company command-log-mode yasnippet anaconda-mode pythonic auto-complete vi-tilde-fringe yapfify yaml-mode xcscope ws-butler window-numbering which-key wgrep web-mode web-beautify volatile-highlights uuidgen use-package toc-org tagedit systemd stickyfunc-enhance srefactor sql-indent spacemacs-theme spaceline solarized-theme smex slim-mode scss-mode sass-mode restclient restart-emacs request rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el paradox org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file ob-http neotree mwim move-text mmm-mode markdown-toc macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc ivy-hydra info+ indent-guide imenu-list ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-make google-translate golden-ratio gnuplot gh-md ggtags geben flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav dumb-jump drupal-mode disaster define-word cython-mode counsel-projectile company-web company-tern company-statistics company-shell company-emacs-eclim company-c-headers company-anaconda column-enforce-mode color-theme-sanityinc-solarized coffee-mode cmake-mode clean-aindent-mode clang-format auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
