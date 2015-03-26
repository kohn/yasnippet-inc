(defun yas-insert-include-check-and-insert (inc prefix endline start-marker)
  (save-excursion
  (goto-char (point-min))
  (let ((flag nil) (one-line (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
    (block find-start-line
      (while (and
              (not (string-prefix-p prefix one-line))
              (< (line-number-at-pos (point)) endline))
          (if (= (forward-line 1) 1)
              (return-from find-start-line)
            (setq one-line (buffer-substring-no-properties (line-beginning-position) (line-end-position))))))
    (block check
      (while (string-prefix-p prefix one-line )
        (if (string= one-line inc)
            (progn (setq flag t) (return-from check))
          (if (= (forward-line 1) 1)
              (return)
            (setq one-line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))))))
    (if (equal flag nil)
        (progn
          (if (equal (point) (marker-position start))
              (progn (set-marker start (+ (marker-position start) 1))
                     (insert inc)
                     (insert "\n")
                     (set-marker start (- (marker-position start) 1)))
            (progn
              (insert inc)
              (insert "\n"))))))))
(defun yas-insert-include ()
  (if (or (equal start nil) (equal end nil))
      (print "yas-new-snippet")
      (let ((dist (- end start)) (new-content "") inc content-in-lines delimiter
            (snippet-line-number (line-number-at-pos (point))))
        (goto-char start)
        (setq start (point-marker))
        (setq content-in-lines (split-string content "\n"))
        (loop for content-one-line in content-in-lines do
              (if (string-prefix-p "@@" content-one-line)
                  (progn
                    (setq delimiter (nth 1 (split-string content-one-line "@@")))
                    (setq inc (nth 2 (split-string content-one-line "@@")))
                    (yas-insert-include-check-and-insert inc delimiter snippet-line-number start))
                (progn (setq new-content (concat new-content content-one-line "\n")))))
        (setq end (+ start dist))
        (setq content (substring new-content 0 -1)))))
(add-hook 'yas/before-expand-snippet-hook 'yas-insert-include)
