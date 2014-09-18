(ns poly-euler.prob25)

;; NOTE, for this solution, it will cause stack-overflow since it uses
;; pure recursion without clojure's loop which is tail-recursion

(defn expt
  [a m]
  (if (zero? m) 1 (*' a (expt a (dec m)))))

(defn euler25
  [lim [a b] i]
  (if (>= a lim)
    i
    (euler25 lim [(+' a b) a] (inc i))))

;; poly-euler.prob25> (time (euler25 (expt 10 999) [1 1] 2))
;; "Elapsed time: 6.218 msecs"
"This one is actually faster 1.8msecs"

;; This is the TCO version

(defn euler25a
  [lim]
  (loop [[a b] [1 1] i 2]
    (if (>= a lim)
      i
      (recur [(+' a b) a]
             (inc i)))))

;; poly-euler.prob25> (time (euler25a (expt 10 999)))
;; "Elapsed time: 2.491 msecs"


