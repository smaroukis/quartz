---
title: Faradays Ice Pail Experiment and the Effect of Shield Grounding
date: 2024-01-30
description: An incomplete inquiry into shield grounding from the electrostatics point of view.
tags:
  - electronics
  - electromagnetism
slug: electrostatics-1
draft: false
math: false
---

In Ralph Morrison's industry standard book *Grounding and Shielding, Circuits and Interference* (Wiley, 2016) he mentions that 

> Shielding has nothing to do with external connections to the shield conductor. If the electric field is contained, the shield is effective. The shield need not be at “ground potential” to be effective. (p18)

I think this needs some clarification, because grounding a shield does effect the external distribution of electric fields, if the net charge enclosed is not zero. I think what Morrison is talking about here is cases where we have electric fields inside the shield but the net enclosed charge is zero, like a battery or low frequency ac signals. 

When I went through the electrostatics, I discovered [Faraday's ice pail experiment](https://en.wikipedia.org/wiki/Faraday%27s_ice_pail_experiment) that shows that for a charged object placed inside a fully enclosed metallic surface (aka a shield) the charge inside the metallic surface will induce an electric field outside of the shield. 

![[Til - electrostatics-1739695453749.jpeg]]

Gauss's law also shows this, since if we take the Gaussian surface inside the shield, we have a net enclosed charge, so we must have field lines coming out of the shield. 

![[Til - electrostatics-1739695486340.jpeg]]

Now if the shield is grounded, there are no E field lines coming out of it, since by definition the shield is at 0V potential. This is actually the same figure that Morrison shows in the book in Figure 1.6. The point is that the shield needs to fully enclose the shield, and even if the shield is grounded, if the field lines escape through an aperture, they will couple to other conductors.

From Morrison:
![[Til - electrostatics-1739696366895.jpeg]]

My added clarification: 

| Grounded Shield                              | Ungrounded Shield                            |
| -------------------------------------------- | -------------------------------------------- |
| ![[Til - electrostatics-1739695887417.jpeg]] | ![[Til - electrostatics-1739695934297.jpeg]] |


P.S. I'm working on getting comments on here but in the meantime message me with comments at maroukis.net/contact.



