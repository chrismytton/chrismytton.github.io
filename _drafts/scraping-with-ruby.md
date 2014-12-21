---
layout: post
title: Scraping with Ruby
---

Scraping the web with Ruby is easier than you might think. Let's start with a simple example, I want to get a nicely formatted JSON object representing all the listing for my local independent cinema.

First we need a way to download the html page that has all the listings on it. Ruby comes with an http client, `Net::HTTP`, and it also comes with a nice wrapper around it, `open-uri`. So the first thing we do is grab the html from the remote server.

{% highlight ruby %}
require 'open-uri'

url = 'http://www.cubecinema.com/programme'
html = open(url)
{% endhighlight %}

Great, so we've got the page that we want to scrape, now we need to extract some information from it. The best tool for this job is [Nokogiri][]. So we create a new Nokogiri instance using the html we just scraped.

{% highlight ruby %}
require 'nokogiri'

doc = Nokogiri::HTML(html)
{% endhighlight %}

Nokogiri is great because it allows us to query the html using CSS selectors, which, in my opinion, is much simpler than using xpath.

Ok, now we've got a document that we can query for the cinema listings. Each individual listing's html structure is something like the following.

{% highlight html %}
<div class="showing" id="event_7557">
  <a href="/programme/event/live-stand-up-monty-python-and-the-holy-grail,7557/">
    <img src="/media/diary/thumbnails/montypython2_1.png.500x300_q85_background-%23FFFFFF_crop-smart.jpg" alt="Picture for event Live stand up + Monty Python and the Holy Grail">
  </a>
  <span class="tags"><a href="/programme/view/comedy/" class="tag_comedy">comedy</a> <a href="/programme/view/dvd/" class="tag_dvd">dvd</a> <a href="/programme/view/film/" class="tag_film">film</a> </span>
  <h1>
    <a href="/programme/event/live-stand-up-monty-python-and-the-holy-grail,7557/">
      <span class="pre_title">Comedy Combo presents</span>
      Live stand up + Monty Python and the Holy Grail
      <span class="post_title">Rare screening from 35mm!</span>
    </a>
  </h1>
  <div class="event_details">
    <p class="start_and_pricing">
      Sat 20 December | 19:30
      <br>
    </p>
    <p class="copy">Brave (and not so brave) Knights of the Round Table! Gain shelter from the vicious chicken of Bristol as we gather to bear witness to this 100% factually accurate retelling ... [<a class="more" href="/programme/event/live-stand-up-monty-python-and-the-holy-grail,7557/">more...</a>]</p>
  </div>
</div>
{% endhighlight %}

Each showing has the class `.showing`, so we can select all the showings on the page and loop over them, processing each one in turn.

{% highlight ruby %}
showings = []
doc.css('.showing').each do |showing|
  # Process each showing in turn
end
{% endhighlight %}

Next we need to extract the other information about each showing.

{% highlight ruby %}
showings = []
doc.css('.showing').each do |showing|
  showing_id = showing['id'].split('_').last.to_i
  tags = showing.css('.tags a').map { |tag| tag.text.strip }
  title_el = showing.at_css('h1 a')
  title_el.children.each { |c| c.remove if c.name == 'span' }
  title = title_el.text.strip
  dates = showing.at_css('.start_and_pricing').inner_html.strip
  dates = dates.split('<br>').map(&:strip).map { |d| DateTime.parse(d) }
  description = showing.at_css('.copy').text.gsub('[more...]', '').strip
  showings.push(
    id: showing_id,
    title: title,
    tags: tags,
    dates: dates,
    description: description
  )
end
{% endhighlight %}

[Nokogiri]: http://www.nokogiri.org/
