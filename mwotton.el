;; colors
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)



(add-to-list 'exec-path "/Users/mwotton/.cabal/bin/")
(add-to-list 'exec-path "/usr/local/bin/")

;; ido stuff
(defun ido-execute ()
 (interactive)
 (call-interactively
  (intern
   (ido-completing-read
    "M-x "
    (let (cmd-list)
      (mapatoms (lambda (S) (when (commandp S) (setq cmd-list (cons (format "%S" S) cmd-list)))))
      cmd-list)))))

;; map both option and command to meta
(setq mac-option-key-is-meta t)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)
(setq mac-shift-key-is-meta nil)

(global-set-key "\M-x" 'ido-execute)

;; (font-lock-add-keywords
;;  'c++-mode
;;  '(("\\<\\(FIXME\\)" 1 font-lock-warning-face t)))
;; (modify-face (quote font-lock-warning-face) "Red" "yellow" nil t nil t nil nil)


(setq ido-enable-flex-matching t)
(setq debug-on-quit nil)

;; HASKELL
(require 'haskell-mode)

(setq font-lock-maximum-decoration t)
;; (global-font-lock-mode 1 t)
(add-to-list 'completion-ignored-extensions ".hi")
(add-to-list 'completion-ignored-extensions ".o")
(load "/Users/mwotton/.emacs.d/elpa-to-submit/haskell-site-file")
(add-to-list 'load-path "/Users/mwotton/.emacs.d/elpa-to-submit/ghc-mod/")
;; (require 'ghc)
;;(autoload 'ghc-init "ghc" nil t)
;;(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


(defun credmp/flymake-display-err-minibuf () 
      "Displays the error/warning for the current line in the minibuffer"
      (interactive)
      (let* ((line-no             (flymake-current-line-no))
             (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
             (count               (length line-err-info-list))
             )
        (while (> count 0)
           (when line-err-info-list
           (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                   (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                   (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                   (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
              (message "[%s] %s" line text)
              )
            )
          (setq count (1- count)))))

(global-set-key "\C-cd"
 'credmp/flymake-display-err-minibuf)



;;; random hacks

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
;; (global-set-key [(shift up)] 'set-mark-command)

(require 'compile)
 
;; this means hitting the compile button always saves the buffer
;; having to separately hit C-x C-s is a waste of time
(setq mode-compile-always-save-buffer-p t)
;; make the compile window stick at 12 lines tall
(setq compilation-window-height 40)`

(project-show-current-name)
;; from enberg on #emacs
;; if the compilation has a zero exit code, 
;; the windows disappears after two seconds
;; otherwise it stays
(setq compilation-finish-function
      (lambda (buf str)
        (unless (string-match "exited abnormally" str)
          ;;no errors, make the compilation window go away in a few seconds
          (run-at-time
           "2 sec" nil 'delete-windows-on
           (get-buffer-create "*compilation*"))
          (message "No Compilation Errors!"))))
 
 
;; one-button testing, tada!
(global-set-key [f7] 'compile)

(set-default-font "-apple-Anonymous_Pro-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")
(server-start)
(require 'inf-ruby)
(require 'php-mode)

(require 'levenshtein)


(add-to-list 'auto-mode-alist '("\.gsp$" . nxml-mode)) ; Use whatever mode you want for views.

;; (add-to-list 'load-path "~/.emacs.d/elisp/feature-mode")
;; ;; optional configurations
;; ;; default language if .feature doesn't have "# language: fi"
(setq feature-default-language "fi")
;; ;; point to cucumber languages.yml or gherkin i18n.yml to use
;; ;; exactly the same localization your cucumber uses
;; ;(setq feature-default-i18n-file "/path/to/gherkin/gem/i18n.yml")
;; ;; and load feature-mode
;(require 'feature-mode)
;(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
;(setq feature-default-language "en")

