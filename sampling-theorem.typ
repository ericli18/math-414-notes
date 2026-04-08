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

= Sampling Theorem
== Course: Math 414

---

== Core Idea
Human ears can only hear things under 20kHz. We have no way to record continuous audio, so what do
we do?

We can sample a signal at a frequency greater than twice its highest frequency component and get an
accurate sample.

== Definition
$f$ is frequency band limited if there is a constant $Omega > 0 "s.t."$
$ hat(f) (lambda) = 0 quad |lambda| > Omega $

Some variables to know: $v$ is the frequency in Hz

To get from standard frequency $v$ to angular frequency $Omega$,
$ Omega = 2 pi v $

Nyquist Frequency: $v = Omega / (2 pi)$

Nyquist Rate (the minimum required sampling speed):
$2v = Omega / (pi)$


*This is important* the Nyquist rate is the minimum speed at which you must take samples of an
analog signal
#note[This just basically means real time. It's like a clock with two hands]

=== Shannon-Whittaker Sampling Theorem
$hat(f)(lambda)$ is piecewise smooth, continuous, and band limited

$f = cal(F)^(-1)[hat(f)]$ is completely determined by its values at the points
$t_j = j pi / Omega; j in ZZ$

In math, it means

$
  f(t) = sum_(j = - infinity)^(infinity) f((j pi) / Omega) (sin(Omega t - j pi)) / (Omega t - j pi)
$

If you notice, we need to sample each $pi / Omega$ seconds, which is our period, so the reverse is
the Nyquist rate

== Proof idea (Need to know for exam)
We know that $hat(f)$ is continuous on $[-Omega, Omega]$ by the definition of band limited. Let's
expand $hat(f)$ as a Fourier series on $[-Omega, Omega]$ (since it's 0 outside of this anyways)

$ hat(f)(lambda) = sum_(k = -infinity)^infinity c_k e^((i pi k lambda ) / Omega) $
$
  c_k = 1 / (2 Omega) integral_(- Omega)^(Omega) hat(f)(lambda)e^(- (i pi k lambda )/ Omega) dif lambda
$
We want to change this to look like a Fourier Transform. Since it's band limited, we can say that
our integral goes everywhere (since it's 0 everywhere other than our band, so it's okay)
$
  c_k = (sqrt(2 pi)) / (2 Omega) 1 / (sqrt(2 pi)) integral_(- infinity)^(infinity) hat(f)(lambda)e^(- (i pi k lambda) / Omega) dif lambda
$
$
  c_k = (sqrt(2 pi)) / (2 Omega) f(-(k pi) / Omega)
$

Let's plug this back in
$
  hat(f)(lambda) = sum_(j = -infinity)^infinity (sqrt(2 pi)) / (2 Omega) f(-(j pi) / Omega)
  e^((i pi j lambda ) / Omega)
$

This converges uniformly since we said $hat(f)$ is piecewise smooth, continuous and it converges
uniformly.

Let's also change the summation index from $j$ to $j = -k$

$
  hat(f)(lambda) = sum_(j = -infinity)^infinity (sqrt(2 pi)) / (2 Omega) f((j pi) / Omega)
  e^(-(i pi j lambda ) / Omega)
$

If we now take the I.F.T. of $f(t)$, and plug in what we found for $hat(f)$, we end up with the
following:

$
  f(t) = 1 / sqrt(2 pi) integral_(- Omega)^(Omega) hat(f)(lambda) e^(i lambda t) dif lambda
$

If we plug in what we got for $hat(f)$

$
  f(t) = 1 / cancel(sqrt(2 pi)) integral_(- Omega)^(Omega) (sum_(j = -infinity)^infinity cancel(sqrt(2 pi)) / (2 Omega) f((j pi) / Omega)
    e^(-(i pi j lambda ) / Omega)
  )e^(i lambda t) dif lambda
$

Swapping around the sum and integral

$
  f(t) = sum_(j = -infinity)^infinity 1 / (2 Omega) f((j pi) / Omega)
  integral_(- Omega)^(Omega)
  e^(i lambda(t - (pi j)/ Omega)) dif lambda
$

The integral simplifies to
$
  integral_(- Omega)^(Omega)
  e^(i lambda(t - (pi j)/ Omega)) dif lambda = 2 Omega sin(t Omega - j pi) / (t Omega - j pi)
$

If we plug things back in

$
  f(t) = sum_(j = -infinity)^infinity cancel(1 / (2 Omega)) f((j pi) / Omega)
  (cancel(2 Omega) sin(t Omega - j pi) / (t Omega - j pi))
$

This brings us back to the Shannon thing.

== What happens if you over/under sample?

#align(center)[
  #figure(
    image("./images/sampling-theorem.png", width: 80%),
    caption: [
      We can see the effects of over/under sampling in reconstructing our original signal here
    ],
  )
]
