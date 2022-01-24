# Hu and Varas (WP, 2021) A Theory of Zombie Lending: REPLICATION


*Abstract: An entrepreneur borrows from a relationship bank or the market. The bank has a higher cost of capital but produces private information over time. While the entrepreneur accumulates reputation as the lending relationship continues, asymmetric information is also developed between the bank/entrepreneur and the market. In this setting, zombie lending is inevitable: Once the entrepreneur becomes sufficiently reputable, the bank will roll over loans even after learning bad news, for the prospect of future market financing. Zombie lending is mitigated when the entrepreneur faces financial constraints. Finally, the bank stops producing information too early if information production is costly.*


-This Julia project is based on Hu and Varas (2021). This notebook attempts to replicate the paper's main results using Julia. The code is based on the authors' replication code shared by the JoF.

-This file solves the always binding financial constraint case from Section II.B. See Figure 2 below for reference.

![alt text](https://i.ibb.co/6nDw6yx/Screenshot-2022-01-23-at-23-59-40.png)

*Figure 2*: Figure 2 plots the value function of three types. The left panel shows the joint valuations of the entrepreneur and the bank, the right one only shows those of the bank. In this example, tb = 1.2921 and tg = 2.1006. In the figure, the green, blue, and red lines represent the value functions of the informed-good, the uninformed, and the informed-bad types, respectively. The dashed horizontal line marks the levels of L. Before t reaches tb, the bad type’s value function stays at L, and all of the continuation value accrues to the bank. Note that at tb, the bad-type entrepreneur’s value function experiences a discontinuous jump, whereas no such jump occurs in the bank’s value function. This contrast is due to the financial constraint yt ≤ c. Indeed, both value functions are smooth without this constraint.
