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

;; Format the entire file
(defun indent-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(fset 'yes-or-no-p 'y-or-n-p)  ;; Ask for y/n instead of yes/no