#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock
#show: marginalia.setup.with(
  outer: (far: 5mm, width: 28mm, sep: 8mm),
  top: 2.5cm,
  bottom: 2.5cm,
)
#set page(width: 8.5in, height: 11in, margin: 1.5in)
#set text(font: "Latin Modern Roman", size: 11pt)
#set math.equation(numbering: "(1)")

= Least Squares Problems
== Course: Math 414
== Date: #datetime.today().display()

---

== Core Idea
One of the standard problems in 3D geometry is finding the distance from a point to a plane. We can
put a lot of applied problems into a similar form and use least-squares to find the minimizer.

== Definitions
We want to find the distance of a vector $v$ to a subspace $W$ of an inner product space $V$. We
want to find a point $v_0$ in $W$ which is closest to $v$. The shortest path from the point to the
subspace is orthogonal to the subspace.

The distance is the minimum of $|| v - w ||$, where $w$ is any vector in $W$. The specific vector
$v_0$ that achieves this is the *minimizer*.

== Key Theorems
+ Let $V$ be a inner product space containing both $W$ and $v$. A vector $v_0$ in $W$ minimizes the
  distance $|| v - w ||$ iff:
  $ v_0 "satisfies" (*) quad chevron.l v - v_0, w chevron.r = 0, forall w in W $
  And $v_0$ is unique.

  *In simpler terms:*
  - The "error vector" $(v - v_0)$ must be perpendicular (orthogonal) to every vector in the
    subspace $W$. If the error leans at all, we could effectively slide $v_0$ over to reduce the
    distance. When it stands straight up (90 degrees), we have reached the minimum.

  *Calculation Method:*
  - This theorem allows us to calculate the minimizer easily *if* we have an orthonormal basis
    $E = {e_1, ..., e_n}$ for $W$.
  - The formula is:
    $ v_0 = sum_(k=1)^n chevron.l v, e_k chevron.r e_k $
  - This effectively "projects" the target vector $v$ onto each basis vector of the subspace
    individually.

  *Proof of Calculation Method:*
  If we define $v_0 = sum_(j=1)^n chevron.l v, e_j chevron.r e_j$, we can verify it satisfies the
  orthogonality condition by taking the inner product with any basis vector $e_k$:
  $
    chevron.l v - v_0, e_k chevron.r &= chevron.l v, e_k chevron.r - chevron.l sum_(j=1)^n chevron.l v, e_j chevron.r e_j, e_k chevron.r
  $
  $
    = chevron.l v, e_k chevron.r - sum_(j=1)^n chevron.l v, e_j chevron.r underbracket([chevron.l e_j, e_k chevron.r], delta_(j k))
  $
  $ = chevron.l v, e_k chevron.r - chevron.l v, e_k chevron.r = 0 $


== Example 1: Function Approximation
Find the quadratic polynomial that gives the best least squares fit for the function $f(x) = e^(2x)$
on the interval $[-1, 1]$.

*Setup:*
- *Inner Product:* $chevron.l f, g chevron.r = integral_(-1)^1 f(x)g(x) dif x$
- *Space:* $W = P_2$ (Polynomials of degree $2$).
- *Basis:* Normalized Legendre Polynomials (Orthonormal):
  $ p_0(x) = 2^(-1/2), quad p_1(x) = (3/2)^(1/2)x, quad p_2(x) = (5/8)^(1/2)(3x^2 - 1) $

*Calculation:*
Using the formula $v_0 = sum chevron.l f, p_k chevron.r p_k$:
- $alpha_1 = chevron.l f, p_0 chevron.r = integral_(-1)^1 e^(2x) p_0(x) dif x = 8^(-1/2)(e^2 - e^(-2))$
- $alpha_2 = chevron.l f, p_1 chevron.r = integral_(-1)^1 e^(2x) p_1(x) dif x = (3/32)^(1/2)(e^2 + 3e^(-2))$
- $alpha_3 = chevron.l f, p_2 chevron.r = integral_(-1)^1 e^(2x) p_2(x) dif x = (5/128)^(1/2)(e^2 - 13e^(-2))$

The best fit polynomial is:
$ p(x) = 1/4 (e^2 - e^(-2)) + 3/8 (e^2 + 3e^(-2))x + 5/32 (e^2 - 13e^(-2))(3x^2 - 1) $

---

== Example 2: Data Fitting (Step-by-Step)
Find the line $y = a_1 + a_2 t$ that best fits the data:
#table(
  columns: 6,
  [t], [0], [1], [2], [3], [4],
  [ln(C)], [-0.1], [-0.4], [-0.8], [-1.1], [-1.5],
)

*1. Set up vectors*
We define our target vector $y_d$ (the data) and the vectors that span our line $W$:
$ y_d = [-0.1, -0.4, -0.8, -1.1, -1.5]^T $
$ w_1 = [1, 1, 1, 1, 1]^T " (intercept part)" $
$ w_2 = [0, 1, 2, 3, 4]^T " (slope part)" $
$ W = "span"{w_1, w_2} $
Note: $w_1$ and $w_2$ are *not* orthogonal.

We define our vectors in this way such that if the data was perfect, all equations would be true, it
just makes it $a_1 w_1 + a_2 w_2 = y_d$

*2. Create Orthonormal Basis (Gram-Schmidt)*
We convert $\{w_1, w_2\}$ into an orthonormal basis $\{e_1, e_2\}$:
$ e_1 = 1/sqrt(5) w_1 $
$ e_2 = 1/sqrt(10) (w_2 - 2w_1) $

*3. Calculate Solution in Basis E*
We project $y_d$ onto $e_1$ and $e_2$:
$ v_0 = chevron.l y_d, e_1 chevron.r e_1 + chevron.l y_d, e_2 chevron.r e_2 $
Calculating the dot products yields:
$ v_0 = -1.7441 e_1 - 1.1068 e_2 $

*4. Change Basis back to W (The Logic)*
We need the answer in the form $y = a_1 + a_2 t$, which corresponds to $v_0 = a_1 w_1 + a_2 w_2$. We
substitute the definitions of $e_1$ and $e_2$ (from step 2) into our solution (from step 3):

$
  v_0 = -1.7441 underbracket((5^(-1/2) w_1), e_1) - 1.1068 underbracket((10^(-1/2) (w_2 - 2w_1)), e_2)
$

Group the terms by $w_1$ and $w_2$:
$
  v_0 = underbracket([-1.7441(5^(-1/2)) - 1.1068(10^(-1/2))(-2)], "Coefficient " a_1) w_1 + underbracket([-1.1068(10^(-1/2))], "Coefficient " a_2) w_2
$

Calculating these values:
$ a_1 = -0.78 + 0.70 = -0.08 $
$ a_2 = -0.35 $

*Final Line:*
$ y = -0.08 - 0.35t $
