# Hu_Varas_majoarteaga.jl

## Hu and Varas (JoF, 2021) A Theory of Zombie Lending: REPLICATION


## Features

* This Julia package is based on Hu and Varas (2021). It replicates the paper's main results using Julia. The code is based on the authors' replication code shared by the JoF.

* This project solves the always binding financial constraint case from Section II.B of the [paper](https://onlinelibrary.wiley.com/doi/abs/10.1111/jofi.13022). Moreover, it plots the results for the numerical example from Figure 2.


![alt text](https://i.ibb.co/6nDw6yx/Screenshot-2022-01-23-at-23-59-40.png)

*Figure 2*: Figure 2 plots the value function of three types. The left panel shows the joint valuations of the entrepreneur and the bank, the right one only shows those of the bank. In this example, tb = 1.2921 and tg = 2.1006. In the figure, the green, blue, and red lines represent the value functions of the informed-good, the uninformed, and the informed-bad types, respectively. The dashed horizontal line marks the levels of L. Before t reaches tb, the bad type’s value function stays at L, and all of the continuation value accrues to the bank. Note that at tb, the bad-type entrepreneur’s value function experiences a discontinuous jump, whereas no such jump occurs in the bank’s value function. This contrast is due to the financial constraint yt ≤ c. Indeed, both value functions are smooth without this constraint.


## How to use

1. Install this package.
2. In package manager mode:
```
(Hu_Varas_majoarteaga) pkg> activate .
(Hu_Varas_majoarteaga) pkg> instantiate
```
3. Obtain both Panel A and Panel B from the paper's Figure 2.
```
julia> using Hu_Varas_majoarteaga

julia> Hu_Varas_majoarteaga.plot1
julia> Hu_Varas_majoarteaga.plot2

```
![alt text](https://i.ibb.co/9sVzyz0/Screenshot-2022-01-28-at-03-05-29.png)
![alt text](https://i.ibb.co/ZhX3G4T/Screenshot-2022-01-28-at-03-05-39.png)



[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://majoarteaga.github.io/Hu_Varas_majoarteaga.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://majoarteaga.github.io/Hu_Varas_majoarteaga.jl/latest



