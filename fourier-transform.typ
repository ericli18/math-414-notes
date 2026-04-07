#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock
#import "@preview/physica:0.9.8" as physica: evaluated
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
A Fourier transform can be thought of as a continuous form of a Fourier series. The Fourier series
of a function decomposes it on an interval of $[-pi, pi]$ of $sin$ and $cos$.

The Fourier transform decomposes a signal defined on an infinite time interval into
$lambda$-frequency components where $lambda in CC$. Each frequency component is basically a periodic
function with a different period.

Basically, it's the Fourier series on roids and you can use it on an infinite timeline instead of
$2pi$-periodic.

For practical purposes, you want to break the signal up into parts, do something with those parts,
and then reassemble them.

== Definition
If $f$ is a continuously differentiable function with
$integral_(-infinity)^(infinity) |f(t)| dif t < infinity$, then we can find f(x) with the following:

*Synthesis or Inverse F.T.*
Reassemble a function/signal from it's constituent parts
$
  f(x) = 1/(sqrt(2 pi)) integral_(-infinity)^(infinity) hat(f)(lambda) e^(i lambda x) dif lambda
$

*Analysis or F.T.*
Taking a function/signal and breaking it down into simpler constituent parts. Where the fourier
transform $hat(f)(lambda)$
$
  hat(f)(lambda) = 1/(sqrt(2 pi)) integral_(-infinity)^(infinity) f(t) e^(- i lambda t) dif t
$

Image processing always breaks into these 2 steps, we want to write things in some sort of
frequency, amplitude phase

We can also notate the F.T. as $cal(F)[f(t)](lambda)$ and the inverse as
$cal(F)^(-1)[f(lambda)](t)$. For this notation, we can think of it as $cal(F)$ takes in a function
$f(t)$, and makes it dependent on your value of $lambda$. Think of it kind of like a curried
function/hirder order function in Haskell.

*Plancherals Theorem*
Basically the same as Parseval's
$ <cal(F)[f], cal(F)[g]> = <f, g> $


== Proof idea
Let's take the $2l$ periodic, complex form of the Fourier series and take it $l -> infinity$

$
  alpha_n = 1/(2l) integral_(-l)^(l) f(t) e^(-(i n pi t) / l) dif t
$

When we subtitute this into the complex Fourier series equation, we get the following:

$
  f(x) &= lim_(l -> infinity) [sum_(n = -infinity)^(infinity) (1/(2l) integral_(-l)^(l) f(t) e^(-(i n pi t) / l) dif t) e^((i n pi x) / l)] \
  &= lim_(l -> infinity) [sum_(n = -infinity)^(infinity) (1/(2l) integral_(-l)^(l) f(t) e^(-(i n pi (x - t)) / l) dif t)]
$

We want to make the integral look like a Riemann form of an integral, which has the general form
$S_n = sum_(k=1)^(n) f(a + k(b - a)/n)((b - a)/n)$, where $a, b$ are the endpoints, and $n$ is the
number of rectangles. The width of the rectangles $(b - a) / n$ is $Delta x$. This formula could be
rewritten then as
$S_n = sum_(k=1)^(n) f(a + k Delta x)(Delta x)$

If we take $lambda_n = (n pi) / l, Delta x = Delta lambda = lambda_(n + 1) - lambda_n = pi/l$

We can now make the equation look like the Riemann form of an integral #note[
  The old constant $1 / (2 l)$ in front changes so that it can cancel out $Delta lambda$
]


$f(x) = lim_(l -> infinity) [sum_(n = -infinity)^(infinity) 1/(2pi) integral_(-l)^(l) f(t) e^(lambda_n i (x - t)) dif t] Delta lambda$

From here, as we take $l -> infinity$, we can use Riemann's form to make it look like
$
  f(x) = 1/(2pi) integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) f(t) e^(i lambda (x - t)) dif t dif lambda
$

If we just change how it is multiplied, it becomes the form we see at the beginning.

