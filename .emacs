;; Great inspiration taken from:
;; https://github.com/howardabrams/dot-files/blob/master/emacs.org

(setq gc-cons-threshold 50000000)

(setq initial-scratch-message "") ;; Uh, I know what Scratch is for

(when (window-system)
  (tool-bar-mode 0)               ;; Toolbars were only cool with XEmacs
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))
  (scroll-bar-mode -1))            ;; Scrollbars are waste screen estate

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Half-fix for Mac OSX Option key not being the meta key
(set-keyboard-coding-system nil)

;; Change text size
(set-face-attribute 'default nil :height 120)

;; 4 spaces per tab
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq c-basic-offset 4)

;; Move backup files to a temporary directory on disk
;; (rather than in the same location as the saved file)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Skip startup screen.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("e9df267a1c808451735f2958730a30892d9a2ad6879fb2ae0b939a29ebf31b63" default)))
 '(inhibit-startup-screen t))

;; Brighten up that god awful dark blue
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((t (:foreground "color-33"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :foreground "#3bb4ff")))))

;; Brighten up that god awful dark blue in the minibuffer
(set-face-foreground 'minibuffer-prompt "white")

;; Highlight extra whitespace and (optionally) characters exceeding 80 columns
;; (require 'whitespace)
;; (setq whitespace-line-column 79)
;; (setq whitespace-style '(face empty tabs lines-tail trailing))
;; (global-whitespace-mode t)

;; show column number too
(setq column-number-mode t)

;; Format the entire file
(defun indent-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(fset 'yes-or-no-p 'y-or-n-p)  ;; Ask for y/n instead of yes/no

(defun compile-on-save-start ()
  (let ((buffer (compilation-find-buffer)))
    (unless (get-buffer-process buffer)
      (recompile))))

(define-minor-mode compile-on-save-mode
  "Minor mode to automatically call `recompile' whenever the
current buffer is saved. When there is ongoing compilation,
nothing happens."
  :lighter " CoS"
  (if compile-on-save-mode
      (progn  (make-local-variable 'after-save-hook)
              (add-hook 'after-save-hook 'compile-on-save-start nil t))
    (kill-local-variable 'after-save-hook)))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(setq ;; foreground and background
 monokai-foreground     "#ABB2BF"
 monokai-background     "#222222"
 ;; highlights and comments
 monokai-comments       "#F8F8F0"
 monokai-emphasis       "#282C34"
 monokai-highlight      "#FFB269"
 monokai-highlight-alt  "#66D9EF"
 monokai-highlight-line "#1B1D1E"
 monokai-line-number    "#F8F8F0"
 ;; colours
 monokai-blue           "#61AFEF"
 monokai-cyan           "#56B6C2"
 monokai-green          "#98C379"
 monokai-gray           "#3E4451"
 monokai-violet         "#C678DD"
 monokai-red            "#E06C75"
 monokai-orange         "#D19A66"
 monokai-yellow         "#fac561")

(load-theme 'monokai t)
