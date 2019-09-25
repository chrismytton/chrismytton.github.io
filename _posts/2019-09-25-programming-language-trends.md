---
title: Programming language trends
layout: post
tags: [programming]
image: /assets/images/static-trees.jpg
---

Languages like Go, Rust, Swift and Typescript have all come onto the programming scene fairly recently, and they're all compiled and statically typed. What is it about compiled and statically typed languages that's making them so fashionable at the moment?

At least part of their popularity is due to their provenance. They've been created by some of the biggest tech companies today. Google (Go), Mozilla (Rust), Apple (Swift) and Microsoft (Typescript) are all solving problems that benefit from the extra speed and safety that you get from statically typed compiled languages. The companies realised early on that by releasing these languages as open source they can benefit from the community that builds around them, so they successfully marketed them to programmers. Now there's a network effect going on where the more these languages are used, the more useful open source code there is available for them, so the more useful they become, so more programmers use them, etc.

In the Stack Overflow Developer Survey 2019[^survey-2019] the most popular programming language is JavaScript, a dynamically typed interpreted language. But the most loved language was Rust. So why are people wanting to go back to compiled languages, aren't they really [slow to compile](https://xkcd.com/303/)? Well it turns out that advances in computer science mean we've now got significantly faster compilers, so there's not as much time spent waiting while code compiles compared to older compiled languages. In fact for small to medium size programs it can often feel like you are running an interpreted language the compilation step is so fast.

[^survey-2019]: [Stack Overflow Developer Survey Results 2019](https://insights.stackoverflow.com/survey/2019)

The preference for static typing in these languages must be driven at least in part by a desire to reduce the number of bugs encountered in production. In one study the use of static typing was shown to reduce the rate of bugs by 15%[^to-type-or-not-to-type], which is a big saving no matter what scale you operate on. The extra overhead of understanding and using a type system are outweighed by the benefits it provides. We all want fewer bugs in our code, after all.

Another nice benefit that a lot of compiled languages provide is simplified deployment. For languages like Go and Rust that output a single binary you easily deploy that binary to production and store previous versions for rollback etc. Contrast this with interpreted languages like Node.js and Ruby, where you need to have a copy of the whole source tree and the source of all the dependencies arranged appropriately on disk.

Most important of all these languages are fun to create software with. Compared to languages from the previous generation like C++ and Java, these new languages can be a joy to use, in no small part because they leave behind a whole raft of legacy cruft that older languages have to support.

This new generation of languages provide lots of benefits for the big tech companies behind them. By making them open source these companies have benefitted from the network effect as communities have sprung up around these languages creating and sharing useful code libraries. These languages are fun to write, fast to run and have the potential to uncover bugs earlier in the development process.

[^to-type-or-not-to-type]: Gao, Zheng, Christian Bird, and Earl T. Barr. ["To type or not to type: quantifying detectable bugs in JavaScript."](http://earlbarr.com/publications/typestudy.pdf) Proceedings of the 39th International Conference on Software Engineering. IEEE Press, 2017.
