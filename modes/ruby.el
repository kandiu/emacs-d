;;; -*- lexical-binding: t -*-

;; Ruby mode

;; this variable is stupid - apparently Ruby needs its own indent
;; variable
;; 2-space indent is idiomatic
(use-package ruby-mode
  :mode (("\\.rb\\'" . ruby-mode)
         ("[vV]agrantfile$" . ruby-mode)
         ("[gG]emfile$" . ruby-mode)
         ("[rR]akefile$" . ruby-mode)
         ("\\.rake$" . ruby-mode))
  :config
  (progn
    ;; Rails project setup
    (defun eproject-rails-config ()
      "Various settings for Rails projects"

      ;; We don't want to compile SCSS in Rails because the asset pipeline
      ;; does it for us
      (set (make-local-variable 'scss-compile-at-save) nil))

    (add-hook 'ruby-on-rails-project-file-visit-hook 'eproject-rails-config)

    ;; TODO: can we factor this out into a macro?
    (defun find-rails-type (predicate title)
      "Finds a file filtered by predicate"
      (when (eq (eproject-type) 'ruby-on-rails)
        (find-file
         (concat
          (eproject-root)
          (ido-completing-read
           title
           (mapcar
            (lambda (e)
              (replace-regexp-in-string (eproject-root) "" e))
            (remove-if-not predicate (eproject-list-project-files))))))))

    (defun find-controllers-rails ()
      "Finds controller files in an eproject-rails project"
      (interactive)
      (find-rails-type 'is-controller "Controller: "))

    (defun find-models-rails ()
      "Finds model files in an eproject-rails project"
      (interactive)
      (find-rails-type 'is-model "Model: "))

    (defun find-views-rails ()
      "Finds view files in an eproject-rails project"
      (interactive)
      (find-rails-type 'is-view "View: "))

    (defun is-controller (name)
      "Filters a string"
      (interactive "sController: ")
      (not (equal (string-match "app/controller*" name) nil)))

    (defun is-model (name)
      (interactive "sModel: ")
      (not (equal (string-match "app/models*" name) nil)))

    (defun is-view (name)
      (interactive "sView: ")
      (not (equal (string-match "app/views*" name) nil)))

    (setq ruby-indent-level 2)))

(add-to-list 'auto-mode-alist '("\\.css\\.erb$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\.erb$" . scss-mode))
