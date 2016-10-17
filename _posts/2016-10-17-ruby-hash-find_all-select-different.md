---
title: In Ruby, &#35;find_all and &#35;select are different (for Hashes)
layout: post
---

In Ruby, [`Hash#select` returns a `Hash`](http://ruby-doc.org/core-2.3.1/Hash.html#method-i-select) whereas [`Hash#find_all` returns an `Array`](http://ruby-doc.org/core-2.3.1/Enumerable.html#method-i-find_all).

This is because Ruby's `Hash` class defines its own `#select` method, but inherits its `#find_all` method from the `Enumerable` module.

{% highlight ruby %}
# select returns a Hash
{ foo: 1, bar: 2 }.select { |key, value| value.even? }
# => { :bar => 2 }

# find_all returns an Array
{ foo: 1, bar: 2 }.find_all { |key, value| value.even? }
# => [[:bar, 2]]
{% endhighlight %}

For more details see [this StackOverflow answer](http://stackoverflow.com/a/21000136).
