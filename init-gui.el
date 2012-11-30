;; show help in the echo area instead of as a tooltip
(tooltip-mode -1)

;; blink the cursor
(setq blink-cursor-interval 1.0)
(blink-cursor-mode)

;; indicate EOF empty lines in the gutter
(setq indicate-empty-lines t)

;; enable hl-line-mode for prog-mode
(add-hook 'prog-mode-hook 'bw-enable-hl-line-mode)
