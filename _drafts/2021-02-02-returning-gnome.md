---
layout: post
title: "My Linux story - returning GNOME?"
categories:
  - article
tags:
  - Distros
  - FOSS
---

I'm going to start by telling you how this story ends: I'm switching to the
GNOME desktop environment after leaving it nearly ten years ago. To explain
why, I need to provide a bit of history, and talk about curry.

In my early twenties, my social life tended to follow a familiar pattern -
ending the week with a couple of beers and a few mates in the pub until closing
time, then heading to one of the nearby Indian restaurants for a curry. After a
while, you notice the different kinds of curry consumer: first, the predictable
guy. He knows what he likes, and he gets it every time. If he's in the toilet
when the waiter comes, you could reliably order for him. Some may say he's
boring, but there's a certain pleasure in knowing your favourite, and avoiding
potential disappointment of ordering something else that isn't as nice. The
second kind of person is the adventurous type: they tend to choose something
different each time, perhaps asking if there's any specials. Some of their
pleasure comes from the novelty and excitement of trying something new or
different, even if objectively, it isn't as good as a particular dish they had
a few weeks prior.
I'm closer to the first type of person, but I tend to have a "current
favourite". I have a few favoured dishes, but I'll tend to stick to one over a
long period, perhaps having the same dish for most of the year, without varying
too much, then I might discover a new favourite, usually based on
recommendation from someone else, or if I can't have my current favourite for
some reason. I'm similar with holiday destinations too. We have a few favourite
places that we like to go to, that we are able to make the most of, since we
know the area well. If our favoured location isn't available, it's not the end
of the world, and sometimes presents an opportunity to try a new place.

I've been using desktop Linux for about 15 years, and my choice of desktop is
similar to my curry choice. I know what I like and tend to use it for a few
years, but occasionally I'm prompted to switch to something similar, but more
suiting my slowly evolving taste.

I first used Linux in around 1998. Having used SunOS and Solaris for a few
years, I booted RedHat on a spare PC at work, and was presented with a
bewildering range of tools and applications, quite exciting, if a bit rough
round the edges. Over subsequent years, Linux began to make in-roads into the
rack space previously occupied by Sun machines in the server room, but I
continued using Windows on the desktop at home and in the office, due to
hardware compatibility and application availability.

It wasn't until around 2004 that I began to use Linux as a desktop Operating
System. I had acquired a few machines from my employer after they had closed
their doors, and I now had the opportunity to learn a bit, without breaking the
main PC I used for internet browsing (still during the dial-up modem days), and
video/photography editing. Due to my familiarity with Red Hat, I installed
Fedora Core 3 on my newly-acquired PC for a bit of continuity, but soon moved
to Ubuntu because I was struggling to obtain the correct dependencies to
compile a particular application called Alexandria. I asked for help on the
mailing list, and the developers said they were all using this new distro
called Ubuntu, so I tried that instead, purely to get this application working
that I'd wasted a week fumbling around unsuccessfully with Fedora.
I've pretty much stuck with Ubuntu, or its variants, as my favoured Linux
desktop OS ever since. I hardly even used the app that brought me there.

