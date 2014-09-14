(ns euler.prob11-20)

(load-file "math.clj")

;; PROBLEM NO 12

(defn triangle
  [n]
  (quot (* (inc n) n) 2))

(defn tri-factors
  [n]
  (count (factors (triangle n))))

(defn euler12
  [n]
  (loop [i 1]
    (if (>= (tri-factors i) n)
      i
      (recur (inc i)))))


;; PROBLEM 14

(defn collatz
  [n]
  (if (even? n) (quot n 2) (inc (* 3 n))))

(defn collatz-seq
  [n]
  (loop [i n res []]
    (if (= 1 i)
      (conj res i)
      (recur (collatz i) (conj res i)))))

(def mem-collatz-seq
  (memoize (fn [n]
             (if (= 1 n)
               [1]
               (conj (mem-collatz-seq (collatz n)) n)))))

(defn count-collatz
  [n]
  (loop [i n res 0]
    (if (= i 1)
      (inc res)
      (recur (collatz i) (inc res)))))

(defn solution
  [i n]
  (loop [idx i res i maxi 0]
    (if (= idx n)
      (let [temp (count-collatz idx)]
        (if (> maxi temp)
          [res maxi]
          [idx temp]))
      (let [temp (count-collatz idx)]
        (if (> maxi temp)
          (recur (inc idx) res maxi)
          (recur (inc idx) idx temp))))))

(defn euler14
  [n]
  (time (solution 1 n)))

"Elapsed time 5.3 seconds!"
