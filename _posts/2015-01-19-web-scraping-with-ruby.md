---
layout: post
title: Web Scraping with Ruby
tags: [programming, scraping]
---

**Update Jan 22**: Check out the next post in this series: [Advanced web scraping with Mechanize]({% post_url 2015-01-22-advanced-web-scraping-with-mechanize %}).

Scraping the web with Ruby is easier than you might think. Let's start with a simple example, I want to get a nicely formatted JSON array of objects representing all the showings for my [local independent cinema][cubecinema].

First we need a way to download the html page that has all the listings on it. Ruby comes with an http client, `Net::HTTP`, and it also comes with a nice wrapper around it, `open-uri` [^open-uri]. So the first thing we do is grab the html from the remote server.

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

## Processing the html

Each showing has the class `.showing`, so we can select all the showings on the page and loop over them, processing each one in turn.

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

Lets break down the code above and see what each part is doing.

{% highlight ruby %}
showing_id = showing['id'].split('_').last.to_i
{% endhighlight %}

First we get the showing's unique id, which is helpfully exposed as part of the html id attribute in the markup. Using square brackets allows us to access attributes of the element, so using the html above as an example the return value of `showing['id']` would be `"event_7557"`. We're only interested in the integer id, so we split the resulting string on the underscore, `.split('_')` and then take the last element from that array and convert it to an integer, `.last.to_i`.

{% highlight ruby %}
tags = showing.css('.tags a').map { |tag| tag.text.strip }
{% endhighlight %}

Here we find all the tags for a showing by using the `.css` method, which returns an array of matching elements. We then map these elements and take the text content and strip it of any excess whitespace. For the html above this would return `["comedy", "dvd", "film"]`.

{% highlight ruby %}
title_el = showing.at_css('h1 a')
title_el.children.each { |c| c.remove if c.name == 'span' }
title = title_el.text.strip
{% endhighlight %}

The code to get the title is a bit more involved because the title element in the html contains some extra spans with a prefix and a suffix. First we get the title element using `.at_css`, which returns a single matching element. Then we loop over the children of the title element and remove any spans. Finally with the spans gone we get the text of the title element and strip out any excess whitespace.

{% highlight ruby %}
dates = showing.at_css('.start_and_pricing').inner_html.strip
dates = dates.split('<br>').map(&:strip).map { |d| DateTime.parse(d) }
{% endhighlight %}

This is the code for getting the date and time of a showing. It's a bit involved because a showing can be on multiple days, and sometimes there is also pricing information in the same element. We're mapping the dates that we find to `DateTime.parse` so that the result is an array of ruby `DateTime` objects.

{% highlight ruby %}
description = showing.at_css('.copy').text.gsub('[more...]', '').strip
{% endhighlight %}

Getting the description is quite straightforward, the only real processing we have to do is remove the `[more...]` text using `.gsub`.

{% highlight ruby %}
showings.push(
    id: showing_id,
    title: title,
    tags: tags,
    dates: dates,
    description: description
  )
{% endhighlight %}

With all the bits of the showing that we want in variables we can now push a hash representing the showing into our array of showings.

## Output JSON

Now we've processed each showing and we've got an array of showings we can convert the result to JSON.

{% highlight ruby %}
require 'json'

puts JSON.pretty_generate(showings)
{% endhighlight %}

This prints out the JSON encoded version of the showings, when running the script the output can be redirected to a file, or piped into another program for further processing.

## Putting it all together

With all the pieces in place we can now put the full version of the script together.

{% highlight ruby %}
require 'open-uri'
require 'nokogiri'
require 'json'

url = 'http://www.cubecinema.com/programme'
html = open(url)

doc = Nokogiri::HTML(html)
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

puts JSON.pretty_generate(showings)
{% endhighlight %}

If you save the above into a file called `scraper.rb` and run it with `ruby scraper.rb` then you should see the JSON representation of the events printed to stdout. It will look something like the following.

{% highlight json %}
[
  {
    "id": 7686,
    "title": "Harry Dean Stanton - Partly Fiction",
    "tags": [
      "dcp",
      "film",
      "ttt"
    ],
    "dates": [
      "2015-01-19T20:00:00+00:00",
      "2015-01-20T20:00:00+00:00"
    ],
    "description": "A mesmerizing, impressionistic portrait of the iconic actor in his intimate moments, with film clips from some of his 250 films and his own heart-breaking renditions of American folk songs. ..."
  },
  {
    "id": 7519,
    "title": "Bang the Bore Audiovisual Spectacle: VA AA LR + Stephen Cornford + Seth Cooke",
    "tags": [
      "music"
    ],
    "dates": [
      "2015-01-21T20:00:00+00:00"
    ],
    "description": "An evening of hacked TVs, 4 screen cinematic drone and electroacoustics. VAAALR: Vasco Alves, Adam Asnan and Louie Rice create spectacles using distress flares, C02 and junk electronics. Stephen Cornford: ..."
  }
]
{% endhighlight %}

And that's it! This is just a basic example of scraping. Things get a bit more complicated if the site you're scraping requires you to login first, for those instances I recommend looking into [mechanize][], which builds on top of Nokogiri.

Hopefully this introduction to scraping has given you some ideas for data that you want to turn into a more structured format using the scraping techniques described above.

[Nokogiri]: http://www.nokogiri.org/
[cubecinema]: http://www.cubecinema.com/programme
[mechanize]: http://docs.seattlerb.org/mechanize/GUIDE_rdoc.html

[^open-uri]: While good for basic tasks like this, open-uri has [some issues](https://bugs.ruby-lang.org/issues/3719) which mean you may want to look elsewhere for an http client to use in production.
