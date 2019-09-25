---
title: Programming language trends
layout: post
tags: [programming]
image: /assets/images/static-trees.jpg
---

There seems to be a trend towards programming languages that are compiled and statically typed at the moment. Languages like Typescript, Go, Rust and Swift have all come onto the scene fairly recently, and they're all compiled and statically typed.

I think this is partly because the companies behind them are writing languages that are being used at a huge scale. Microsoft (Typescript), Google (Go), Mozilla (Rust) and Apple (Swift) are all solving problems that require the extra speed and safety that you get from statically typed compiled languages.

Previously the argument against compiled languages was that they were [slow to compile](https://xkcd.com/303/). Advances in computer science mean we've now got faster compilers, so there's not as much time spent waiting while code compiles compared to older compiled languages. In fact for small to medium size programs it can often feel like you are running an interpreted language the compilation step is so fast.

The preference for static typing in these languages must be driven at least in part by a desire to reduce the number of bugs encountered in production. In one study the use of static typing was shown to reduce the rate of bugs by 15%[^to-type-or-not-to-type], which is a big saving no matter what scale you operate on. The extra overhead of understanding and using a type system are outweighed by the benefits it provides. We all want fewer bugs in our code, after all.

Another nice benefit that a lot of compiled languages provide is simplified deployment. For languages like Go and Rust that output a single binary you easily deploy that binary to production and store previous versions for rollback etc. Contrast this with interpreted languages like Node.js and Ruby, where you need to have a copy of the whole source tree and the source of all the dependencies arranged appropriately on disk.

Most important of all these languages are fun to create software with. Compared to languages from the previous generation like C++ and Java, these new languages can be a joy to use, in no small part because they leave behind a whole raft of legacy cruft that older languages have to support.

[^to-type-or-not-to-type]: Gao, Zheng, Christian Bird, and Earl T. Barr. ["To type or not to type: quantifying detectable bugs in JavaScript."](http://earlbarr.com/publications/typestudy.pdf) Proceedings of the 39th International Conference on Software Engineering. IEEE Press, 2017.
