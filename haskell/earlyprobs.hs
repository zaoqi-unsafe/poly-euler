-- PROBLEM NO 1

import Data.List

euler1 :: Int -> Int -> Int -> Int
euler1 a b lim = sum [x | x <- [1..lim],
                      (0 == (rem x a)) || (0 == (rem x b))]

-- *Main> euler1 3 5 999
-- it :: Integer a => a
-- (0.01 secs, 2614216 bytes)

-- PROBLEM NO 2

euler2 :: [Int] -> Int -> Int -> Int
euler2 (a:b:xs) lim res
  | a >= lim = res
  | otherwise = euler2 ((a+b):a: []) lim (if (even a) then (a + res) else res)
                
-- PROBLEM NO 3

primeHelper :: Integer -> Integer -> Integer -> Bool
primeHelper p i lim
  | i >= lim = True
  | 0 == (rem p i) = False
  | otherwise = primeHelper p (i + 2) lim

prime :: Integer -> Bool
prime p
  | p <= 20 = elem p [2,3,5,7,11,13,17,19]
  | even p = False
  | otherwise = primeHelper p 3 (ceiling (sqrt (fromInteger p)))

factorsHelper n i lim res
  | i >= lim = res
  | 0 == (rem n i) = factorsHelper n (succ i) lim (i:(quot n i):res)
  | otherwise = factorsHelper n (succ i) lim res

factors n = factorsHelper n 2 (ceiling (sqrt (fromInteger n))) []

euler3 n = maximum $ filter prime (factors n)

-- elapsed time 1.43 seconds

isPalin p = (show p) == (reverse $ show p)

euler4 i j = maximum [x*y | x <- [i..j], y <- [x..j], isPalin (x*y)]

-- elapsed time 30msecs

-- This is the most naive implementation, really slow
euler5 n = head [x | x <- [(product [2,3,5,7,11,13,17,19])..],
                 (all (\i -> 0 == (rem x i)) [1..n])]

rudeLCM (a:xs) res
  | null xs = a:res
  | any (\x -> 0 == (rem x a)) xs = rudeLCM newXs newRes
  | otherwise = rudeLCM xs (a:res)
  where newXs = map (\x -> (if (0 == (rem x a)) then (quot x a) else x)) xs
        newRes = if (prime a) then a:res else res

euler5a n = product $ rudeLCM [1..n] []
                
-- Problem no 6

euler6 n = sum (map sqr [1..n]) - sqr (sum [1..n]) where sqr x = x * x

-- Problem no 7

euler7 n = [x | x <- [2..], prime x]!! (pred n)

-- very slow 2.4secs

nextPrime x
  | x == 2 = 3
  | even x = if prime $ succ x then succ x else nextPrime $ succ x
  | otherwise = if prime $ 2 + x then 2 + x else nextPrime $ 2 + x

euler7a n = (iterate nextPrime 2)!! (pred n)

-- also slow 2.4 seconds

euler7Helper n i x = if n == i then x else euler7Helper n (succ i) (nextPrime x)

euler7b n = euler7Helper n 1 2

-- also slow 2.3secs

euler8data = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"

prod ls = product (map (\x -> read [x] :: Int) ls)

euler8Helper ls mx
  | 13 == length ls = if mx > (prod ls) then mx else (prod ls)
  | otherwise = euler8Helper (tail ls) (maximum [lst, mx])
  where lst = prod (take 13 ls)

euler8 ls = euler8Helper ls (prod (take 13 ls))










