(load "math.lisp")

(defun psqr-helper (n i)
  (cond ((> (* i i) n)
	 false)
	((= (* i i) n)
	 true)
	(:else (psqr-helper n (+ 1 i)))))

(defun psqr? (n)
  (psqr-helper n 1))

(defun psquare? (n)
  (= (floor (sqrt n)) (ceiling (sqrt n))))

(defun qd-helper (d y)
  (let ((xsqr (+ 1 (* d y y))))
    (if (psqr? xsqr)
	(list (sqrt xsqr) y)
	(qd-helper d (+ 1 y)))))

(defun quad-diop (d)
  (cons d (qd-helper d 1)))

(defun diops (i j)
  (remove-if 'psquare? (range i j)))

(defun sol66a (n d maxi)
  (cond ((psqr? d)
	 (sol66a n (+ 1 d) maxi))
	((> d n)
	 maxi)
	(:else (let ((tmp (quad-diop d)))
		 (if (> (second tmp) (second maxi))
		     (sol66a n (+ 1 d) tmp)
		     (sol66a n (+ 1 d) maxi))))))

(defun euler66 (n)
  (time (sol66a n 1 '(0 0 0))))

(defun solved? (d y)
  (list (sqrt (+ 1 (* d y y)))
	(1+ (* d y y)) d y))

;; PROBLEM 108 FOR 110

(defun palin? (n)
  (let ((tmp (numcol n)))
    (equal tmp (reverse tmp))))
