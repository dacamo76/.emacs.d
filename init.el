(setq my-elisp-dir (expand-file-name "elisp" user-emacs-directory))

(dolist (project (directory-files my-elisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(setq custom-file (expand-file-name "emacs-customizations.el"
				    user-emacs-directory))
(load custom-file)


;; display line and column numbers in the bottom bar
;(line-number-mode 1)
;(column-number-mode 1)

;; highlight trailing spaces/tabs as also empty lines at start/end
;; of document and lines longer than whitespace-line-num (80 by default)
(setq-default whitespace-style '(face lines empty trailing))
(global-whitespace-mode 1)

;; repos
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
             ;;;'("Marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; Only check if no package archives exist. (i.e a new machine)
(unless package-archive-contents
  (package-refresh-contents))

;; my packages
(defvar my-packages '(smartparens
                      clojure-mode
                      cider
                      magit
                      yaml-mode
                      scss-mode
                      rhtml-mode
                      rinari
                      exec-path-from-shell
                      rainbow-delimiters
                      zenburn-theme
                      solarized-theme)
  "A list of my-packages to ensure are installed at launch.")


(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(require 'better-defaults)
(require 'smartparens-config)
(smartparens-global-mode t)
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(load-theme 'zenburn)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(global-rinari-mode t)
