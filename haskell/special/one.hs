import Data.List

gerakA t
  | even x = rem (4 * t) 100
  | otherwise = 100 - (rem (4 * t) 100)
  where x = div (4 * t) 100

gerakB t
  | even x = 100 - (rem (6 * t) 100)
  | otherwise = rem (6 * t) 100
  where x = div (6* t) 100

ketemuan lim = helper 0 []
  where helper i res
          | (length res) == lim = res
          | (gerakA i) == (gerakB i) = helper (succ i) ([(gerakA i),i] :res)
          | otherwise = helper (succ i) res

sp_poli = [[34,16],[43,13],[23,12],[20,10],[12,9],[234,5],[34,3],[54,2]]

polinom x [] = 0
polinom x ((u:v: []) :ps)
  | null ps = u * (x^v)
  | otherwise = (u * (x^v)) + polinom x ps



zl1a 1 = 1
zl1a n = n + (zl1a $ pred n)

zl1b 1 = 1
zl1b n = div (n * (succ n)) 2

trimolist 1 = [1]
trimolist 2 = [1,1]
trimolist 3 = [1,1,1]
trimolist n = helper 3 [1,1,1]
  where helper i (x:y:z:xs)
          | i == n = (x:y:z:xs)
          | otherwise = helper (succ i) (x+y+z:x:y:z:xs)

fibo i = fibolist 2 [1,1]
  where fibolist n (x:y:_)
          | n == i = x
          | otherwise = fibolist (succ n) (x+y: [x])

zl20 i = gen_fibo 2 [1,1]
  where gen_fibo n (x:y:_)
          | x >= i = (n,x)
          | otherwise = gen_fibo (succ n) (x+y: [x])

fibolist 1 = [1]
fibolist i = reverse $ fibo_help 2 [1,1]
  where fibo_help n (x:y:xs)
          | n == i = (x:y:xs)
          | otherwise = fibo_help (succ n) (x+y:x:y:xs)

fibo_under 1 = []
fibo_under 2 = [1,1]
fibo_under i = reverse $ fibo_help [1,1]
  where fibo_help (x:y:xs)
          | x >= i = (y:xs)
          | otherwise = fibo_help (x+y:x:y:xs)

numcol4 n
  | n < 4 = [n]
  | otherwise = numcol4 (div n 4) ++ [(rem n 4)]

bas4_to_dec n = helper (numcol n) 0
  where helper (x:xs) res
          | null xs = x + (4 * res)
          | otherwise = helper xs (x + (4*res))

dec_to_bas4 n = numcol4 n

permute n k = product [(succ (n-k))..n]

pascal_row (x:xs) res
  | null xs = x:res
  | otherwise = pascal_row xs (x+ (head xs) :res)

pascal row = pascal_row row [1]

nth_pascal n = (iterate pascal [1,1]) !! (pred n)

fst3 (x,_,_) = x
snd3 (_,x,_) = x
trd3 (_,_,x) = x

binom a b n = map (\x -> (fst3 x) * (snd3 x) * (trd3 x)) result
  where result = zip3 (nth_pascal n)
                 (map (a^) [n,(pred n)..0])
                 (map (b^) [0..n])

zl29 = sum $ binom 1 3 10

zl30 = sum [(product [9,19]), (product [9,19,26]), (product [9,10,19]),
            (product [9,10,19,26]), (product [9,10,10,19]), (product [9,10,10,19,26]),
            (product [9,10,10,10, 19]), product ([9,10,10,10,19,26])]

countDigits lim = length $ concatMap numcol [1..lim]

countDigs_helper 0 = 0
countDigs_helper 1 = 9
countDigs_helper n = 9 * n * (10^ (pred n))

countDigs_base n = sum $ map countDigs_helper [1..n]

countDigs lim = countDigs_base (pred n) + remainder n
  where n = length $ numcol lim
        remainder i = ((succ lim) - (10^ (pred i))) * i

product' [] = 1
product' (x:xs) = x * product' xs

