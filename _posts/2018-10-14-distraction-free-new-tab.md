---
title: Distraction-free new tab
layout: post
image: /img/distraction-free-new-tab.png
---

The web is full of distractions: adverts, news, social media, email. It can sometimes be hard to remember why you opened the browser in the first place. Even opening a new tab is distracting. You see bookmarks, a search box and frequently visited sites before you've even begun the task you went on the web for.

I wanted to go back to the days where you could have "about:blank" as your new tab and it would show you a plain white page. Like a fresh sheet of paper waiting for you to write on.

If you use Firefox or Safari then you can go into the settings and select "Blank Page" (Firefox) or "Empty Page" (Safari) and that's it, job done. But Google Chrome doesn't let you do that. Instead you have to use an extension.

I tried some of the existing extensions, but they turned out to be _too_ blank. They didn't feel like native tabs. There were two features in particular that I wanted but none of the existing extensions offered.

1. Background colour should be the same off-white as other Chrome screens such as "Settings" and "Extensions".
2. It should have the same title as the default new tab, i.e. "New tab", rather than "chrome://newtab".

There was no alternative, I was going to have to create my own blank new tab extension. As a bonus writing my own extension meant I didn't have to worry about scammers taking over one of the other "blank new tab" extensions and mining bitcoin in my browser. [^1]

[![](/img/distraction-free-new-tab.png)](/img/distraction-free-new-tab.png)

The extension is two lines of HTML and the required `manifest.json` file. The code is open source, so you can review it and check I'm not mining bitcoin in your browser.

Get the code [on GitHub](https://github.com/chrismytton/blanktab) and enjoy a less distracting web.

[^1]: "Do you use a popular browser extension? How confident are you that the creator wouldn’t accept a $10k offer to hand it over only to have it then go rogue on you?" [@troyhunt on Twitter](https://twitter.com/troyhunt/status/1037457241840877568)
