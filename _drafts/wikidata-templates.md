---
title: Wikidata templates
layout: post
---

What's the best way to configure an application that uses Wikidata as its primary interface?

As part of the work I've been doing on [The Democratic Commons](https://www.mysociety.org/democracy/democratic-commons/) I've helped create a few applications that use Wikidata as their primary interface.

This is often done by having a template that users can include on a page, which then show instructions for setting up the application. These applications generally need to be passed some parameters so that they have some input to work with and do something interesting, sometimes this is a simple Wikidata ID, or it can be more complex things like a URL or a SPARQL query.

There are currently two approaches to configuring applications like this that I've see in the wild:

1. Parse the parameters out of the template tag using regular expressions, this is what [Listeria](https://www.wikidata.org/wiki/Template:Wikidata_list) does.
2. Use subpages for configuration items, which is the approach we took with out [Compare CSV with Wikidata](https://www.wikidata.org/wiki/Template:Compare_Wikidata_with_CSV) application.

## Parsing parameters

### Advantages

- Simple, all the configuration is in one place
- Easier to understand

### Disadvantages

- Currently we use regular expressions to parse template parameters, which is a bit fragile. This could potentially be improved if we used a proper parser, but that would add a lot of complexity
- Can't embed templates in templates, so can't easily use a template to generate a URL, for example.


## Using subpages

Advantages and disadvantages of each

What situations to use each one in

