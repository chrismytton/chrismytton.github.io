---
layout: post
title: Raspberry Pi GPIO Hacking
tags: [hardware, programming]
---

I've been playing with my [Raspberry Pi starter kit][0] today. It comes with a clear plastic case for mounting the Pi onto, but as I've already got a case I'm just using the breadboard and the components that were supplied with the kit. As well as the breadboard the kit includes the following components:

* 12 &times; LEDs (4 each of Red, Yellow and Green)
* 12 &times; 330&Omega; resistors (for the LEDs)
* 2 &times; 10k&Omega; resistors
* 2 &times; mini push buttons
* 10 &times; male to female jumper wires

The example I was following is for a [simple traffic lights system][1].
The hardware components are wired into the Raspberry Pi board using its
[GPIO pins][2]. These General Purpose Input Output pins can be
controlled using software so they provide a simple way to connect to
external hardware to the Pi.

> In addition to the familiar USB, Ethernet and HDMI ports, the R-Pi
> offers lower-level interfaces intended to connect more directly with
> chips and subsystem modules.
> <small><a href="http://elinux.org/RPi_Low-level_peripherals#Introduction">RPi Low-level peripherals introduction</a></small>

Once I got the traffic lights wired up and working I started hacking
on the software side of things. The [example python code][4] didn't cleanup
the GPIO when I pressed `ctrl-c`, so the lights remained in the position
they were in when I interrupted the process. To fix this I [installed a
signal handler][3] to run the GPIO cleanup code and exit cleanly.

{% highlight python %}
def cleanup_gpio(signal, frame):
    print
    GPIO.cleanup()
    sys.exit(0)

# Install signal handler to cleanup GPIO when user sends SIGINT
signal.signal(signal.SIGINT, cleanup_gpio)
{% endhighlight %}

![Raspberry Pi plugged into breadboard](https://s3-eu-west-1.amazonaws.com/img.hecticjeff.net/rpi-20121230-221554.jpg)

The code I've been tinkering with is [on
GitHub](https://github.com/chrismytton/rpi-traffic_lights). This includes the example
C code, which is pretty much untouched other than adding a limit to the
number of loops so that the GPIO cleanup code gets run. There's also the
example python code which is what I've mainly been playing with.

There is a [disco.py][5] file in the repository that flashes the lights in
sequence which is essentially a modified version of the traffic lights script.

For my first attempt at Raspberry Pi hacking this was very successful,
it's a real buzz to see hardware and software coming together in
something of your own making.

The next stage of this project will involve linking this traffic light
system into a web service to create a status indicator.

[0]: http://www.skpang.co.uk/catalog/starter-kita-for-raspberry-pi-pi-not-include-p-1070.html
[1]: http://www.skpang.co.uk/blog/archives/656
[2]: http://elinux.org/RPi_Low-level_peripherals#General_Purpose_Input.2FOutput_.28GPIO.29
[3]: https://github.com/chrismytton/rpi-traffic_lights/blob/a6fba162d11679bd3daaeb9a8adca2b223092152/traffic_light_rev_2.py#L34-L42
[4]: http://skpang.co.uk/dl/traffic_light_rev_2.py
[5]: https://github.com/chrismytton/rpi-traffic_lights/blob/a6fba162d11679bd3daaeb9a8adca2b223092152/disco.py
