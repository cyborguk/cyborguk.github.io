---
layout: post
title: "The unhelpful error"
categories:
  - article
tags:
  - FOSS
  - Sysadmin
---

Errors are annoying, but more annoying are errors that trick you into wasting a
day going round in circles and questioning your sanity.

It all started with an error message:

```
error while loading shared libraries: libQt5Core.so.5: 
cannot open shared object file: No such file or directory
```

I had been trying to install a new version of some science-ware application.
Compared to other 20-year-old scientific applications, at least this is open
source, and free from weird and unnecessary licencing constraints. Also, they
are hosted on GitHub now, rather than some antiquated version control system
nobody else uses. It has a lot going for it, despite a few quirks of
installation, and the fact that I don't know how to use it.

It's also a graphical application for visualisation of large datasets, so rather
than install a load of X-window and dependencies into our environment, I'm
installing the application and pre-requisite packages into a container.

The software had received a major version upgrade since I last installed it
in 2018. After refreshing my container recipe, I built a new container, ran it,
but received the aforementioned error message.

Immediately my thoughts went to missing Qt libraries in my container or missing paths. I reached
out to a few virtual buddies in my favourite telegram group, and received some
helpful suggestions. I went back to square one, making sure I'd followed the
instructions correctly. The installation comes in the form of a tarball which
you extract, and then run an install script. On closer inspection, the required
Qt libraries were provided in the tarball, so this didn't appear to be a lack
of Qt package in my container. Meanwhile I had rebuilt the container a few
times by now, using a variety of different supported Ubuntu and CentOS base
containers.

Admittedly, troubleshooting containers is a bit more tricky than using the
native OS, but it also has benefits that you can blow away your failed effort
and retry with only 1 thing changed, without polluting your system in the
process.

I had to join a meeting, which gave me some reflection time, thinking about
`ldd` and `$LD_LIBRARY_PATH`. I've worked with this stuff for years, and I
thought I knew what the error meant, that the library couldn't be found in the
system. It felt like I was being trolled. 

I had been doing some other background tasks in the meantime, to remain
productive while I churned over this issue in my mind, or while I waited for
containers to build. I had done a fair few internet searches, but still only in
a general way, because I still didn't know if this was specific to the
application, or to this version of the application, or something else. 

Finally, I had a breakthrough. Searching for the specific Qt5 error produced a
lot of noise, but I noticed something I had seen earlier in the day when the issue
was more nebulous in my mind. By now I believed that my paths were correct, and
I had installed the application correctly, so I took a bit more interest when I
saw: 

> "The kernel needs to be at least 3.15 for a very real but (to me) esoteric
> reason: "Qt 5.10 uses the [renameat2](https://man7.org/linux/man-pages/man2/rename.2.html)
> system call which is only available since kernel 3.15" on
> [this page](https://itectec.com/ubuntu/ubuntu-ubuntu-18-4-libqt5core-so-5-cannot-open-shared-object-file-no-such-file-or-directory/).

Although I was running newer distros in my containers, the underlying operating
system was CentOS 7, and hence an older kernel. 

This felt like a million miles from what the error message had told me.

But as soon as I saw this, I knew it was the fix. I had to use the `strip`
command to remove a piece of code that is only supported in later kernels. And
it worked. I don't feel altogether comfortable with this kind of kludge in a
production environment, even if user testing is successful. However, at last
the mystery is solved. I lost a few hours on this rather niche issue, but it's
all good experience and I'm always learning!
