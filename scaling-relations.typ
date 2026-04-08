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
#let phi = sym.phi.alt

= Scaling Relations and MRA
== Course: Math 414

---

== Core Idea
At a high level, the process of processing (such as compressing or denoising) a signal $y = f(t)$ in
practice is as follows:

+ *Sample*, we can use a power of two greater than Nyquist rate $2^J > 2v = Omega / pi$ for our
  purposes

#align(center)[
  #figure(
    image("./images/mra_sampling_sample.png", width: 100%),
    caption: [
      Sampling our function. Dotted lines are the decomposition as well
    ],
  )
]

+ *Decompose* (with the algorithm below) $f_J$ into a signal of the form
  $f_J(x) = sum_(j = 0)^(J - 1) w_j + f_0$

#align(center)[
  #figure(
    image("./images/mra_sampling_decompose.png", width: 90%),
    caption: [
      I just chose two random ones, the full decomposition is above
    ],
  )
]

+ *Process* the signal.
  + To filter out high frequencies, we can choose a max value of $b_k^j$. If we think about $b_k$ as
    acting on $psi$ by increasing the height, then this means that those frequencies are gone
  + To compress the signal, then $b_k^j$ under a threshold (meaning they don't make a big
    difference), get thrown out

#align(center)[
  #figure(
    image("./images/mra_sampling_process.png", width: 90%),
    caption: [
      To remove high frequencies, we literally just remove the wavelets above a certain level. To
      compress, we remove wavelets which don't add much change
    ],
  )
]
+ *Reconstruct* from our coefficients
#align(center)[
  #figure(
    image("./images/mra_sampling_reconstruct.png", width: 90%),
    caption: [
      Just remaking the signal from our $b_k$ that we got
    ],
  )
]



== Definitions

*This notation is important*

$ f_j in V_j, f_j = sum_(k in ZZ) a_k^j underbrace(phi(2^j x - k), v_j) $

Here is how we decompose our functions for the following proofs


$ phi(x) = phi(2 x) + phi(2x - 1) $
#align(center)[
  #figure(
    image("./images/haar-scaling-scaling.png", width: 80%),
    caption: [
      How we can express the haar scaling function
    ],
  )
]

$ psi(x) = phi(2 x) - phi(2x - 1) $
#align(center)[
  #figure(
    image("./images/haar-wavelet-scaling.png", width: 80%),
    caption: [
      How we can express the haar wavelet function
    ],
  )
]

If we add them
$ phi(2x) = 1 / 2 (phi(x) + psi(x)) $<first>

If we subtract them
$ phi(2x - 1) = 1 / 2 (phi(x) - psi(x)) $<second>

If we replace $x$ with $x - k$

$ phi(x - k) = phi(2x - 2k) + phi(2x - 2k - 1) $
$ psi(x - k) = phi(2x - 2k) - phi(2x - 2k - 1) $

$ phi(2x - 2k) = 1 / 2 (phi(x - k) + psi(x - k)) $<replace1>
$ phi(2x - 2k - 1) = 1 / 2 (phi(x - k) - psi(x - k)) $<replace2>

If we replace $x$ with $2^(j - 1) x$ in @first, @second
$ phi(2^j x) = 1 / 2 (phi(2^(j - 1)x) + psi(2^(j - 1)x)) $
$ phi(2^j x - 1) = 1 / 2 (phi(2^(j - 1)x) - psi(2^(j - 1)x)) $

=== Haar Decomposition Formula
$ a_k^0 = 1/2 (a_(2k)^1 + a_(2k + 1)^1) $
$ b_k^0 = 1/2 (a_(2k)^1 - a_(2k + 1)^1) $

More generally
$ f_j = w_(j - 1) + f_(j - 1) $
$ w_(j - 1) = sum_(k in ZZ) b_k^(j - 1) psi(2^(j - 1)x - k) in W_(j - 1) $
$ f_(j - 1) = sum_(k in ZZ) a_k^(j - 1) psi(2^(j - 1)x - k) in V_(j - 1) $

$ a_k^(j - 1) = 1/2 (a^j_(2k) + a^j_(2k + 1)) $
$ b_k^(j - 1) = 1/2 (a^j_(2k) - a^j_(2k + 1)) $

This gives us

$ f_j = w_(j - 1) + w_(j - 2) + ... + w_0 + f_0 $

=== Haar Reconstruction Formula

