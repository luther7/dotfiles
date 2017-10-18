;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path (list (expand-file-name "layers/" dotspacemacs-directory))
   dotspacemacs-configuration-layers
   '(
     php
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence "df"
                      auto-completion-complete-with-key-sequence-delay 0.4
                      auto-completion-enable-snippets-in-popup nil
                      auto-completion-enable-help-tooltip t
                      company-tooltip-align-annotations t)
     cscope
     docker
     evil-cleverparens
     evil-commentary
     git
     gtags
     (ibuffer :variables
              ibuffer-group-buffers-by 'projects)
     (ranger :variables
             ranger-cleanup-on-disable t
             ranger-show-dotfiles t)
     semantic
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     (version-control :variables
                      version-control-diff-tool 'diff-hl)
     vim-empty-lines
     vim-powerline
     vinegar

     ansible
     apache
     nginx
     systemd
     shell-scripts

     c-c++
     emacs-lisp
     (haskell :variables
              haskell-completion-backend 'ghc-mod
              haskell-enable-hindent-style "fundamental")
     html
     ;; java
     javascript
     ;; latex
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
     geben
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
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
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
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state t
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
   dotspacemacs-highlight-delimiters 'all
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
  (setq solarized-distinct-fringe-background t)
  (setq solarized-emphasize-indicators t)
  (setq solarized-use-less-bold t)
  (setq solarized-distinct-doc-face t)
  (setq solarized-use-more-italic t)
  (setq solarized-use-variable-pitch t)

  (setq-default git-magit-status-fullscreen t)
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
  (add-hook 'prog-mode-hook 'indent-guide-mode)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
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
    (anaconda-mode ac-php-core company yasnippet haml-mode flyspell-correct-popup window-purpose tern goto-chg markdown-mode magit-popup iedit smartparens evil flycheck haskell-mode helm helm-core multiple-cursors async projectile org-plus-contrib s ranger git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-commit with-editor git-gutter diff-hl browse-at-remote yapfify yaml-mode ws-butler winum which-key web-mode web-beautify volatile-highlights uuidgen use-package toc-org tagedit systemd symon string-inflection stickyfunc-enhance srefactor sql-indent spaceline solarized-theme slim-mode scss-mode sass-mode restart-emacs request realgud rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el password-generator paradox org-projectile org-present org-pomodoro org-download org-bullets org-brain open-junk-file neotree move-text mmm-mode meghanada markdown-toc macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode js2-refactor js-doc jinja2-mode intero insert-shebang info+ indent-guide impatient-mode ibuffer-projectile hy-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-mode-manager helm-make helm-hoogle helm-gtags helm-flx helm-descbinds helm-css-scss helm-cscope helm-company helm-c-yasnippet helm-ag haskell-snippets gradle-mode google-translate golden-ratio gnuplot gh-md ggtags fuzzy flyspell-correct-helm flycheck-pos-tip flycheck-haskell flycheck-bashate flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-org evil-numbers evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-cleverparens evil-args evil-anzu eval-sexp-fu ensime emmet-mode elisp-slime-nav editorconfig dumb-jump drupal-mode dockerfile-mode docker disaster define-word dante cython-mode company-web company-tern company-statistics company-shell company-quickhelp company-php company-ghci company-ghc company-emacs-eclim company-cabal company-c-headers company-auctex company-ansible company-anaconda command-log-mode column-enforce-mode color-theme-sanityinc-solarized coffee-mode cmm-mode cmake-mode cmake-ide clean-aindent-mode clang-format auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile ansible-doc ansible aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (php-mode nginx-mode htmlize projectile flycheck magit-popup simple-httpd powerline geben smeargle orgit magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit disaster company-c-headers cmake-mode clang-format git-commit smartparens evil js2-mode company tern with-editor markdown-mode org-plus-contrib hydra helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-hoogle helm-gtags helm-flx helm-descbinds helm-css-scss helm-cscope helm-company helm-c-yasnippet helm-ag flyspell-correct-helm ace-jump-helm-line helm helm-core yapfify yaml-mode ws-butler winum window-purpose which-key web-mode web-beautify volatile-highlights uuidgen use-package toc-org tagedit systemd symon string-inflection stickyfunc-enhance srefactor sql-indent spaceline solarized-theme slim-mode scss-mode sass-mode restart-emacs request ranger rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el password-generator paradox org-projectile org-present org-pomodoro org-download org-bullets org-brain open-junk-file neotree move-text mmm-mode markdown-toc macrostep lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode js2-refactor js-doc jinja2-mode intero insert-shebang info+ indent-guide impatient-mode ibuffer-projectile hy-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ haskell-snippets google-translate golden-ratio gnuplot git-gutter-fringe git-gutter-fringe+ gh-md ggtags fuzzy flyspell-correct-popup flycheck-pos-tip flycheck-haskell flycheck-bashate flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-org evil-numbers evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-cleverparens evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav editorconfig dumb-jump drupal-mode dockerfile-mode docker diff-hl define-word dante cython-mode company-web company-tern company-statistics company-shell company-quickhelp company-php company-ghci company-ghc company-cabal company-ansible company-anaconda column-enforce-mode color-theme-sanityinc-solarized coffee-mode cmm-mode clean-aindent-mode browse-at-remote auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile ansible-doc ansible aggressive-indent adaptive-wrap ace-window ace-link ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
