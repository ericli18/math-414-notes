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
#let phi = sym.phi.alt

= Haar Wavelets
== Course: Math 414

---

== Core Idea
Approximate a signal using a sum of short lived waves (wavelets), instead of infinite $sin$ and
$cos$.

Due to Heisenberg's uncertainty principle, we cannot both be extremely accurate about location and
time and location and frequency. Think about a blip of time. We know exactly when the sound
happened, but know nothing about the frequency. Otherwise, if we are very certain about frequency,
(such as an infinite sin wave), it has to take up the whole number line. We want to help know when
an oscillation occurs.


#image("./images/heisenberg_part1.png")

Wavelets try to help solve this by keeping track of time and frequency information, their scale
helps "zoom" in on short bursts, or "zooms out" to detect long, slow oscillations.

#image("./images/heisenberg_part2.png")



== Definitions
=== Wavelet $psi$

$ psi(x) = cases(1 quad 0<=x<=1/2, -1 quad 1/2 <= x <= 1, 0 quad "otherwise") $

#align(center)[
  #image("./images/haar-wavelet-base.png", width: 50%)
]

$ W_j = {2^(j / 2) psi(2^j x - k), k in ZZ} $

== Properties

+ $psi(x)$ is a member of $V_1$. If you think about it, it's a special case where each even half
  length interval has the same "shape" with one higher and then one lower line

+ $psi(x) bot V_0$

+ $W_0 bot V_0$ and $V_1 = V_0 plus.o #note[Direct sum. This means every element of V_1 can be made
    up of unique combo of v_0 and w_o] W_0$

  This means if $f in V_1$ (already a piecewise-constant function at resolution $j = 1$), then $f$
  splits *exactly* as $f = f_0 + w_0$ where
  $ f_0 = sum_(k in ZZ) a_k^0 phi(x - k) in V_0, quad w_0 = sum_(k in ZZ) b_k^0 psi(x - k) in W_0 $
  Here $f_0$ is the coarser approximation and $w_0$ is the detail lost when going from resolution 1
  to 0. This is exact because $f$ was already in $V_1$. The scaling relations notes derive the
  explicit coefficients: $a_k^0 = 1/2(a_(2k)^1 + a_(2k+1)^1)$ and
  $b_k^0 = 1/2(a_(2k)^1 - a_(2k+1)^1)$.

+ More generally $V_(j + 1) = V_j plus.o W_j$

+ For an arbitrary $f in L^2(RR)$ (not necessarily in any $V_j$), we need infinitely many detail
  layers. $f_0$ #note[$f_0$ is defined in scaling as the projection at resolution $j = 0$] is the
  projection onto $V_0$, and each $w_j$ captures the detail at scale $j$:
  $ f = f_0 + sum_(j = 0)^infinity w_j $


== Proofs

=== Proving $V_(j + 1) = V_j plus.o W_j$

We must show two facts:
1. Every function in $W_j$ is orthogonal to every other function in $V_j$.
2. Any function in $V_(j + 1)$ orthogonal to $V_j$ must belong to $W_j$. Since $W_j and V_j$ are
  orthogonal (if we prove the above), proving this means we can write anything as a sum of
  $v_j, w_j$.


