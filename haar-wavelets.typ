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
