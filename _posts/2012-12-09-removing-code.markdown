---
layout: post
title: Removing code
---

> If we wish to count lines of code, we should
> not regard them as "lines produced" but as "lines spent": the current
> conventional wisdom is so foolish as to book that count on the wrong
> side of the ledger.
> <small>Edsger W. Dijkstra</small>

I take great pleasure in reducing the size of a codebase.

When you first start a project there is a lot of code churn. As your
understanding of a problem changes the code changes and grows with it.

The real skill comes in being able to recognise smaller problems that
are solved in the course of solving the bigger problem. If you can
identify a reusable solution to a problem that you've had to solve in
order to proceed with solving the larger issue, then you can extract
this solution into its own project.

This may seem obvious to some, but too many times I've seen decent
internal projects get bloated because the overall project was never observed
from afar, from a technical standpoint and broken down into the pieces
that form the solution.

By decomposing your application into smaller reusable components, you
have the potential to combine them in new and interesting ways, and
potentially open source them so anyone can use it and contribute back to
the project.

![](http://img.hecticjeff.net/Screen_Shot_2012-12-09_at_15.23.38-20121209-152357.jpg)
