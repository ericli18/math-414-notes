#set page(width: 8.5in, height: 11in, margin: 1in)
#set text(font: "Latin Modern Roman", size: 11pt)
#set math.equation(numbering: "(1)")

= Gram Schmidt Orthonormalization Process
== Course: Math 414
== Date: Thu Jan 29 11:40:43 AM CST 2026

---

== Core Idea
An orthonormal basis is useful for projections, since we can just take the inner product of every
element of the vector $v$ along the orthonormal basis to find the projection.

== Definitions
$V_0 "has a basis" {v_0, v_1 ... v_N}$.
$"We can find orthonormal basis" {e_0, e_1 ... e_N}$ through linear combinations of $v_j$.

Steps:

#image("images/gram-schmidt-ortho.png", width: 30%)

+ $e_1 = v_1/ (||v_1||)$ This is unit length
+ $"proj"_(e_1)v_2 = <v_2, e_1>e_1$ We can also assume this proj is $v_0$ in the image
+ $E_2 = v_2 - <v_2, e_1> e_1$
+ $e_2 = E_2 / (||E_2||)$
+ $E_3 = v_3 - <v_3, e_1> e_1 - <v_3, e_2> e_2$
+ $e_3 = E_3 / (||E_3||)$
+ $E_n = v_n - sum_(i=1)^(n-1) <v_n, e_i> e_i$ 
+ $e_n = E_n / (||E_n||)$
