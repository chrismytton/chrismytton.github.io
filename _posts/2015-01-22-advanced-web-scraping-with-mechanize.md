---
layout: post
title: Advanced web scraping with Mechanize
tags: [programming, scraping]
---

In my last post I gave a basic [introduction to web scraping with Ruby and Nokogiri][web-scraping]. At the end of that post I mentioned that for more "advanced" scraping Mechanize was worth looking into.

This post explains how to do some more advanced web scraping using Mechanize, which builds on top of Nokogiri's excellent HTML processing support.


## Scraping Pitchfork reviews

Mechanize provides an out-of-the-box scraping solution that can handle filling in forms, following links and respecting a site's robots.txt file. Here I'll show you how it can be used to scrape the latest reviews from [Pitchfork](http://pitchfork.com/) [^disclaimer].

[^disclaimer]: You should always scrape responsibly. Check out the [Is scraping legal?](https://blog.scraperwiki.com/2012/04/is-scraping-legal/) blog post from ScraperWiki for more discussion on the subject.

Reviews are spread across multiple pages, so we can't simply fetch a single page and parse it with Nokogiri. This is where Mechanize can help with its ability to click on links and follow them to other pages.

### Setup

First we'll need to install [Mechanize][] and its dependencies from Rubygems.

    $ gem install mechanize

With Mechanize installed we can now start writing our scraper. Create a file called `scraper.rb` and add the following `require` statements. These specify the dependencies we need for this script. `date` and `json` are part of Ruby's standard library, so there's no need to install them separately.

{% highlight ruby %}
require 'mechanize'
require 'date'
require 'json'
{% endhighlight %}

Now we can start using Mechanize. First thing we need to do is create a new instance of Mechanize (`agent`) and then use it to fetch a remote webpage (`page`).

{% highlight ruby %}
agent = Mechanize.new
page = agent.get("http://pitchfork.com/reviews/albums/")
{% endhighlight %}

### Find links to reviews

Now we can use the `page` object to find links to reviews. Mechanize provides a `.links_with` method which, as the name suggests, finds links with the given attributes. Here we look for links which match a regular expression.

This returns an array of links, but we only want links to reviews, not pagination. To remove unwanted links we can call `.reject` on the array of links and reject any which look like pagination links.

{% highlight ruby %}
review_links = page.links_with(href: %r{^/reviews/albums/\w+})

review_links = review_links.reject do |link|
  parent_classes = link.node.parent['class'].split
  parent_classes.any? { |p| %w[next-container page-number].include?(p) }
end
{% endhighlight %}

For the purposes of demonstration---and so we don't completely hammer Pitchfork's server's---we'll just take the first four review links.

{% highlight ruby %}
review_links = review_links[0...4]
{% endhighlight %}

### Process each review

We now have a list of Mechanize links which we want to map to the reviews that they link to. Since they're in an array we can call `.map` on it and return a hash from each iteration.

The Mechanize `page` object has a `.search` method which delegates to Nokogiri's `.search` method. This means that we can use a CSS selector as an argument to `.search` and it will return an array of matching elements.

Here we first get the review metadata using the CSS selector `#main .review-meta .info` and then search inside the `review_meta` element for the various bits of information that we need.

{% highlight ruby %}
reviews = review_links.map do |link|
  review = link.click
  review_meta = review.search('#main .review-meta .info')
  artist = review_meta.search('h1')[0].text
  album = review_meta.search('h2')[0].text
  label, year = review_meta.search('h3')[0].text.split(';').map(&:strip)
  reviewer = review_meta.search('h4 address')[0].text
  review_date = Date.parse(review_meta.search('.pub-date')[0].text)
  score = review_meta.search('.score').text.to_f
  {
    artist: artist,
    album: album,
    label: label,
    year: year,
    reviewer: reviewer,
    review_date: review_date,
    score: score
  }
end
{% endhighlight %}

Now we've got an array of review hashes we can output the reviews in JSON format.

{% highlight ruby %}
puts JSON.pretty_generate(reviews)
{% endhighlight %}

### All together now

Here's the whole script:

{% highlight ruby %}
require 'mechanize'
require 'date'
require 'json'

agent = Mechanize.new
page = agent.get("http://pitchfork.com/reviews/albums/")

review_links = page.links_with(href: %r{^/reviews/albums/\w+})

review_links = review_links.reject do |link|
  parent_classes = link.node.parent['class'].split
  parent_classes.any? { |p| %w[next-container page-number].include?(p) }
end

review_links = review_links[0...4]

reviews = review_links.map do |link|
  review = link.click
  review_meta = review.search('#main .review-meta .info')
  artist = review_meta.search('h1')[0].text
  album = review_meta.search('h2')[0].text
  label, year = review_meta.search('h3')[0].text.split(';').map(&:strip)
  reviewer = review_meta.search('h4 address')[0].text
  review_date = Date.parse(review_meta.search('.pub-date')[0].text)
  score = review_meta.search('.score').text.to_f
  {
    artist: artist,
    album: album,
    label: label,
    year: year,
    reviewer: reviewer,
    review_date: review_date,
    score: score
  }
end

puts JSON.pretty_generate(reviews)
{% endhighlight %}

Put this code in a file called `scraper.rb` and run it with the following.

    $ ruby scraper.rb

And it should output something like this:

{% highlight json %}
[
  {
    "artist": "Viet Cong",
    "album": "Viet Cong",
    "label": "Jagjaguwar",
    "year": "2015",
    "reviewer": "Ian Cohen",
    "review_date": "2015-01-22",
    "score": 8.5
  },
  {
    "artist": "Lupe Fiasco",
    "album": "Tetsuo & Youth",
    "label": "Atlantic / 1st and 15th",
    "year": "2015",
    "reviewer": "Jayson Greene",
    "review_date": "2015-01-22",
    "score": 7.2
  },
  {
    "artist": "The Go-Betweens",
    "album": "G Stands for Go-Betweens: Volume 1, 1978-1984",
    "label": "Domino",
    "year": "2015",
    "reviewer": "Douglas Wolk",
    "review_date": "2015-01-22",
    "score": 8.2
  },
  {
    "artist": "The Sidekicks",
    "album": "Runners in the Nerved World",
    "label": "Epitaph",
    "year": "2015",
    "reviewer": "Ian Cohen",
    "review_date": "2015-01-22",
    "score": 7.4
  }
]
{% endhighlight %}

If you want, you can save this JSON to a file by redirecting standard out to a file.

    $ ruby scraper.rb > reviews.json

## Conclusion

This only scratches the surface of Mechanize. One thing I haven't even touched on is it's ability to fill in and submit forms. If you're interested in learning more then I recommend you look at the [Mechanize guide][Mechanize] and [Mechanize examples](http://docs.seattlerb.org/mechanize/EXAMPLES_rdoc.html).

A lot of people commented that my [previous post][web-scraping] should have just used Mechanize from the off. While I agree that Mechanize is a great tool, for simple tasks like the one I presented, at the time it seemed to me like a bit of an overkill.

However on reflection the fact that [Mechanize][] handles fetching the remote webpage and respects robots.txt files makes me think that, even for non-advanced scraping tasks, Mechanize will often be the best tool for the job.

[web-scraping]: {% post_url 2015-01-19-web-scraping-with-ruby %}
[Mechanize]: http://docs.seattlerb.org/mechanize/GUIDE_rdoc.html
