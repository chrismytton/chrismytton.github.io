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

As time goes on you need to remove code that is no longer used. One
strategy that I often see is commenting the offending code out. This
adds a lot of noise to the code when you're reading it, a much better
strategy is to just remove the unused code, if you need it back you can
ask your VCS.

When you don't take the time to remove old code and features, it's often
more confusing when you come to add new code and features.

![](http://img.hecticjeff.net/Screen_Shot_2012-12-09_at_15.23.38-20121209-152357.jpg)
