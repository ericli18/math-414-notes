#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock
#show: marginalia.setup.with(
  outer: (far: 5mm, width: 28mm, sep: 8mm),
  top: 2.5cm,
  bottom: 2.5cm,
)
#set page(width: 8.5in, height: 11in, margin: 1.5in)
#set text(font: "Latin Modern Roman", size: 11pt)
#set math.equation(numbering: "(1)")

= Orthogonal Projections
== Course: Math 414
== Date: Thu Jan 29 11:40:43 AM CST 2026

---

== Core Idea
We want to find the closest vector to another vector when they don't have the same span.

== Definitions
Suppose $V_0$ is a subspace of inner product space $V$ and $v in V$ and $v in.not V_0$ We want to
determine a vector $v_0 in V_0$ closest to v. This is defined as
$||v - v_o|| = min_(w in V_0)||v - w||$. Basically it just says $v_o$ is the closest one of all the
vectors on $V_0$ lol.

== Key Theorems
+ $v - v_0$ is orthogonal to every vector in $V_0$
  - Proof idea: Minimize the function $f(t) = ||v_0 + t w - v||^2$ #note[$v_0 + t w$ is the equation
      of anything on the span of $V_0$. We take the distance between $v$ and all our test vectors],
    which happens to be when $t = 0$, then calculate derivative and inner products from there
+ Orthogonal projection of
  $v in V "onto o.n. basis" {e_1, e_2, ... e_N} "is given by" sum_(j=1)^N alpha_j e_j$ where
  $alpha = chevron.l v_j, e_j chevron.r$
  - Proof idea: Show that $v - v_0$ is orthogonal to everything in $V_0$ (this satisfies the above
    theorem)
+ Proof of unique minimizer

== Example

+ Calculate the ditance from the point $P(3, 7, -4)$ to the plane $6x - 3y + 2z = 10$. We define $B$
  as the distance from a point on the plane to $P$, we want to find the norm of the projection of
  $B$ onto the normal vector of the plane $N$. $D = "comp"_N B = ||B||cos theta = (|| chevron.l
  N, B chevron.r ||) / (||N||)$ #image("images/point-to-plane.png", width: 40%)

== Connections

+ Look at least squares problems for a lot more projections.
