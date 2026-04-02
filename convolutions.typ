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

= Convolutions and Convolution Theorem
== Course: Math 414

---

== Core Idea
These are pretty bad, but I think in some instances it's helpful to think of things this way.

If we think about the integral, the way we learned it was area under the curve, distance traveled
from velocity. We can think of it as cutting something into infinity small pieces and adding them
up. For convolution, we always see flip and drag, but it's a little hard to visualize for some
things like signals. We can also see it as taking the weighted average of $f(x)$ near $x = t$,
weighed by the values of $g$. It kind of smears the function in a way, $g * f$ is at least as smooth
as $g$ and $f$ are separately.


What are the ways we can use one signal to modify another in the time/freq domain? We can scale up
everything, but what if we want to scale harmonics separately. We want higher pitched notes to be
quieter than lower pitched notes. In the frequency domain, all we have to do is scale those
frequencies invidually (like multiplying by a constant), but in the time domain, we have to take the
weighted average. (Think about smoothing the curve in ENGR 216). Since we can think about F.T. as
exposing how much if the signal is $lambda$ frequency, it does the work of merging a bunch of
entries into one. Yeah I don't have this intuitively completely yet.

#align(center)[
  #figure(
    image("./images/convolution-example.png", width: 80%),
    caption: [
      If we want to remove all the high pitched frequencies, we can either take a weighted average,
      or just drop them in the F.T. (Not completely, but I think I'll touch on it in filters)
    ],
  )
]

== Definition

=== Convolution
The convolution of $f$ and $g$ is defined as
$ (f * g)(t) = integral_(-infinity)^infinity f(t - x) g(x) dif x $
$ (f * g)(t) = integral_(-infinity)^infinity f(x) g(t - x) dif x $

=== Convolution properties
Mostly like multiplication

$ f * g = g * f $
$ (f * g) * h = f * (g * h) $
$ f * (g + h) = f * g + f * h $

There is a $1$ for convolution, but will touch on that later

=== Convolution Theorem
The convolution of two functions in the time domain is multiplication in the frequency domain.
$ cal(F) [f * g] = sqrt(2 pi) hat(f) dot hat(g) $
$ cal(F)^(-1) [hat(f) dot hat(g)] = 1 / sqrt(2 pi) (f * g) $

== Proof idea

What is $hat(f) hat(g)$? In the time domain, can we combine the signal $g(t)$ with the signal $f(t)$
so that that the frequencies of $hat(f)(lambda)$ are scaled by the frequency components
$hat(g)(lambda)$

Let's pretend that we know, and solve it out to define convolution. (This is the reverse of what is
shown in the textbook)

$
  sqrt(2 pi) hat(f) hat(g) = sqrt(2 pi)
  (1/sqrt(2 pi) integral_(-infinity)^infinity f(s)e^(- i lambda s) dif s )
  (1/sqrt(2 pi) integral_(-infinity)^infinity g(x)e^(- i lambda x) dif x )
$
$
  =
  1/sqrt(2 pi) integral_(-infinity)^infinity integral_(-infinity)^(infinity) f(s)e^(- i lambda s) e^(-i lambda x) dif s
  (g(x) dif x ) \
$
$
  =
  1/sqrt(2 pi) integral_(-infinity)^infinity integral_(-infinity)^(infinity) f(s)e^(- i lambda (s + x)) dif s
  (g(x) dif x ) \
$

Let's uncouple the integrals real quick
$
  =
  1/sqrt(2 pi) integral_(-infinity)^infinity (integral_(-infinity)^(infinity) f(s)e^(- i lambda (s + x)) dif s)
  g(x) dif x
$

Let $u = s + x$, $dif u = dif s$ $s = u - x$
$
  =
  1/sqrt(2 pi) integral_(-infinity)^infinity (integral_(-infinity)^(infinity) f(u - x)e^(- i lambda (u)) dif u)
  g(x) dif x
$
Why did we do this? Let's swap the order of integration
$
  =
  1/sqrt(2 pi) integral_(-infinity)^infinity (integral_(-infinity)^(infinity) f(u - x)g(x) dif x )
  e^(- i lambda u) dif u
$
Now if we are smart, bright, brilliant, we realize we have finished the proof

$ h(u) = integral_(-infinity)^(infinity) f(u - x)g(x) dif x $
$ hat(f) hat(g) = 1/sqrt(2 pi) integral_(-infinity)^(infinity) h(u) e^(- i lambda u) dif u $

Where did we start, where did we finish?
$ hat(f) hat(g) = cal(F)[h](lambda) $

