#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot
#show: marginalia.setup.with(
  outer: (far: 5mm, width: 28mm, sep: 8mm),
  top: 2.5cm,
  bottom: 2.5cm,
)
#set page(width: 8.5in, height: 11in, margin: 1.5in)
#set text(font: "Latin Modern Roman", size: 11pt)
#set math.equation(numbering: "(1)")

= Fourier Transform!
== Course: Math 414

---

== Core Idea
We have to get the Fourier transform on a discrete set of samples

== Definition

The discrete Fourier transform is

$ hat(y)_k = sum_(j = 0)^(N - 1) y_j exp((-2pi i k j) / N) $

$ y_j = 1 / N sum_(k = 0)^(N - 1) hat(y)_k e^((i 2 pi k j) / N) $

Notice we start at 0 - we need to assume that our signal starts at $t = 0$

== FFT algorithm

Let's just say that we want $k = N$ frequencies, this means we have to do $N$ summations $N$ times,
which is $N^2$. Can we do better than that?

Let's first split things into even and odd indices

$
  hat(y)_k = sum_(m = 0)^(N / 2 - 1) y_(2m) exp((-2pi i k (2m)) / N) + sum_(m = 0)^(N / 2 - 1) y_(2m + 1) exp((-2pi i k (2 m + 1)) / N)
$

Let's move the 2 in the numerator to the denominator, and rearrange the odd summation (distribute
out the +1)

$
  hat(y)_k = sum_(m = 0)^(N / 2 - 1) y_(2m) exp((-pi i k (2m)) / (N / 2)) +
  underbrace(e^(( -2 pi i k )/N), w_k)
  sum_(m = 0)^(N / 2 - 1) y_(2m + 1) exp((-pi i k (2 m)) / (N / 2))
$

Now, when we want to calculate the first frequencies from $k: [0, N / 2]$,


=== Proof
Let's take just do the even (left) side right now. Let's see what the inside of the summation looks
like for all $k$

$ cos((-2pi k m) / (N / 2)) + i sin ( (- 2pi k m) / (N / 2) ) "for" k: [0, 1 ... N] $

Let's assume that we know the first half of $k$ already right now. Then, if $k > N / 2$, what
happens? Let $r = k - N / 2$ so $r: [1, 2 ... N / 2] #note[$N/2 < k < N$, but k is an integer]$

$ cos((-2pi m (N / 2 + r)) / (N / 2)) + ... $
$ cos((-2pi m (N / 2 )) / (N / 2) + (-2pi m r) / (N / 2)) + ... $
$ cos((-2pi m ) + (-2pi m r) / (N / 2)) + ... $
Since $cos$ is periodic
$ cos((-2pi m r) / (N / 2)) + ... $
So this means that as long as $k > N / 2$, it's the same as the sum of $k - N / 2$, which is in the
first half!

We can compute the second half of our frequencies by reusing the exact calculations from the first
half, we do need a sign flip since we have the extra factor in front of the odds.

$ hat(y)_r = E_r + w_r O_r $
$ hat(y)_(r + n/2) = E_r - w_r O_r $

