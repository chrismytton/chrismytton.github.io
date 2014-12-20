---
title: An introduction to node.js
layout: post
excerpt: I've only just got round to doing some coding with Ryan Dahl's great node.js project, although the project has been around for about a year now, so I've put together this short introduction to give you a taste of what node is about.
---

[node.js]: http://nodejs.org/
[nodesrc]: http://github.com/ry/node
[Homebrew]: http://github.com/mxcl/homebrew
[ry]: http://tinyclouds.org/
[CommonJS]: http://commonjs.org/
[apidocs]: http://nodejs.org/api.html
[express]: http://github.com/visionmedia/express
[node wiki]: http://wiki.github.com/ry/node/

> **Update**: The node.js api is in constant flux until it reaches a 1.0 release. The code in this post doesn't work with the latest releases of node (it was written for the 0.1.3x series), however the concept is still the same. The best place to start is the [node.js api docs][apidocs].

I've only just got round to doing some coding with [Ryan Dahl's][ry] great [node.js][] project, although the project has been
around for about a year now, so I've put together this short introduction to give you a taste of what node is about.

The project is under heavy development, and the api is still changing quite regularly, but don't let that scare you off, node is stable and usable now.

For those that don't know, [node.js][] is a project that brings javascript to the server and into the realm of PHP and Ruby. However with node there is one big difference. It is based around the concept of events, just like in the browser, javascript waits for events to be fired, then invokes the function that has been attached to the event.

Node uses this to it's full advantage, most operations that you perform in node will have a callback associated with it, this means that node doesn't have to wait while it's completing some time-consuming task, it can go about serving other requests, then when the event is fired it can go back and execute the function attached to the event. This leads to very fast response times when using node as a web server, as it can handle thousands of requests per second.

The program can be installed easily on OS X (using [Homebrew][] or compile from [source][nodesrc]) and Linux (compile from
[source][nodesrc]), Windows support is planned in the future, but is currently non-existent. Once installed you have access to a
command line utility, `node`, this runs .js files through the node interpreter.

A basic node hello world program could look like this:

{% highlight javascript %}
var sys = require('sys')

function sayHello (name) {
  return 'Hello ' + name + '!'
}

sys.puts(sayHello('World'))
{% endhighlight %}

save this into a file and then run it from the command line like so:

{% highlight bash %}
$ node hello.js
Hello World!
{% endhighlight %}

As you can see it's just javascript syntax, just like you would use in a browser, but the first difference the astute reader will
have noticed is the require() statement. This is built into node and conforms to the [CommonJS][] Module specification. This
version of require is slightly different from one you might see in Ruby or PHP, it actually returns an object which you can assign
to a variable, or use directly:

{% highlight javascript %}
require('sys').puts('Hello World!')
{% endhighlight %}

Each module is a self contained unit of code, it has its own private scope, so can define functions to use internally, then expose public functions to be used externally using the exports object. Here's an example of a simple module:

{% highlight javascript %}
var calculator = {
  add: function (a, b) {
    return a + b
  },
  subtract: function (a, b) {
    return a - b
  },
  multiply: function (a, b) {
    return a * b
  },
  divide: function (a, b) {
    return a / b
  }
}

process.mixin(exports, calculator)
{% endhighlight %}

The last line may seem a little strange, but all it does is extend the exports object with the properties defined in the calculator object, if that line wasn't there then the module wouldn't return anything as it wouldn't export anything. To use our new (rather basic) module we'd do something like this:

{% highlight javascript %}
// Assuming that calc.js is in the same dir as this file
var calc = require('./calc')

// Now we can use the calc object to do calculations, joy!
var ten = calc.add(3, 7)
var two = calc.subtract(5, 3)
{% endhighlight %}

This overview barely scratches the surface of what is possible with node.js, the [api documentation][apidocs] contains all you need to know about node, and it is all on one (albeit rather long) page, so once you've read through it you should have a pretty good idea how you'd go about coding for it.

There are already some very interesting projects using node available to try. A quick glance at the [node wiki][] will give you a glimpse of what is possible with this fantastic new technology, as well as some more background information on the project.
