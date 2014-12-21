---
layout: post
title: Testing morph.io scrapers with Docker
---

Morph.io is built on top of docker. You can test your scrapers using the same environment by using docker locally.

    $ docker run -it --rm -v "$(pwd)":/repo openaustralia/morph-ruby