== Properties
+ The Fourier Transform and it's inverse are linear operators
  $ cal(F)[f + g] = cal(F)[f] + cal(F)[g] "and" cal(F)[c f] = c cal(F)[f] $
  $ cal(F)^(-1)[f + g] = cal(F)^(-1)[f] + cal(F)^(-1)[g] "and" cal(F)^(-1)[c f] = c cal(F)^(-1)[f] $
+ F.T. of $f times t^n$
  $ cal(F)[t^n f(t)](lambda) = i^n (d^n)/(d lambda^n){cal(F)[f](lambda)} $
+ Inverse F.T. of $f times lambda^n$
  $ cal(F)^(-1)[lambda^n f(lambda)](t) = (-i)^n (d^n)/(d t^n){cal(F)^(-1) [f](t)} $
+ F.T. nth derivative
  $ cal(F)[f^n (t)](lambda) = (i lambda)^n cal(F)[f](lambda) $
+ Inverse F.T. nth derivative
  $ cal(F)^(-1)[f^n (lambda)](t) = (- i t)^n cal(F)^(-1)[f](t) $
+ F.T. of a translation
  $ cal(F)[f (t - a)](lambda) = e^(- i lambda a) cal(F)[f](lambda) $
+ F.T. of a rescaling
  $ cal(F)[f (b t)](lambda) = 1 / b cal(F)[f](lambda / b) $
+ If $f(t) = 0$ for $t < 0$ (this is good for causal filters in the future) then the relationship
  between the Laplace transform $cal(L)[f]$ and the f.t. is:
  $ cal(F)[f (t)](lambda) = 1 / sqrt(2 pi) cal(L)[f](i lambda) $

== Examples
=== F.T. of $f(t) = e^(- |t|)$
Setting up the equation for the F.T.

$
  hat(f)(lambda) &= 1 / sqrt(2pi) integral_(-infinity)^(infinity) e^(- |t|) e^(-i lambda t) dif t\
  &= 1 / sqrt(2pi) [integral_(-infinity)^(0) e^(t) e^(-i lambda t) dif t + integral_(0)^(infinity) e^(-t) e^(-i lambda t) dif t ]\
  &= 1 / sqrt(2pi) [integral_(-infinity)^(0) e^(t(1 - i lambda)) dif t + integral_(0)^(infinity) e^(-t(1 + i lambda)) dif t ]\
  &= 1 / sqrt(2pi) [evaluated((e^t(1 - i lambda)) / (1 - i lambda))^0_(- infinity) - evaluated(e^(-t(1 + i lambda)) / (1 + i lambda))_0^infinity ]\
$
$
  & = 1 / sqrt(2pi) [1 / (1 - i lambda) - 1 / (1 + i lambda)] \
  & = 1 / sqrt(2pi) [2 / (1 + lambda^2)] \
$


=== Placheral's theorem
$ h(t) = cases(1 &quad -pi <= t < pi, 0 &quad "otherwise.") $

Recall that $hat(h)(lambda) = sqrt(2/pi) frac(sin(pi lambda), lambda)$. Use Plancheral's theorem to
find
$ integral_0^infinity frac(sin^2(x), x^2) d x. $

We know that

$ <f(x), f(x)> = integral_(- infinity)^(infinity) hat(f) hat(f) dif lambda $
$
  integral_(- infinity)^(infinity) h(t) h(t) dif t = integral_(- infinity)^(infinity) hat(h) hat(h) dif lambda
$
$
  integral_(- pi)^(pi) 1 dif t = integral_(- infinity)^(infinity) (sqrt(2 / pi) sin(pi lambda) / lambda)^2 dif lambda
$

$
  cancel(2) pi = cancel(2) / pi integral_(- infinity)^(infinity) (sin^2(pi lambda)) / (lambda^2) dif lambda
$

$
  pi ^ 2 = integral_(- infinity)^(infinity) (sin^2(pi lambda)) / (lambda^2) dif lambda
$

$(sin^2 (x)) / (x^2)$ is even, so this means

$
  pi ^ 2 / 2 = integral_(0)^(infinity) (sin^2(pi lambda)) / (lambda^2) dif lambda
$

Let $x = pi lambda, dif x = pi dif lambda$

$
  pi / 2 = integral_(0)^(infinity) (sin^2(x)) / (x^2) dif lambda
$
