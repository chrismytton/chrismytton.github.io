---
layout: post
title: Slow dotfiles
---

For a while now my shell has been taking a *very* long time to start up. It
wasn't so noticeable on more powerful machines, but on my late 2010
MacBook Air with "only" 2GB of RAM, it was very noticeable.

Last weekend I decided to finally sit down and figure out what was causing the
slow startup times. I stepped through the startup process in my [dotfiles][],
commenting out lines until it was fast again, it didn't take long to find
the offending line in my `zshrc`.

{% highlight bash %}
for module ($DOTFILES/**/*.zsh) source "$module"
{% endhighlight %}

This line uses shell globbing to load up all the files that end in `.zsh` in
the dotfiles repo, its pretty central to the way the dotfiles work, without
it no custom zsh scripts are loaded. So how could this line be causing such
a slow startup?

The way [globbing][] works is it expands the pattern into a list of
files. In this case it checks all the files in the dotfiles directory to
see if they end with `.zsh`.

This shouldn't be a problem, but I had configured my vim plugins
to be installed into a directory within the dotfiles repo, which had its
contents gitignored, you can see [the commit][] on GitHub. This meant I
could install vim plugins without having to track them in the repo. So
the shell globbing was checking all of the files in the vim plugins as
well as the dotfiles.

To solve this problem I spent an hour removing my vim configuration from my dotfiles and putting it
into its [own repository][dotvim]. I'd wanted to do this for a while anyway because I found myself
changing my vim configuration a lot more than anything else in the dotfiles.

I made this change on my faster work laptop, which doesn't suffer as much with the
slow startup. When I got round to pulling the
changes down to my Air the difference was *very* noticable, new
shells pop into existance in under a second, like they should.

It's been 6 months since I made the commit which began the slowdown. I've been putting up with
slow shell startups for all that time, when actually it only took a
couple of hours in total to identify and fix the problem.

So don't be like me and ignore performance problems when you know
they're there, take the time to fix them

[dotfiles]: https://github.com/hecticjeff/dotfiles
[globbing]: http://en.wikipedia.org/wiki/Glob_(programming)
[the commit]: https://github.com/hecticjeff/dotfiles/commit/5c497a86f3535bad6c31a93a617598879fc9cd58
[dotvim]: https://github.com/hecticjeff/dotvim
