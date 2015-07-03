module One

open System
open System.IO
open System.Diagnostics
open System.Collections.Generic

let square x = x * x;;

let cube x = x*x*x;;

let sol1 (lim : int64) =
  List.sum [for i in [1L..lim] do if (0L = i % 3L) || (0L = i % 5L) then yield i]

let odd_prime (x : int64) =
  let rec loopi i =
    match i with
      | _ when (i*i) > x -> true
      | _ when 0L = x % i -> false
      | _ -> loopi (i + 2L)
  loopi 3L;;

let prime (x:int64) =
  match x with
    | _ when x < 2L -> false
    | 2L|3L|5L|7L -> true
    | _ when 0L = x % 2L -> false
    | _ -> odd_prime x ;;

let sol3 (n : int64) =
  let rec loopi (p : int64) (i : int64) =
      match p with
        | 0L -> i-2L
        | 1L -> i-2L
        | _ when odd_prime i
            -> if 0L = p % i then loopi (p/i) (i+2L)
               else loopi p (i+2L)
        | _ -> loopi p (i+2L)
  loopi n 3L;;

let numcol (i : int) =
  let rec loop n xs =
    match n with
      | _ when n < 10 -> n::xs
      | _ -> loop (n/10) (n % 10 :: xs)
  loop i [];;

let ispalin (n : int) =
  let xs = numcol n
  xs = List.rev xs;;

// 6ms
let sol4 maxi =
  let tabs = new Dictionary<string,int> ()
  let rec loopi a b =
    let mul = a*b
    let muls = (string a) + (string b)
    match a with
      | _ when a = b -> loopi a (b-1)
      | _ when mul < maxi -> 0
      | _ -> if tabs.ContainsKey(muls) then tabs.[muls]
             else let resi = loopi a (b-1)
                  let resj = loopi (a-1) b
                  match mul with
                    | _ when ispalin mul -> let ans = List.max [resi;resj;mul]
                                            (tabs.Add(muls, ans); ans)
                    | _ -> let ans = List.max [resi;resj]
                           (tabs.Add(muls,ans);ans)
  loopi 999 999;;

// 1-2ms
let sol4b (a:int) (b:int) =
  let rec outer i res =
    let rec inner j =
      let mul = i*j
      match mul with
        | _ when j < (i-a) -> 0
        | _ when mul < res -> 0
        | _ when ispalin mul -> mul
        | _ -> inner (j-1)
    let initmul = i*(i-1)
    match initmul with
      | _ when initmul < res -> res
      | _ when i < b -> res
      | _ -> let resj = inner (i-1)
             if resj > res then outer (i-1) resj else outer (i-1) res
  outer 999 0;;

// 13ms
let sol4c (lower : int) =
  List.max [for i in lower..998 ->
              List.max [for j in (i+1)..999 ->
                let mul = i*j
                if ispalin mul then mul else 0]];;

// less than 1ms
let sol5 lst =
  let rec outer xs res =
    match xs with
      | [] -> List.fold (fun a b -> a * b) 1 res
      | hd::tl -> let rec inner xres resi =
                    match xres with
                      | [] -> resi::res
                      | hdx::tlx -> if 0 = resi % hdx then inner tlx (resi/hdx)
                                    else inner tlx resi
                  outer tl (inner res hd)
  outer lst [1];;

let lcm (lst : int64 list) =
  let rec outer (xs : int64 list) (res : int64 list) =
    match xs with
      | [] -> List.fold (fun a b -> a * b) 1L res
      | hd::tl -> let rec inner xres resi =
                    match xres with
                      | [] -> resi::res
                      | hdx::tlx -> if 0L = resi % hdx then inner tlx (resi/hdx)
                                    else inner tlx resi
                  outer tl (inner res hd)
  outer lst [1L];;

// less than 1 ms
let sol6 lim =
  let bahan = [1..lim]
  let squares = List.sumBy square bahan
  let sums = List.sum bahan
  let sumsquares = sums*sums
  sumsquares - squares;;

let sum_primes (lim) =
  let rec loopi i res =
      if i >= lim then res
      elif odd_prime i then loopi (i+2L) (res + (int64 i))
      else loopi (i+2L) res
  loopi 3L 2L;;

// less than 1ms
let sol7 (tar : int) (mul : int) =
  let lim = tar * mul
  let primes = Array.zeroCreate<bool> (lim+5)
  Array.fill primes 0 lim true
  let rec outer (i:int) (idx : int) =
    match primes.[i] with
      | true -> if idx = (tar-1) then i
                elif i <= lim / i then
                  let rec inner (j : int) =
                    if j > lim then ()
                    else (Array.set primes j false; inner(j+2*i))
                  (inner (i*i) ; outer (i+2) (idx+1))
                else outer (i+2) (idx+1)
      | _ -> outer (i+2) idx
  outer 3 1;;

let prod xs = List.reduce (*) xs;;

// this runs in 5ms
let sol8 nmax =
  let raw = Array.fold (+) "" <| File.ReadAllLines "p8.txt"
  let sumxs a b = prod [for i in raw.[a..b] -> int64 (string i)]
  let rec iter i (maxi : int64) =
    match i with
      | _ when i = nmax-15 -> maxi
      | _ -> let this_max = sumxs i (i+12)
             iter (i+1) (if this_max > maxi then this_max else maxi)
  iter 0 0L;;

let sum_sieve (lim:int) =
  let primes = Array.zeroCreate<bool> (lim+5)
  Array.fill primes 3 lim true
  let rec outer (i:int) (res : int64) =
    let rec inner (j:int) =
      if j > lim then ()
      else (Array.set primes j false; inner (j+2*i))
    if i > lim then res
    elif primes.[i] then
      if i <= lim / i then (inner (i*i); outer (i+2) (res + (int64 i)))
      else outer (i+2) (res + (int64 i))
    else outer (i+2) res
  outer 3 2L;;

// runs in 1ms-an
let fibo (tar:bigint) =
  let rec loopi a b (i:int) =
    if a > tar then i else loopi (a+b) a (i+1)
  loopi 1I 0I 1;;

// runs in about 9-11ms
let sol10 (lim:int) =
  let primes = Array.zeroCreate (lim + 5)
  Array.fill primes 0 (lim+1) true
  let rec outer (i : int) (res : int64) =
    let rec inner (j : int) =
      match j with
        | _ when j > lim -> 0L
        | _ -> (Array.set primes j false; inner (j + 2*i))
    match primes.[i] with
      | true -> if i <= lim / i then outer (i+2) (res + (int64 i) + (inner (i*i)))
                else outer (i+2) (res + (int64 i))
      | false -> if i > lim then res else outer (i+2) res
  outer 3 2L;;

// This one simply produces positive primes less than lim
let sieve (lim:int) =
  let primes = Array.zeroCreate<bool> (lim+5)
  Array.fill primes 3 lim true
  let rec outer (i:int) (res : int64) =
    let rec inner (j:int) =
      match j with
        | _ when j > lim -> ()
        | _ -> (Array.set primes j false; inner (j + 2*i))
    match primes.[i] with
      | true -> if i <= lim / i then (inner (i*i) ; outer (i+2) (res + (int64 i)))
                else outer (i+2) (res + (int64 i))
      | false -> if i > lim then List.filter (fun x -> primes.[x]) [3..2..lim]
                 else outer (i+2) res
  2::outer 3 2L;;

let timed funi data =
    let timer = new Stopwatch()
    timer.Start()
    let result = funi data
    timer.Stop()
    printf "elapsed %d ms \n" timer.ElapsedMilliseconds
    result

  