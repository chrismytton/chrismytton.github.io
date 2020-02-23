---
layout: post
title: Ruby's Time vs DateTime classes
tags: [programming]
---

[Ruby](https://www.ruby-lang.org/) has two classes, `Time` [^1] and `DateTime`, that look quite similar at a glance. They both have methods for dealing with dates and times. Which should you choose when you need to work with dates and times in Ruby?

> It's a common misconception that William Shakespeare and Miguel de Cervantes died on the same day in history - so much so that UNESCO named April 23 as World Book Day because of this fact. However, because England hadn't yet adopted the Gregorian Calendar Reform (and wouldn't until 1752) their deaths are actually 10 days apart. Since Ruby's `Time` class implements a proleptic Gregorian calendar and has no concept of calendar reform there's no way to express this with `Time` objects. This is where `DateTime` steps in:
>
>     shakespeare = DateTime.iso8601('1616-04-23', Date::ENGLAND)
>      #=> Tue, 23 Apr 1616 00:00:00 +0000
>     cervantes = DateTime.iso8601('1616-04-23', Date::ITALY)
>      #=> Sat, 23 Apr 1616 00:00:00 +0000
>
> Already you can see something is weird - the days of the week are different. Taking this further:
>
>     cervantes == shakespeare
>      #=> false
>     (shakespeare - cervantes).to_i
>      #=> 10
>
> This shows that in fact they died 10 days apart (in reality 11 days since Cervantes died a day earlier but was buried on the 23rd). We can see the actual date of Shakespeare's death by using the gregorian method to convert it:
>
>     shakespeare.gregorian
>      #=> Tue, 03 May 1616 00:00:00 +0000
> So there's an argument that all the celebrations that take place on the 23rd April in Stratford-upon-Avon are actually the wrong date since England is now using the Gregorian calendar. You can see why when we transition across the reform date boundary:
>
>     # start off with the anniversary of Shakespeare's birth in 1751
>     shakespeare = DateTime.iso8601('1751-04-23', Date::ENGLAND)
>      #=> Tue, 23 Apr 1751 00:00:00 +0000
>
>     # add 366 days since 1752 is a leap year and April 23 is after February 29
>     shakespeare + 366
>      #=> Thu, 23 Apr 1752 00:00:00 +0000
>
>     # add another 365 days to take us to the anniversary in 1753
>     shakespeare + 366 + 365
>      #=> Fri, 04 May 1753 00:00:00 +0000
>
> As you can see, if we're accurately tracking the number of solar years since Shakespeare's birthday then the correct anniversary date would be the 4th May and not the 23rd April.
>
> So when should you use DateTime in Ruby and when should you use Time? Almost certainly you'll want to use Time since your app is probably dealing with current dates and times. However, if you need to deal with dates and times in a historical context you'll want to use DateTime to avoid making the same mistakes as UNESCO. If you also have to deal with timezones then best of luck - just bear in mind that you'll probably be dealing with local solar times, since it wasn't until the 19th century that the introduction of the railways necessitated the need for Standard Time and eventually timezones.

From "[When should you use `DateTime` and when should you use `Time`?](https://ruby-doc.org/stdlib-2.7.0/libdoc/date/rdoc/DateTime.html#class-DateTime-label-When+should+you+use+DateTime+and+when+should+you+use+Time-3F)" in the Ruby stdlib `DateTime` documentation.

## Summary

- Use `Time` when dealing with near-past, present or future dates. It can technically represent dates from 1823-11-12 to 2116-02-20.
- Use `DateTime` when you want to accurately model distant past dates, like Shakespeare's birthday.
- So for most applications use `Time`.

[^1]: There are actually _two_ `Time` classes, one in core and one in the standard library which you get when you or one of your dependencies does a `require 'time'`.
