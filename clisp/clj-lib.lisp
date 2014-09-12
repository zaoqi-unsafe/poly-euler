;; This is an attempt to make some of clojure functions runs on SBCL

(defconstant true t)
(defconstant false nil)

(defun zero? (x) (zerop x))

(defun nil? (x) (null x))

(defun empty? (x) (null x))

(defun quot (a m)
  (floor (/ a m)))

(defun filter (f ls)
  (remove-if-not f ls))

(defun sum (ls)
  "Returns the sum of all elements in ls"
  (apply '+ ls))

(defun product (ls)
  "Returns the product of all elements in ls"
  (apply '* ls))

(defun div? (a m)
  "Returns true if a is evenly-divisible by m"
  (zerop (rem a m)))

(defun square (x)
  (* x x))

(defun range (&rest args)
  "Clojure range behaviour"
  (cond ((= 1 (length args))
	 (let* ((i (first args)))
	   (loop for x from 0 to (1- i) collect x)))
	((= 2 (length args))
	 (let* ((i (first args)) (j (second args)))
	   (loop for x from i to (1- j) collect x)))
	((= 3 (length args))
	 (let* ((i (first args)) (j (second args)) (k (third args)))
	   (if (>= i j)
	       (loop for x from 0 to (1- (abs (quot (- i j) k)))
		  collect (+ i (* x k)))
	       (loop for x from 0 to (quot (- j i) k)
		  collect (+ i (* x k))))))))

(defun prime-helper (p i lim)
  (cond ((>= i lim) t)
	((zerop (rem p i)) nil)
	(t (prime-helper p (+ 2 i) lim))))

(defun prime? (p)
  (cond ((<= p 20) (if (member p '(2 3 5 7 11 13 17 19)) t nil))
	((evenp p) nil)
	(t (prime-helper p 3 (sqrt p)))))

(defun factors-helper (n i res lim)
  (cond ((> i lim)
	 res)
	((zerop (rem n i))
	 (factors-helper n (1+ i) (cons i (cons (/ n i) res)) lim))
	(t
	 (factors-helper n (1+ i) res lim))))

(defun factors (n)
  (factors-helper n 2 '() (1+ (sqrt n))))

(defun lcm-list (ls res) 
  (let ((a (first ls))
	(xs (rest ls)))
    (if (null xs)
	(cons a res)
	(if (some #'(lambda (x) (zerop (rem x a))) xs)
	    (lcm-list (mapcar #'(lambda (x) (if (zerop (rem x a))
					   (/ x a)
					   x))
			      xs)
		      (if (prime? a) (cons a res) res))
	    (lcm-list xs (cons a res))))))


