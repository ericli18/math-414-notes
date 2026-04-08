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

= Linear Time Invariant Filters
== Course: Math 414

---

== Core Idea
A filter is a "black box" that takes in an input, processes it in some way, then returns an output
which is a modified form of the input. We can almost think of it like the oracle in Quantum
Circuits.

== Definitions
A signal is a function $f: RR |-> CC$ that is piecewise continuous. Basically a mapping of time to a
complex number. A filter is a transformation $L$ that maps a signal $f$ into another signal
$tilde(f)$

To be a _linear_ filter, it satisfies the following properties:
+ Additivity: $L[f + g] = L[f] + L[g]$
+ Homogeneity: $L[c f] = c L[f]$, where $c$ is a constant

To be _time invariant_, the filter should basically line up the original filter. $L$ is time invariant if the time shifted signal $f(t - a)$ is transformed by $L$ into the time-shifted output signal $(L f)(t - a)$

For notation, we can define $f_a(t) = f(t - a)$, $f_a$ is a time shift of $a$ units of signal $f$.

Technically, this means that for any signal $f$ and $a in RR$,

$ L[f_a](t) = (L[f])_a $


== Properties

Let $L$ be a linear filter. The *impulse response* is defined as:

$ h(t, tau) = L[delta(t - tau)] $

where $delta$ (the Dirac delta) is an infinitely narrow peak at $0$ with an area of $1$. Because
this impulse happens in an infinitely small instant of time, it contains all frequencies. Therefore,
the impulse response tells us exactly how the filter reacts to every possible frequency. You can
think of $delta$ as the identity element for convolution.

The *Schwartz kernel theorem*#note[Apparently this is hella annoying to prove, so we take it as a
  given] states that for each linear system $L$, there is a unique kernel $h(t, tau)$ such that the
output can be computed as:

$ L[f](t) = integral_(-oo)^oo h(t, tau) f(tau) dif tau $

If we can find a way to express our system's transformation as an integral with a kernel, we can
safely assume that kernel _is_ our impulse response.

If our system is LTI, it means

$ L[f](t - tau) = g(t - tau) $

Finally, assuming our system is both LTI, the time invariance dictates that the impulse response
depends strictly on the _difference_ in time between when the impulse occurs ($tau$) and when we
observe it ($t$).

$ h(t, tau) = h(t - tau) $

Because of this, the integral simplifies into a standard convolution:

$ L[f](t) = integral_(-oo)^oo h(t - tau) f(tau) dif tau = (h * f)(t) $

Finally, one way to think about an LTI filter is that it adds no new frequencies

$ L[e^(i lambda t)] = sqrt(2 pi) hat(h)(lambda) e^( i lambda t) $


== Proof idea
=== Proof that LTI adds no new frequencies

Let's define a new shifted signal

$ y(t) = L[e^(i lambda t)] $

Since $L$ is time invariant, and linear, we know that

$ L[e^(i lambda (t - a))] = y(t - a) $

$ L[e^(-i lambda a) e^(i lambda t)] = e^(-i lambda a) L[e^(i lambda t)] = e^(-i lambda a) y(t) $

Equating these two expressions gives us:

$ y(t - a) = e^(-i lambda a) y(t) $

If we take $a = t$ then solve , we see the output is just the input scaled by a constant $y(0)$ that depends on frequency but not time:

$ y(t) = y(0) e^(i lambda t) $

To find what $y(0)$ actually is, we use the fact that the output of an LTI system is the convolution of the input with the system's impulse response $h(t)$ and figure out that 

$ y(t) = e^(i lambda t) (sqrt(2 pi) hat(h)(lambda)) $

If we evalute plug in $y(0)$, it give us

$ L[e^(i lambda t)] = sqrt(2 pi) hat(h)(lambda) e^(i lambda t) $

=== Proof that LTI can be a convolution

=== Definition of Laplace Transform
$hat(h) (lambda) = 1/(sqrt(2 pi)) cal(L)[h](i lambda)$
