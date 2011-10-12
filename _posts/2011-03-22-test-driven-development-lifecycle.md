---
title: Test Driven Development Lifecycle
layout: post
---

Start at the top level with a user requirement. This will ensure that
you are trying to solve the right problem in the first place.

## Cucumber / Steak

Write a simple high level requirement in cucumber or steak. For example
if you were writing an api and you wanted to allow people to post
activity.

First you would write out the requirement in plain english.

{% highlight gherkin %}
Feature: Creating activity
  As an activity producer
  I want to post activity to the api
  In order to share it with the world

  Scenario: POST to /activity
    Given I am an authorized activity producer
    When I post some activity
    I should receive a 200 success status
{% endhighlight %}

This defines the high level picture of what the application aims to
achieve. From this point the next step is to write some steps to
properly test that the features are working.

Obviously the features won't be working yet, because that's not how
test/behaviour/real-world driven development works. If you start writing
code before you really know what you are building, then it is likely
that you will at some point, perhaps without realising, implement the
wrong feature. More likely though, being that smart martin that you
are, you will implement the correct feature, but unwittingly leave a bug
in it. No harm, you say, bugs happen in software and it's probably only
one line of code that needs changing. But if the bug doesn't manifest
itself for a few days, weeks, months, then it will take an ever
increasing amount of time for you to track it down. Then once you have
isolated it, you have to ensure it won't happen again.

This all comes down to testing. If you can easily run a bank of tests
that confirm that your application is behaving at night you will,
infact, sleep better at night. For some this is reason enough to write
tests, but wait, there's more. If you have a comprehensive collection of
tests you can use to verify that your application is working correctly,
then you are in a very good position to do some refactoring. No more
worrying if you've broken some seemingly unrelated piece of
functionality when you make a change to the application.

## Controller tests

The next layer down the stack is the controller, this makes sense, since
this is the layer that manages incoming requests. So after writing the
initial acceptance test in a high level language, then implementing the
steps necessary to test this logic in a slightly lower level language,
you now drop down to a relativly granular level. This is where you start
to stub out the main functionality of the application. So in the case of
our activity example above, you would at this stage be stubbing out the
functionality of the models, and just dealong with the way that
controllers handle requests.

This layer may be preceeded by another, slightly higher level one in
which the routing for the application is set up, however this is quite a
web application specific area.

## Model tests

The model tests are the core of the testing universe, they are very
small, low level details about the various methods that a model
provides.

The model tests are the most important tests, as they contain the
business logic for your application. But they are often also the easiest
tests to write. This is because a lot of the time you will be dealing
with primitive data types. No external services to worry about. This is
a good reason to push as much logic into the model as possible, it is
far easier to test this that it is to put it in your controller then try
to stub it out.

## Other tests

All of this testing malarkey is great and everything, but sometimes you
have got to just use the product to uncover random bugs, but don't
worry, that's not to say we can't still use testing to help us. Instead
of jumping right in and fixing that bug like a good boy scout
hacker, write a failing test that reproduces the bug. This test may
exists as (m)any layer(s) of the test stack. Often you will need to
write a test in the acceptance layer to perform the same interaction
that caused the bug, then once that has caught the bug, go down the
layers and write tests for the code paths that the bug touches, these
failing tests will then (all going to plan) be green once you have fixed
the bug, and as a billy bonus you've got yourself another test or two
that will ensure many good nights sleep in the future.

## Final thoughts

The testing pattern of development is still not used as a default
development technique. Many (most) tutorials you find out there will
focus on the functionality that they are trying to tutor you on, but a
vital part of implementing any functionality is to ensure a long
lifespan by testing it thoroughly.

Testing will seem like a chore at first, but once you get the hang of
it, the whole process becomes a pattern, that if followed with a small
bit of dicipline, will lead you to enlightenment, it will allow you to
model your ideas with more structure with the tools available.

In many ways it's like learning a new language, with more languages, you
see more ways of doing things. With testing, you'll see new ways to
express your applications logic using high level language.
