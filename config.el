;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Petro van Tonder"
      user-mail-address "petro@cognician.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! cider
  (setq
   cider-repl-pop-to-buffer-on-connect nil
   cider-show-error-buffer nil
   cider-font-lock-reader-conditionals nil
   cider-repl-use-clojure-font-lock t
   cider-font-lock-dynamically t
   cider-save-file-on-load nil
   nrepl-log-messages nil
   cider-show-error-buffer t
   cider-redirect-server-output-to-repl t)
  (require 'flycheck-clj-kondo))

(after! lsp-mode
  (setq lsp-semantic-tokens-enable nil
        lsp-idle-delay 0.1
        lsp-headerline-breadcrumb-enable nil
        lsp-ui-sideline-enable t))

;; windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'super))

;; Projectile
(after! projectile
  ;; ignored files
  (setq projectile-globally-ignored-files
        (cl-union projectile-globally-ignored-files
                  '(".DS_Store"
                    ".lein-repl-history"
                    "*.gz"
                    "*.pyc"
                    "*.png"
                    "*.jpg"
                    "*.jar"
                    "*.retry"
                    "*.svg"
                    "*.tar.gz"
                    "*.tgz"
                    "*.zip")))
  ;; ignored directories
  (setq projectile-globally-ignored-directories
        (cl-union projectile-globally-ignored-directories
                  '(".git"
                    ".ignore"
                    ".cljs_rhino_repl"
                    ".svn"
                    "out"
                    "node_modules"
                    "resources/public/js/compiled"
                    ".shadow-cljs/"))))

;; clojure-mode
;; lsp
;; cider
;; flycheck + flycheck-clj-kondo

;; Clojure

(after! clojure-mode
  (setq clojure-align-forms-automatically t)
  (paredit-mode))

(after! counsel
  (setq counsel-rg-base-command "rg -M 50 -C 2 --with-filename --no-heading --line-number %s || true"))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)
(define-key projectile-mode-map [?\s-G] 'projectile-replace-regexp)
(define-key projectile-mode-map [?\s-T] 'projectile-toggle-between-implementation-and-test)

(global-set-key (kbd "<M-s-right>") 'buf-move-right)
(global-set-key (kbd "<M-s-left>") 'buf-move-left)
(global-set-key (kbd "<M-s-up>") 'buf-move-up)
(global-set-key (kbd "<M-s-down>") 'buf-move-down)

;; Move active cursor to window
(global-set-key [C-s-left] 'windmove-left)
(global-set-key [C-s-right] 'windmove-right)
(global-set-key [C-s-up] 'windmove-up)
(global-set-key [C-s-down] 'windmove-down)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.
(global-set-key [f6] 'highlight-regexp)
(global-set-key [M-f6] 'unhighlight-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "s-M-g") 'rgrep)
(global-set-key (kbd "C-r") 'lsp-find-references) ;;xref->find all places in project where this is being used

(global-set-key [f8] 'cider-connect)
(global-set-key [M-f8] 'cider-quit)

(global-set-key [C-M-f8]
                (lambda () (interactive)
                  (cider-connect '(:host "localhost" :port 7888))))

(global-set-key [C-S-f9]
                (lambda () (interactive)
                  ;(setq cider-shadow-default-options "tools")
                  (cider-connect-clj&cljs
                   (plist-put '(:host "localhost" :cljs-repl-type shadow)
                              :port (cl-second (cl-first (cider-locate-running-nrepl-ports)))))))

(global-set-key [C-S-f8]
                (lambda () (interactive)
                  (cider-connect
                   (plist-put '(:host "localhost")
                              :port (cl-second (cl-first (cider-locate-running-nrepl-ports)))))))

(global-set-key [M-f1] 'cider-repl-clear-buffer)

(global-set-key (kbd "s-T") 'cider-test-run-test)

(global-set-key [M-S-f3] 'cider-format-edn-region)

;; remove outside form
(global-set-key (kbd "M-<up>") 'sp-splice-sexp-killing-backward)

;; hide show toggle
(global-set-key (kbd "C-.") 'hs-toggle-hiding)
(global-set-key (kbd "C-,") 'hs-hide-all)
(global-set-key (kbd "C-x C-,") 'hs-show-all)

;; add missing require
(global-set-key (kbd "s-r a m") 'cljr-add-missing-libspec)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))
(setq doom-theme 'tango-dark)
(setq global-hl-line-modes nil)

(super-save-mode +1)
(+global-word-wrap-mode +1)

(defun restart-cognician-system ()
  (interactive)
  (save-buffer)
  (let ((filename
         (buffer-file-name)))
    (when filename
      (cider-interactive-eval
       (when-some [restart-fn (try
                               (require 'repl.local)
                               (find-var 'repl.local/restart-local-systems!)
                               (catch Throwable e
                                      (require 'cognician.system)
                                      (find-var 'cognician.system/restart-systems!)))]
                  (restart-fn)
                  :cognician/system-restarted)))))

(global-set-key (kbd "<M-return>") 'restart-cognician-system)
