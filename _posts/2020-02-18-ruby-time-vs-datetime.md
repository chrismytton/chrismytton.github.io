---
layout: post
title: Ruby's Time vs DateTime classes
tags: [programming]
---

Prefer Ruby's `Time` class to `DateTime` when dealing with near-past, present or future dates.

Use `DateTime` when you want to accurately model distant past dates, like Shakespeare's birthday.

From [this answer on StackOverflow](https://stackoverflow.com/a/21075654).
