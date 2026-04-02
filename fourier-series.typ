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

= Fourier Series
== Course: Math 414
== Date: Mon Feb 2 07:54:09 PM CST 2026

---

== Core Idea
We want to be able to use a combination of $sin$ and $cos$ to build up to any possible function

== Definitions

For a function $f(x) "on the interval" [-pi, pi] ", the fourier series is"$
$ a_0 + sum_(k = 1)^(infinity) a_k cos(k x) + b_k sin(k x) $

== Key Theorems

*Theorem 1.1* The following integral relations hold.

$
  1/pi integral_(-pi)^pi cos(n x) cos(k x) dif x = cases(
    1 & "if" n = k >= 1, ,
    2 & "if" n = k = 0, ,
    0 & "otherwise",
  )
$

$
  1/pi integral_(-pi)^pi sin(n x) sin(k x) dif x = cases(
    1 & "if" n = k >= 1, ,
    0 & "otherwise",
  )
$

$ 1/pi integral_(-pi)^pi cos(n x) sin(k x) dif x = 0 quad "for all integers" n, k. $

This means that the set of all ${ (cos(n x)) / (sqrt(pi)), (sin(n x)) / (sqrt(pi))}$ is orthogonal.

Proof idea: Use the identities

$ cos((n + k) x) = cos(n x)cos(k x) - sin(n x)sin(k x) $
$ cos((n - k) x) = cos(n x)cos(k x) + sin(n x)sin(k x) $

Then either add or subtract them to get an equivalence for $sin(n x) sin(k x)$or$cos(n x) cos(k x)$.

For $cos(n x) sin(n x)$, observe it's an odd function multiplied by an even function

*Theorem 1.2* Given the fourier series, we can find the coefficients by

$ a_0 = 1/(2 pi) integral_(-pi)^(pi) f(x) dif x $
$ a_n = 1/(pi) integral_(-pi)^(pi) f(x) cos(n x) dif x $
$ b_n = 1/(pi) integral_(-pi)^(pi) f(x) sin(n x) dif x $

Proof idea: Multiply from the base Fourier series either $cos(n x) "or" sin(n x)$ and integrate.
Only the terms with
$ n = k $
will contribute from above, which, giving us the above.

*Lemma 1.3:* The above only works for on the interval of $[-pi, pi]$, But this holds for any
interval of length $2 pi$ according to this lemma: Assume $f$ is $2 pi$ periodic and $c$ is a real
number:

$ integral_(-pi + c)^(pi + c) f(x) dif x = integral_(-pi)^(pi) f(x) dif x $

== Example
*Come up with the fourier series for* $f(x) = 2 pi - x "on" [0, 2 pi]$

#align(center)[
  #image("./images/fourier-example-1.png", width: 50%)
]

$ a_0 = 1/(2pi) integral_(0)^(2pi) ( 2 pi - x ) dif x $
Using the graph, we can see this is just a triangle with base and height of $2 pi$, plugging that in
for the integral gives us:
$ a_0 = 1/(2pi) 1/2 (2 pi)^2 $
$ a_0 = 1/2 2 pi $
$ a_n = 1/pi integral_(0)^(2pi) (2pi - x) cos(n x) dif x $
Integrating by parts
$ a_n = 1/pi [(2pi-x) 1/n sin(n x)]_0^(2pi) - integral_0^(2pi) -sin(n x) $
$ a_n = 1/pi (-[1/n cos(n x)]_0^(2pi)) $
$ a_n = - 1/(pi n) (cos(2 pi n) - cos(0)) $
$ a_n = - 1/(pi n) (1 - 1) = 0 $

Now solving for $b_n$:
$ b_n = 1/pi integral_(0)^(2pi) (2pi - x) sin(n x) dif x $
Using integration by parts again with $u = 2pi - x$ and $dif v = sin(n x) dif x$:
$ b_n = 1/pi ( [-(2pi - x)/n cos(n x)]_0^(2pi) - integral_0^(2pi) (-(-1/n cos(n x))) dif x ) $
$ b_n = 1/pi ( [-(2pi - x)/n cos(n x)]_0^(2pi) - integral_0^(2pi) 1/n cos(n x) dif x ) $
The integral of cosine over a full period is zero, so the second term vanishes:
$ b_n = 1/pi [-(2pi - x)/n cos(n x)]_0^(2pi) $
$ b_n = 1/pi ( (-(2pi - 2pi)/n cos(2 pi n)) - (-(2pi - 0)/n cos(0)) ) $
$ b_n = 1/pi ( 0 - (-(2pi)/n dot 1) ) $
$ b_n = 1/pi ( (2pi)/n ) $
$ b_n = 2/n $

Putting it all together for the final Fourier series:
$ f(x) = a_0 + sum_(n=1)^infinity (a_n cos(n x) + b_n sin(n x)) $
$ f(x) = pi + sum_(n=1)^infinity 2/n sin(n x) $

#align(center)[
  #image("./images/fourier-example-1-solved.png", width: 50%)
]

