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

= Special Cases of Fourier Series
== Course: Math 414
== Topic: Arbitrary Periods, Extensions, & Complex Form

== 1. Fourier Series on Arbitrary Intervals
Standard Fourier series are often defined on $[-pi, pi]$. To adapt this to a general symmetric interval $[-a, a]$ (where the total period is $T = 2a$), we apply a scaling argument.

*Theorem 1.4 (Change of Interval):*
Suppose $f$ is a function defined on the interval $-a <= x <= a$. We use the substitution $x = (t pi)/a$. The Fourier series takes the form:

$ f(x) = a_0 + sum_(n=1)^(infinity) [ a_n cos((n pi x)/a) + b_n sin((n pi x)/a) ] $

The coefficients are calculated by scaling the integral limits and the argument of the trigonometric functions:

$ a_0 = 1/(2a) integral_(-a)^(a) f(x) dif x $

$ a_n = 1/a integral_(-a)^(a) f(x) cos((n pi x)/a) dif x $

$ b_n = 1/a integral_(-a)^(a) f(x) sin((n pi x)/a) dif x $

> *Note:* As $a -> pi$, these formulas reduce to the standard definition.


== 2. Half-Range Expansions (Extensions)
Often we are given a function only on the interval $[0, L]$ and asked to represent it as a Fourier series. We can "extend" the function to $[-L, L]$ in two specific ways to simplify the series.

=== Cosine Series (Even Extension)
If we extend $f(x)$ to be an *even* function on $[-L, L]$ (where $f(-x) = f(x)$), then:
1. $f(x) sin((n pi x)/L)$ is odd, so all $b_n = 0$.
2. We only compute $a_n$ terms.

$ f(x) = a_0 + sum_(n=1)^infinity a_n cos((n pi x)/L) $

$ a_0 = 1/L integral_0^L f(x) dif x $
$ a_n = 2/L integral_0^L f(x) cos((n pi x)/L) dif x $

=== Sine Series (Odd Extension)
If we extend $f(x)$ to be an *odd* function on $[-L, L]$ (where $f(-x) = -f(x)$), then:
1. $f(x) cos((n pi x)/L)$ is odd, so all $a_n = 0$ (including $a_0$).
2. We only compute $b_n$ terms.

$ f(x) = sum_(n=1)^infinity b_n sin((n pi x)/L) $

$ b_n = 2/L integral_0^L f(x) sin((n pi x)/L) dif x $

---

== 3. Complex Fourier Series
The Fourier series can be expressed more compactly using complex exponentials. This is often useful for signal processing and physics.

*Theorem 1.18 (Complex Form):*
Since $e^(i n t) = cos(n t) + i sin(n t)$.
If $f(t)$ is defined on the interval $-pi <= t <= pi$, the complex Fourier series is:

$ f(t) = sum_(n = -infinity)^(infinity) alpha_n e^(i n t) $

The complex coefficients $alpha_n$ are given by a single formula:

$ alpha_n = 1/(2 pi) integral_(-pi)^(pi) f(t) e^(- i n t) dif t $

=== Relation to Real Coefficients
Using Euler's identity $e^(i theta) = cos(theta) + i sin(theta)$, we can relate the complex coefficients $alpha_n$ to the real coefficients $a_n, b_n$:

For $n > 0$:
$ alpha_n = 1/2 (a_n - i b_n) $
$ alpha_(-n) = 1/2 (a_n + i b_n) $

For $n = 0$:
$ alpha_0 = a_0 $

If $f(t)$ is real-valued, then $alpha_(-n) = overline(alpha_n)$ (conjugate symmetry).
