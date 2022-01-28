# Hu and Varas (JoF, 2021) A Theory of Zombie Lending: REPLICATION

* This Julia project is based on Hu and Varas (2021). This notebook attempts to replicate the paper's main results using Julia. The code is based on the authors' replication code shared by the JoF.

* This project solves the always binding financial constraint case from Section II.B of the [paper](https://onlinelibrary.wiley.com/doi/abs/10.1111/jofi.13022). Moreover, it plots the results for the numerical example from Figure 2.


![alt text](https://i.ibb.co/6nDw6yx/Screenshot-2022-01-23-at-23-59-40.png)

*Figure 2*: Figure 2 plots the value function of three types. The left panel shows the joint valuations of the entrepreneur and the bank, the right one only shows those of the bank. In this example, tb = 1.2921 and tg = 2.1006. In the figure, the green, blue, and red lines represent the value functions of the informed-good, the uninformed, and the informed-bad types, respectively. The dashed horizontal line marks the levels of L. Before t reaches tb, the bad type’s value function stays at L, and all of the continuation value accrues to the bank. Note that at tb, the bad-type entrepreneur’s value function experiences a discontinuous jump, whereas no such jump occurs in the bank’s value function. This contrast is due to the financial constraint yt ≤ c. Indeed, both value functions are smooth without this constraint.

## Example

```
using Hu_Varas_majoarteaga

Hu_Varas_majoarteaga.plot1

Hu_Varas_majoarteaga.plot2

```

Plots 1 and 2 show the replicated versions of Panel A and B, respectively.
