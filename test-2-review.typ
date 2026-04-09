#set page(width: 8.5in, height: 11in, margin: 1in)
#import "@preview/physica:0.9.8" as physica: evaluated
#set text(font: "Latin Modern Roman", size: 11pt)
#set math.equation(numbering: "(1)")
#let phi = sym.phi.alt

= Test 2 review
== Course: Math 414

---

== Problems

1. State and prove the convolution theorem
2. State and prove the sampling theorem
3. Prove that ${phi(2^j x - k)}_(k = - infinity)^infinity$ is an orthogonal set
4. Derive the decomposition and recomposition formulas
5. Let $f_s(x) = sqrt(s)e^(-s x^2)$. Show that

  $ hat(f)_s (lambda) = 1/sqrt(2) e^((-lambda^2)/(4s)). $

  _Hint:_ After writing out the definition of the Fourier transform, complete the square in the
  exponent, then perform a change of variables in the resulting integral (a complex translation) and
  then use the fact that $integral_(-oo)^oo e^(-x^2) d x = sqrt(pi)$.<hard-fourier>

6. $f(t) = cases(e^(-t) quad t >= 0, 0 quad "otherwise")$. Find $hat(f)(lambda)$ and use your answer
  to find $cal(F)[f(2t)](lambda)$

+  $ h(t) = cases(1 &quad -pi <= t < pi, 0 &quad "otherwise.") $

  Recall that $hat(h)(lambda) = sqrt(2/pi) frac(sin(pi lambda), lambda)$. Use Plancheral's theorem to
  find
  $ integral_0^infinity frac(sin^2(x), x^2) d x. $

+ Define the term _linear, time-invariant filter_. What are it's connections to the convolution? What is the _impulse response_ and _frequency response (system)_ function?

+ What is the Butterworth filter?
+ What is the running average filter?
+ What does it mean to be a causal filter? How do you know if an LTI filter is causal?

+ Consider the filter $L[f] = f * h$, where $h(t)$ is given below. Find the system function, $hat(h)$, and the Fourier transform, $hat(L[f])(lambda)$. Is $L$ causal? Explain. (You _don't_ need to find $f * h$ here.)

  $ h(t) := cases(
    1 quad 0 <= t <= 1,
    0 quad "otherwise."
  ) $

+ Let $h(t) = cases(
    1/5 quad 0 <= t <= 5,
    0 quad t < 0 " or " t > 5
  )$ be the impulse response for $L[f] = h * f$. Find $L[f]$, where $f = cases(
    e^(-3t) quad t >= 0,
    0 quad t < 0
  )$ Find the system (frequency) response function, $sqrt(2 pi) hat(h)$. Is the filter causal? Why
  or why not? (One or two sentences will suffice.) *Also 2002 P1, 2015 P3*




#align(center)[
  #image("./images/test_2_formulas.png")
]

== Solutions
5.
  $
    hat(f)_s(lambda) = 1/sqrt(2pi) integral_(-oo)^oo sqrt(s) e^(-s x^2) e^(-i lambda x) d x = sqrt(s/(2pi)) integral_(-oo)^oo e^(-s(x^2 + (i lambda)/s x)) d x
  $

  $
    = sqrt(s/(2pi)) integral_(-oo)^oo e^(-s[(x + (i lambda)/(2s))^2 + lambda^2/(4s^2)]) d x quad text("let ") x + (i lambda)/(2s) = v
  $

  $
    (*) = sqrt(s/(2pi)) integral_(-oo)^oo e^(-s v^2) dot e^(-lambda^2/(4s)) d v = sqrt(s/(2pi)) dot e^(-lambda^2/(4s)) integral_(-oo)^oo e^(-s v^2) d v
  $

  $ text("let ") s v^2 = w^2 => (sqrt(s) v)^2 = w^2 $

  $
    arrow.b \ = sqrt(s/(2pi)) e^(-lambda^2/(4s)) underbrace(integral_(-oo)^oo 1/sqrt(s) e^(-w^2) d w, = sqrt(pi)) = 1/sqrt(2) e^(-lambda^2/(4s))
  $

6.

  $ hat(f)(lambda) = integral_(-0)^(oo) e^(-t) e^(- i lambda t) dif t $
  $ = integral_(-0)^(oo) e^(-t (1 + i lambda)) dif t $
  $ = evaluated(-(e^(-t (1 + i lambda))) / (1 + i lambda))_0^oo = 1/(1 + i lambda) $

  Now we use the formula

  $ cal(F)[f(2x)] = 1/2 hat(f)(lambda / 2) = 1 / (2 + i lambda) $

7. Solution in F.T. notes
