---
title: Using nokogiri with pry
layout: post
---

I wanted a quick way to run some XPath selectors against a web page today. [Nokogiri](http://www.nokogiri.org/) comes with a command line tool that you can pass a url and it will drop you into an IRB session. This allows you to play around with some Ruby code to explore a webpage before scraping it.

    nokogiri http://example.com

This is useful, but I wanted to use it with [Pry](http://pryrepl.org/). It turns out that adding support for Pry is relatively easy, but I couldn't find any clear top to bottom instructions, so I've documented the process below.

First install Nokogiri and Pry:

    gem install nokogiri pry

Then add the following code to `~/.nokogirirc`:

{% highlight ruby %}
require 'pry'
Nokogiri::CLI.console = Pry
{% endhighlight %}

That's it! Now when you use the `nokogiri` command line tool it will now drop you into a pry REPL. This is perfect for testing your CSS and XPath selectors when you're [writing a scraper](https://www.chrismytton.uk/2015/01/19/web-scraping-with-ruby/).

<noscript>
<a href="https://asciinema.org/a/88853" target="_blank"><img src="https://asciinema.org/a/88853.png" /></a>
</noscript>
<script type="text/javascript" src="https://asciinema.org/a/88853.js" id="asciicast-88853" async></script>