In 2006, compiz was released: the heyday of desktop bling. Spinning desktop
cubes, wobbly windows and outrageous effects were all the rage, and I
was loving it. It was, however, a good opportunity to break your system, and
much of the software was very alpha-quality. I tinkered with any new tool or
plugin I'd seen on Digg, while keeping my Windows OS for stable usage, ironically.
At work, I used 2 PCs on my desk, connected with the Synergy app to avoid
having 2 keyboards. Windows on the left, Kubuntu on the right, with a brushed
metal Apple ripoff theme, mocked up to [look like
Apple](http://baghira.sourceforge.net/OS_Clone-en.php). Hey, I thought it was cool
at the time.

![Compiz](/assets/images/compiz.png){: .centre-image width="600px"}

{: .image-caption}
*A typical compiz setup from 2007 (Wikipedia)*

I started a new job in 2009, and my journey to Linux exclusivity on the desktop
was complete. Much as I'd liked KDE3 (I even had a Kubuntu t-shirt), the
newly-released KDE4 was a disappointment, and still half-baked. I tried, but I
couldn't get on with it, from a usability and workflow perspective. I installed
GNOME on my main work PC, and found that, along with Gnome Do and Docky, I was
extremely comfortable and productive, on a stable platform.

The advent of GNOME 3 was a real disappointment. I had a desktop
environment that was working so well for me, and the new GNOME was such a big
shift. This triggered a year of distro-hopping, as I searched for something
that gave me a similar workflow. I didn't find it, but flirted with Cinnamon
desktop for a while, without quite being satisfied. However, elementary
fulfilled my needs, as it provided a very similar workflow to my favoured GNOME
2 + docky setup, with very little tweaking required.

I've been on elementary ever since, on my always-on work desktop PC, and also
laptops at home and work. I do usually get a bit of an itch during the gap
between the Ubuntu LTS release, and a subsequent elementary release. Elementary
doesn't support in-place upgrades, and this causes me to consider carefully
each time whether to commit for the next couple of years at least.

![Elementary](/assets/images/elementary-screenshot.png){: .centre-image width="600px"}

{: .image-caption}
*Elementary desktop*

So what's changed now? A couple of things. During the 2020 Pandemic, I've
worked from home, and I've had a few annoyances with using Zoom and OBS on
multi-monitor setup. Enough of an annoyance that family members have to call
me into the room when the issue occurs. I also have issues reliably switching
between audio devices. I've had weird behaviour with saving files from snapped
applications. I put up with these problems, because I assume all distros have
their little bugs. But I have a new desktop PC which needs an Operating System,
and I'm not feeling inclined to install the current elementary, knowing that the next
release is probably only a few months away, but I'll likely have
to do a fresh install to get it, and will it even resolve my bugs? Also,
elementary is heading toward flatpak support rather than snap, and as someone
who is increasingly using snap for larger applications like kdenlive, audacity,
OBS and teams, I'm reliant on good support for their use. So I found
myself checking out the latest Ubuntu release, with the plan that if I can get
it working the way I like it, and there's no showstopper bugs, then I'll stick
around. I like the idea that I'm using the same distro that a large part of the
community is using - I think that raising a bug against an application carries
more weight if it's reproducible on stock Ubuntu.

I should add that I also tried the Deepin desktop environment on top of Ubuntu.
I LOVE the aesthetic. It's beautiful. So why isn't this a Deepin love letter?
Frankly, I got nervous. Not about the usual trope of not trusting Chinese-made
software, but of having a kernel module used for file search; of the bug
reports showing a rather naive approach to Linux security. Rightfully nervous
of using an unofficial PPA to install it on Ubuntu. And it felt a little
sluggish on my PC, with busy i/o a lot of the time. Full marks for aesthetic
design though, and I hope other distros take a look at the best dock and
application menu out there, and the other slick parts of the OS.

![Deepin](/assets/images/deepin.png){: .centre-image width="600px"}

{: .image-caption}
*Trying out Deepin*

I also needed to install a fresh OS on the wife's laptop, as I had recently
purchased an SSD for it. With agreement, I put
stock Ubuntu on it too, with a couple of GNOME extensions. After copying the
data back onto it and handing it back the same day, I haven't had any questions
at all about it in the following month. Pending any major issues, I am going to
do something similar for my work laptop as soon as I get the opportunity. I
haven't quite decided about the performance, as I haven't been able to compare
before-and-after on the same hardware. I've noticed an issue with Zoom crashing
occasionally, especially when switching to breakout rooms or starting calls.
It's rather annoying, and with proprietary software where the source code and
the issue tickets are both closed, it's hard to tell if this
is a widespread issue, or specific to multi-monitor setups, or something else.

![Gnome](/assets/images/gnome.png){: .centre-image width="600px"}

{: .image-caption}
*Gnome desktop*

All in all, I'm enjoying being back on stock, or at least something close to
it. After getting over some initial frustrations regarding GNOME extension
installation and finding decent extensions, I have a setup I'm happy with. This
definitely isn't about distro wars, or "my distro is the best and you
should agree". Different strokes and all that. There was really nothing wrong
with elementary; I love it - but sometimes it just takes a nudge at the right
moment to try something other than your long-term favourite, and maybe I've
found a new one.

Had a similar, or wildly different experience? Let me know on
[Mastodon](https://fosstodon.org/@simon).
