;; define a global variable called db
(defvar *db* nil)

(defun add-record (cd) (push cd *db*))

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

;; dolist iterates over a list and binds each value
;; to the cd variable
(defun dump-db ()
  (dolist (cd *db*)
    ;; ~{   --> the next argument must be a list
    ;; ~a   --> next argument must be human-readable (remove quotes and colons)
    ;; ~10t --> ~t is for tabulation -> ~10t --> 10 spaces
    ;; ~%   --> a new line
    (format t "~{~a:~10t~a~%~}~%" cd)))

;; does the same as the function above
(defun oneliner-dump-db ()
  (format t "~{~{~a:~10t~a~%~}~%~}"))

(defun prompt-read (prompt)
  ;; *query-io* global that contains the input stream connected to the terminal
  (format *query-io* "~a: " prompt)
  ;; sometimes force-output is needed to ensure
  ;; that lisp does not wait for a new line before printing
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   ;; try to read a string digit, covert it to int or assigne a 0
   (or (parse-integer(prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped? [y/n]: ")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
        (if (not (y-or-n-p "Another? [y/n]: ")) (return))))

