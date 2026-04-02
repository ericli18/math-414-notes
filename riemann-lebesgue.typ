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
When a function oscillates, it will eventually die down if N is sufficiently large

== Definition

If $f$ is piecewise continuous on an interval $[a, b]$, then
$
  lim_( lambda->plus.minus inf ) integral_a^b f(x)cos(n x) dif x
  &= lim_( lambda->plus.minus inf ) integral_a^b f(x) sin(n x) dif x \
  &= lim_( lambda->plus.minus inf ) integral_a^b f(x)e^(lambda n x) dif x \
  &= 0
$

== Proof idea
Let's prove the cosine version, integrating by parts gives us
$
  &integral_a^b f(x)cos(n x) dif x \
  &= 1/lambda (f(b) sin(lambda b) - f(a) sin(lambda a)) - 1/lambda integral_a^b f'(x) sin(n x) dif x
$

