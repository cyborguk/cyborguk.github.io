--- 
layout: post 
title: Choosing a new bookmarking/read later service
categories:
  - article 
tags:
  - productivity
  - self-hosted
---

I used the Mozilla Pocket service until recently. I had a few hundred bookmarks,
mainly work-related articles, recipes and decent articles I wanted to keep for future reference. For some reason, while I bookmark stuff in Firefox, I have a bunch of common sites on the bookmark toolbar but never delve into my stored bookmarks. Out of site and out of mind, and also I might remember the content of the page but not the title, in which case, a bookmark doesn't help, and I rely on browser history and resort to a search engine again.

When I used Pocket, the one-click integration and easy tagging within Firefox worked nicely, and I was generally happy. I even liked the selection of popular articles Firefox would display on the new tab screen by default.

When Mozilla announced they were terminating Pocket, I decided to look at the alternatives. I've mentioned previously that I use ArchiveBox as a self-hosted internet archive as an insurance against link-rot. My use case for a bookmarking system is a little different - primarily to keep collections of useful sites that I will need to refer to now and again, but I'm open to using a combined bookmarking plus archive solution if all my needs were met.

## Wallabag

[Wallabag](https://wallabag.it/en/) was the first solution I looked at, since it was recommended by some contented users on various fediverse threads, following the Mozilla Pocket announcement. It's a hosted, paid service that also allow self-hosting due to the FOSS-licenced code. In particular I was interested to see that with a little extra work, I could send epubs to a Kobo reader.

I have a couple of low-powered Wyse 5070 boxes for self-hosted solutions and try to use docker where possible to deploy a new service in order to avoid polluting my system with too many packages, and containers also add the possibility to bring a service up easily on another server.

After reading documentation/blogs and watching some YouTube videos, I eagerly set about installing Wallabag via Docker using their [docs](https://github.com/wallabag/docker). Unfortunately I had a few issues. The blogs I'd seen had mainly used the `apt install` method, and it made me wonder about the efficacy of the Docker method.

My first concern was all the warnings I saw when bringing up the container.

![](/assets/images/walla-warnings.jpg)

{: .image-caption}
*Warnings about abandoned packages made me worry*

The container didn't come up successfully for another reason and I still needed to play around a bit. I hoped the effort would be worth it.

![](/assets/images/walla-oof.jpg)

{: .image-caption}
*Something aint right*

After some fruitless searching, I left my workstation for a while and cooked dinner for the family. I returned with renewed vigour and inspiration and found [this](https://github.com/wallabag/wallabag/issues/7953) issue that suggested using IP address in my config instead of localhost caused the page to load correctly.

![](/assets/images/walla-working.jpg)

{: .image-caption}
*Et voila, working wallabag*

I also experienced several serious errors while attempting to import bookmarks from Pocket. One of those was a PHP memory limit which I needed to set very high, even for my small set of bookmarks.  There are several recent Github issues and it seems that fixes are being worked on for most of my issues.

After all this, I had a working installation, but the experience had left a sour taste. Should I be worried about all those abandoned packages in the Docker deployment process and the bookmark import issues, suggesting a rather over-engineered solution for my self-hosted use case?

I'm sure that the most (particularly non-Docker) users have had a much smoother experience, but I got off on the bad foot and while I was evaluating one service, I thought I'd also try the other bookmarking service that I'd heard about, namely Karakeep.

**Things I liked about wallabag**: decent UI, ability to send articles to an e-reader, optional centrally hosted service available

**Things I didn't like**: as the ultimate administrator of the system, I was put off by the bugs and issues I experienced, and the more heavyweight requirements (mysql instead of sqlite, etc) perhaps suggest this is service designed for a larger scale than my lightweight needs.

## Karakeep

[Karakeep](https://karakeep.app) has recently been renamed from Hoarder because someone with a similar-named app was causing trouble, and life's too short for that kind of hassle. Karakeep certainly performs better in SEO ranking than a common word, but since the name change is so recent, most blogs and Youtube videos still refer to the less distinctive old name. Even the Firefox extension still used the old name in one of the notifications I saw.

I was able to deploy a container in a few minutes using the [Docker compose file](https://docs.karakeep.app/Installation/docker/).

![](/assets/images/karakeep-1.png)

{: .image-caption}
*So far, so good*

Like Wallabag, Karakeep has a browser extension to allow bookmarking with a single click. It also has an extensive import/export section to allow Picker/Linkwarden and Tab Session Manager bookmarks to be imported, as well as the Karakeep exports for backup/migration purposes.

It was lacking the epub functionality for reading later on e-readers, but I chose to overlook that for now. It also has an Archive feature that saves the file using Singlefile. It's also possible to configure the SingleFile browser extension to send a page straight to Karakeep. At this point I was super happy, and had already decided this was the solution to choose, over Wallabag.

I should probably mention that there is an optional AI feature to obtain video transcripts and determine tags using various APIs to AI services, but I wasn't interested in those features for now.

Everything was going great until I noticed that quite a few of the pages I had bookmarked were not displaying their local copy correctly due to the cookie acceptance page that is displayed for EU citizens.

![](/assets/images/karakeep-2.png)

{: .image-caption}
*Not what I should be seeing here*

I asked someone based outside of the EU to try one of the problematic links. They had greater success (you can also see the AI tagging in action too on this screenshot):

![](/assets/images/karakeep-3.png)

{: .image-caption}
*This is what I should be seeing*

I found an [issue](https://github.com/karakeep-app/karakeep/issues/414) describing the problem. Someone suggested building a container for Chrome that installs an extension to ignore cookie banners, but I'm just not sure I wanted to go down that rabbit hole, for something that may or may not work, and will likely need housekeeping upon future upgrades.

I really want a solution that I can trust to store bookmarks and local copies of articles without having to keep checking if it's worked OK. I realise that Pocket never stored local copies but this feature is pretty compelling to me. Readeck was mentioned in a comment on the Github issue, and I was intrigued. So, I guess I was going to try the _third_ attempt at a replacement for Pocket inside 1 week...

**Things I liked about karakeep**: fast, nice UI, browser extension, decent android app, ability to additionally archive pages with SingleFile. Ingestion of RSS feeds (such as items that I've bookmarked on mastodon or reddit). I didn't try the optional AI features but some people may find it helpful.

**Things I didn't like so much**: the dealbreaker cookie problem. Also, when viewing links in karakeep, the default action is to open the source website when clicked on - I think I'd rather read my local copy by default.

## Readeck

[Readeck](https:/readeck.org) is another self-hosted open source application to manage bookmarks. Installation options include Docker and also a single binary file. The documentation was very clear and easy to read. I opted for the binary file method, which was incredibly simple, and only required a port number to be specified. I also created a dedicated non-privileged user account to run the service, and a systemd file to automatically run at boot time.

Readeck uses sqlite to store data, which reduces the need for a database server, and in practice the interface is very fast, even on my low powered server. As with the other offerings I looked at, development is active despite the small team of developers, and Readeck sees releases every few months.

Adding a link is either done manually by adding a link to the web UI, or preferably via the browser extension. I noticed that if the website is not an "article" (my interpretation is that it doesn't offer a firefox reader view) then it gives a warning and suggests you might want to select text on part of the page and save that instead, which is a nice feature. Highlights are also a very nice tool, and multiple colours can be used, and there's an aggregate view of all highlights available too.

![](/assets/images/readeck-3.png)

{: .image-caption}
*Highlighting words in Readeck*

Importing bookmarks from various sources is possible, including Wallabag, Pocket, text file and Browser. Backup via export/import is also possible via the command line.
An unofficial [Android application](https://github.com/jensomato/ReadeckApp?tab=readme-ov-file) is available on F-droid only, no Play Store for now.
Exporting for consumption by another application is currently possible via an API. I was able to extract a json file and parse it using `jq` to extract the bookmarks (`jq '.[].url' bookmarks.json`).

Common to all these services is the tagging feature, and filtering by tag. It also has the concept of collections which are created based upon characteristics you choose, such as tag, title, media type, etc.

![](/assets/images/readeck-1.png)

{: .image-caption}
*Viewing bookmarks matching a specific label/tag*

Search is very fast and flexible, and will provide matches from within the main body of text.
![](/assets/images/readeck-2.png)

{: .image-caption}
*Matches for the word "captain" anywhere in the text*

The Readeck app is performant, but currently very basic - no search of any kind, even tags is possible yet. However the mobile website provided by Readeck itself is full featured and is currently a better option unless you just want to passively consume a list of bookmarks via the app.

A very nice feature is the ability to download one or all articles as epub. Some _long read_ articles can take an hour or more to read, and I like to use an e-reader for that. At the moment I'm manually sending the downloaded epub to my Kindle via "Send to kindle" website, so I need to work out a workflow to automate this, but the results are great:

![](/assets/images/readeck-4.png)

{: .image-caption}
*Reading an article on my Kindle Scribe after downloading as epub*

**What I like about Readeck**: easy installation, browser extension, epub downloads, fast & intuitive UI, good range of features.

**What else I'd like to see**: there's not much to dislike here. Maybe a couple of tweaks to the UK might help me find the right option more easily (such as bookmark export/import), but it's a really minor niggle. A feature such as optional archival of the page using SingleFile would really be the cherry on top of the cake for me. I've seen it discussed positively in the Enhancement requests, so maybe it will be a future addition, even one that might replace my use of Archivebox for permanent archival of pages. One other [requested feature](https://codeberg.org/readeck/readeck/issues/424) is ingestion of RSS feeds. This is possible within Karakeep, and I would potentially find this useful too.

## Summary

I can see why there are happy users of each of the solutions I have looked at. All of them appear to offer more than the original Pocket service. Depending on your use-case, they all fit the bill to some extent, and I wish them all success. I've settled on Readeck, due to the most pleasant all-round experience and features that suit my requirements. It's a joy to use, and maybe as a result I can reduce my habit of keeping 200+ open tabs while I'm working on a project.

## Side note

Full details are a bit out of scope of this blog post, but...one of my requirements is mainly using this service while at home on my private LAN. In future I may deploy tailscale or a VPN to access this service. During my experiments, the version of the readeck app I was using did not allow http access or self-signed certificates (I believe this is soon to be allowed). However, this did send me down a rabbit-hole, and I also used `caddy` for the first time, to serve https connections via reverse-proxy, and I was able to obtain a LetsEncrypt certificate for my internal-only server using DNS-01 challenge. This involved adding a public DNS entry with my DNS provider (OVH), and using the OVH DNS plugin to caddy.
