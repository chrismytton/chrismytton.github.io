---
title: Command-query separation principle
layout: post
image: /assets/images/allotment-sunflowers.jpg
tags: [programming]
---

When writing a program it's common to have two distinct types of method, verbs and nouns. The verb methods have names like `generate` or `launch`, and the noun methods have names like `quarterly_sales_statistics` or `current_altitude`.

In verb methods we're giving a command to perform an action, which is probably changing the state of our program in some way. In the noun methods we're querying the state of our program, and we expect some return value from these methods.

The "Command-query separation" principle[^1] says that all methods in a program should either be commands (verbs), which change state but don't return data, or queries (nouns), which return data but don't changes state, but not both.

[^1]: [Command–query separation on Wikipedia](https://en.wikipedia.org/wiki/Command–query_separation)

So if you spot any methods in your programs with verb-like names, and those methods are returning data that's used elsewhere in the program, then this is a potential red flag. These methods can be split up so that the part that returns data is moved into a method that has a noun-like name, which can then be called by the verb method.