$ (a_(2k)^1 = a_k^0 + b_k^0 $
$ (a_(2k + 1)^1 = a_k^0 - b_k^0 $

$ f_J = sum_(k in Z) a_k^j phi(2^J x - k) $

== Proof for decomposition

Let's suppose we have $f_1 in V_1$, with O.N. basis ${phi(2x - k), k in ZZ}$

$ f_1(x) = sum_(k in ZZ) a^1_k phi(2x - k) $

Split into even and odd

$ f_1(x) = sum_(k in ZZ) a^1_(2k) phi(2x - 2k) + sum_(k in ZZ) a^1_(2k + 1) phi(2x - 2k - 1) $

From @replace1 and @replace2, substitute them

$
  f_1(x) = sum_(k in ZZ) a^1_(2k) (1 / 2 (phi(x - k) + psi(x - k))) + sum_(k in ZZ) a^1_(2k + 1) (1 / 2 (phi(x - k) - psi(x - k)))
$

Collecting terms we have

$
  f_1(x) = sum_(k in ZZ) (1 / 2 (a^1_(2k) + a^1_(2k+1)) phi(x - k) + 1 / 2 (a^1_(2k) - a^1_(2k+1)) psi(x - k))
$

$
  f_1(x) = sum_(k in ZZ) 1 / 2 (a^1_(2k) + a^1_(2k+1)) phi(x - k) + sum_(k in ZZ) 1 / 2 (a^1_(2k) - a^1_(2k+1)) psi(x - k)
$<decomposed>

But we also know from before that $f_1 = f_0 + w_0$

$ f_1(x) = sum_(k in ZZ) a_k^0 phi(x - k) sum_(k in ZZ) b_k^0 psi(x - k) $<og_formula>

The coefficients from @decomposed and @og_formula are the same, and we get to the decomposition
formula above.

== Example

Suppose we have a signal $f_2 in V_2$ represented by four scaling coefficients at level $j=2$:
$a^2 = (a_0^2, a_1^2, a_2^2, a_3^2) = [4, 2, 8, 6]$

This means our original sampled function can be written as:
$f_2(x) = 4 phi(4x) + 2 phi(4x - 1) + 8 phi(4x - 2) + 6 phi(4x - 3)$

=== 1. Decomposition ($V_2 arrow V_1 arrow V_0$)
We use the Haar decomposition formulas $a_k^(j-1) = 1 / 2(a_(2k)^j + a_(2k+1)^j)$ and
$b_k^(j-1) = 1 / 2(a_(2k)^j - a_(2k+1)^j)$.

*Step 1: Down to $V_1$*
$a_0^1 = 1 / 2 (a_0^2 + a_1^2) = 1 / 2 (4 + 2) = 3$$
  b_0^1 = 1 / 2 (a_0^2 - a_1^2) = 1 / 2 (4 - 2) = 1
$
$a_1^1 = 1 / 2 (a_2^2 + a_3^2) = 1 / 2 (8 + 6) = 7$$
  b_1^1 = 1 / 2 (a_2^2 - a_3^2) = 1 / 2 (8 - 6) = 1
$
At level $V_1$, our scaling coefficients are $a^1 = (3, 7)$ and our detail (wavelet) coefficients
are $b^1 = (1, 1)$.

*Step 2: Down to $V_0$*
$a_0^0 = 1 / 2 (a_0^1 + a_1^1) = 1 / 2 (3 + 7) = 5$$
  b_0^0 = 1 / 2 (a_0^1 - a_1^1) = 1 / 2 (3 - 7) = -2
$

Our fully decomposed signal is now represented by the coarsest average $a_0^0 = 5$ and the layered
detail coefficients $b_0^0 = -2$ and $b^1 = (1, 1)$.

=== 2. Reconstruction ($V_0 arrow V_1 arrow V_2$)
Now, let's reverse the process to retrieve our original signal using the Haar reconstruction
formulas $a_(2k)^j = a_k^(j-1) + b_k^(j-1)$ and $a_(2k+1)^j = a_k^(j-1) - b_k^(j-1)$.

*Step 1: Up to $V_1$*
$a_0^1 = a_0^0 + b_0^0 = 5 + (-2) = 3$$ a_1^1 = a_0^0 - b_0^0 = 5 - (-2) = 7 $
We have perfectly recovered $a^1 = (3, 7)$ using our $V_0$ components.

*Step 2: Up to $V_2$*
$a_0^2 = a_0^1 + b_0^1 = 3 + 1 = 4$$ a_1^2 = a_0^1 - b_0^1 = 3 - 1 = 2 $
$a_2^2 = a_1^1 + b_1^1 = 7 + 1 = 8$$ a_3^2 = a_1^1 - b_1^1 = 7 - 1 = 6 $
We have successfully reconstructed our original signal coefficients $a^2 = (4, 2, 8, 6)$!

