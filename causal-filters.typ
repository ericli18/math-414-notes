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
#show link: underline

= Causal Filters
== Course: Math 414

---

== Core Idea

For practical applications of filters, cause precedes effect (duh). The past determines the present,
blah blah.

For an input signal to be causal, it just can't be running before we flip a switch.

For a causal filter, if the input signal is causal (which is basically always true), the output must
also be causal. Basically it never goes into the past.

This means that the impulse response $h(t)$ must also equal 0 before $t < 0$. If we think about it
as a convolution, using the flip and slide, if something existed a little bit before 0, then in the
convolution, a little someting will exist a little bit before 0 as well. (okay rewrite)

== Definitions
+ A function $f(t)$ is _causal_ if it is $0$ for $t < 0$
+ An LTI filter is _causal_ if causal inputs go to causal outputs #note[Not from our book, but from
    #link(
      "https://archive.org/details/TheFourierTransformAndItsApplicationsBracewell",
    )[Ron Bracewell's book]]


Or

+ An LTI filter is _causal_ if and only if its impulse response $h(t)$ is $0$ for $t < 0$

== Proof
Lets assume that $h(t) = 0 forall t < 0$

By definition,
$ L[f](t) = (f * h)(t) = integral_0^infinity f(tau) h(t - tau) d tau $

Let's say we assume $t < 0$ (The state of our output signal before time 0) $tau >= 0$ (The original
signal already went on)

This means $t - tau < 0$, and since we assumed that $h(t) = 0$ when $t < 0$, the output also equals
0

We have to prove the other way for the *iff* statement, it's an exercise but this is my solution

Let's assume that $h(t)$ is continuous. This isn't always the case in the real world, but in pure
math it's required as otherwise it's possible for the $dif t$ to have no area.

Let's assume $h(t_0) != 0; T_0 < 0$, WLOG $h(t_0) > 0$.

Since $h$ is continuous, $exists delta > 0 | h(t) > 0 "on" [t_0 - delta, d_0 + delta]$

Let's make a causal signal $f(t) = cases(
  1 quad t in [0, delta],
  0 quad "otherwise"
)$

Then with the definition of a filter as impulse response convolved with signal
$ L[f](t_0) = integral_(-infinity)^(infinity) h(t_0 - x) f(x) dif x = integral_0^delta h(t_0 - x) $

Subsitute $y = t_0 - x$
$ integral_(t_0 - delta)^(t_0) h(y) dif y $
Since $h(y) > 0$ on this interval, the integral is positive, and
$ L[f](t_0) != 0 $, so the output signal is not causal! Yay!

== Examples

=== Non Causcal Filter (doesn't work irl)
An ideal filter for removing all frequency components from a signal beyond some cutoff frequency is
an $hat(h)$ such that $cases("positive" quad -alpha <= lambda <= alpha, 0 quad "otherwise")$

$ hat(h)_alpha (lambda) = cases(1 / sqrt(2 pi) quad |lambda| <= alpha, 0 quad |lambda| > alpha) $
$ h_alpha (t) = 1 / (2 pi) integral_(-alpha)^alpha e^(i lambda t) dif t $
$ h_alpha (t) = 1 / (2 pi) (e^(i t alpha) - e^(- i t alpha)) / (i t) $
$ h_alpha (t) = sin(alpha t) / (pi t) $

This is not $0$ when $t < 0$, so if we filter something through it, it fails

=== Causal Filter (works irl)

This is the Butterworth filter

$ h(t) = cases(A e^(- alpha t) &quad t >= 0, 0 &quad t < 0) $
$ hat(h)(lambda) = A / (sqrt(2 pi) (alpha + i lambda)) $

#align(center)[
  #figure(
    image("./images/causal-filter-butterworth.png", width: 80%),
    caption: [
      The parts of the Butterworth filter #note[
        The phase gets shifted, but we suck so we can't tell that the frequencies are shifted irl
        that well lol.
      ]
    ],
  )
]
