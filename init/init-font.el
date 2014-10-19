
(defvar emacs-english-font "Monaco"  "The font name of English.")

(defvar emacs-cjk-font "Hiragino Sans GB W3"
  "The font name for CJK.")

(if (not (find-font (font-spec :name "Monaco")))
    (setq emacs-english-font ""))

(if (not (find-font (font-spec :name "Hiragino Sans GB W3")))
    (setq emacs-cjk-font ""))

(defvar emacs-font-size-pair '(12 . 14)
  "Default font size pair for (english . chinese)")

(defvar emacs-font-size-pair-list
  '(( 5 .  6) (10 . 12)
    (13 . 16) (15 . 18) (17 . 20)
    (19 . 22) (20 . 24) (21 . 26)
    (24 . 28) (26 . 32) (28 . 34)
    (30 . 36) (34 . 40) (36 . 44))
  "This list is used to store matching (englis . chinese) font-size.")

(defun font-exist-p (fontname)
  "Test if this font is exist or not."
  (if (or (not fontname) (string= fontname ""))
      nil
    (if (not (x-list-fonts fontname)) nil t)))

(defun set-font (english chinese size-pair)
  "Setup emacs English and Chinese font on x window-system."

  (if (font-exist-p english)
      (set-frame-font (format "%s:pixelsize=%d" english (car size-pair)) t))

  (if (font-exist-p chinese)
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font) charset
                          (font-spec :family chinese :size (cdr size-pair))))))

(set-font emacs-english-font emacs-cjk-font emacs-font-size-pair)

(provide 'init-font)