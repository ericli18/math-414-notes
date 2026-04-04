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

= Haar Scaling Function & MRA
== Course: Math 414

---

== Core Idea
We want to approximate a signal using Haar building blocks instead, since we don't necessarily know
when in time something happened with Fourier (See the wavelets for more info. My explanation is
still bad there).

This is our first attempt to help solve that problem, we decompose our function into a collection of
blocks. There are some properties here, but wavelets are more useful.

== Scaling Function $phi$

$ phi(x) = cases(1 quad 0 <= x < 1, 0 quad "otherwise") $

#align(center)[
  #image("./images/haar-scaling-base.png", width: 50%)
]

$phi(x - k)$ Looks like $phi$, but translated to the right by $k$ units
$ V_0 = sum_(k in ZZ)a_k phi(x - k), quad a_k in RR $

=== Orthogonality Property
The integer translations of $phi(x)$ are orthonormal:
$
  chevron.l phi(x - k), phi(x - l) chevron.r = integral_(-infinity)^(infinity) phi(x - k) phi(x - l) dif x = delta_(k, l)
$

== Nested Subspaces $V_j$
The Haar scaling function defines subspaces $V_j subset L^2(RR)$ at different resolution levels.
(The thinner rectangles, the higher the resolution)

- $V_0$: piecewise constant on $[k, k+1)$
  $ V_0 = "span"{phi(x - k) : k in ZZ} $
- $V_j$: piecewise constant on $[2^(-j)k, 2^(-j)(k+1))$
  $ V_j = "span"{phi(2^j x - k) : k in ZZ} $

=== Orthonormal Basis for $V_j$
To normalize the basis in $L^2$, we scale by $2^(j\/2)$:
$ phi_(j,k)(x) = 2^(j\/2) phi(2^j x - k) $

=== Nesting Property
$ dots.c subset V_(-1) subset V_0 subset V_1 subset V_2 subset dots.c $

== Projection onto $V_j$
To approximate $f(x)$ at resolution $j$, project onto $V_j$:
$ "proj"_(V_j)(f) = sum_(k = -infinity)^(infinity) a_k^j phi(2^j x - k) $

=== Scaling Coefficients $a_k^j$
$ a_k^j = 2^j integral_(-infinity)^(infinity) f(x) phi(2^j x - k) dif x $

The function $phi(2^j x - k)$ is nonzero only when $0 <= 2^j x - k <= 1$, i.e.
$ k / 2^j <= x <= (k + 1) / 2^j $


== Examples
=== $f(x) = x^2$ on $V_2$
Projecting $f(x) = x^2$ onto $V_2$ ($j = 2$), the support of each basis function is
$[k\/4, (k+1)\/4]$.

#table(
  columns: 3,
  align: (center, center, left),
  table.header[$k$][Interval][Coefficient $a_k$],
  [0], [$[0, 1\/4]$], [$4 integral_0^(1\/4) x^2 dif x = 1\/48$],
  [1], [$[1\/4, 1\/2]$], [$4 integral_(1\/4)^(1\/2) x^2 dif x = 7\/48$],
  [2], [$[1\/2, 3\/4]$], [$4 integral_(1\/2)^(3\/4) x^2 dif x = 19\/48$],
  [3], [$[3\/4, 1]$], [$4 integral_(3\/4)^(1) x^2 dif x = 37\/48$],
)

#align(center)[
  #image("./images/haar-scaling-example.png", width: 50%)
]
