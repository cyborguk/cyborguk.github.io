---
layout: post
title: An introduction to Mastodon
categories:
  - article
tags:
  - mastodon
  - social-media
---

A guide for Google+ refugees and Open Source enthusiasts

## What is Mastodon?

> Mastodon is a social network, similar to Twitter and Facebook, where you can follow others, read content in chronological order, with a focus on community. It has key features to help discoverability of similar people, and anti-abuse/spam/trolling.

![Mastodon's friendly mascot](/assets/images/masto1.png){: .centre-image}

{: .image-caption}
*Mastodon's friendly mascot*

Some of the benefits are outlined in this [short video](https://www.youtube.com/watch%3Fv%3DIPSbNdBmWKE)

### A brief outline of features:

* based around **microblogging** - status updates (known as toots) are limited to 500 characters. In this aspect the platform is most similar to Twitter (limited to 280 character posts), but it brings in other features that Twitter would never support, due to its design.
* **toot privacy** can be set per individual toot - (Facebook supports this to some extent, Twitter doesn't). You can limit an individual post's privacy to public timelines, unlisted (visible to followers and on your feed, but don't appear in public timeline), followers-only, direct message.
* **no advertising** - this is a user-focused social network for the users, not a money-making endeavour.
* **decentralised** - this bring a variety of features which require inspection in further detail later.
* **Privacy and anti-abuse** features:

There are a whole bunch of features to reduce your stress levels. You can

* block users
* block notifications from certain users
* mute them (like a silent block)
* mute conversations,
* **hide everything from a specific instance** : hide all of their posts and remove any followers you might have had from that server so they no longer receive your posts, either
* **Content Warnings**. This is a neat feature that allows you to hide the bulk of your post behind a click-to-reveal warning title. Not only limited to NSFW posts and profanity, but also handy for spoilers, political posts, rants…and joke punchlines.

![using Content Warning in a toot to hide spoilers](/assets/images/masto2.png){: .centre-image}

{: .image-caption}
*Using a content warning to hide spoilers*

* conceal your follow/followers list
* opt-out of search indexing of your public profile and status pages
* ability to **lock down** your account to approve or reject follow requests.
choose whether to automatically hide or show an image in a post (e.g. sensitive content) - this is configured when adding the image, by clicking the eyeball icon
* add **text filters** : don't want to see posts that contain a specific word or phrase? perhaps you haven't seen a TV programme yet and you don't want any spoilers? you can specify the text, expiry date(if any). and context (timeline, public timelines, notifications, etc)

![Text filter options](/assets/images/masto3.png){: .centre-image}

{: .image-caption}
*Text filter options*

### Other features

* slick user interface - the web user interface is similar to tweetdeck UI if you are familiar with it. Although extra features have since been added, this video shows the workflow on an older version. Multiple mobile clients are available, such as mastalab on Android.
* Free and Open Source - by design, the platform and protocols are all free and open. You are free to use the API to publish/read data, use or write your own tools, or spin up your own server. You can request new features and get a fair response. This is in contrast to the big social networks. Not even billionaire celebrities with a million followers get their feature requests heard on Twitter. Also, Twitter restrict use of 3rd party clients, and impose draconian rules upon how data is displayed, inserting sponsored posts, "while you were away", and other non-chronological "features" that nobody wanted.
* Federated authentication - Mastodon uses the open ActivityPub protocol (now a W3C standard) for federated messaging across multiple services. In summary, participating sites will allow you to use your mastodon credentials to interact with their services in a seamless fashion.

> ActivityPub provides a server-server protocol for federation and a client-server protocol for users to connect to a server. The core idea of ActivityPub is to bring together decentralized social networks, gaining critical user mass while keeping data on separate servers. .

[Here's a short video](https://peertube.cpy.re/videos/watch/da2b08d4-a242-4170-b32a-4ec8cbdca701) on how you can interact on Peertube (a decentralised video sharing platform) and Mastodon microblogging social network:
* The Fediverse - the collection of sites implementing this protocol - is growing, and currently includes, among others:
* Hubzilla (CMS)
* Nextcloud (file backup and sharing)
* Mastodon
* Peertube (similar to YouTube)
* Pixelfed (similar to instagram)

[Read this](https://medium.com/we-distribute/a-quick-guide-to-the-free-network-c069309f334) for a bit more detail on how it all fits together.

## Decentralisation - features and side-effects
Decentralisation is a major design feature of Mastodon and the other participating sites in the Fediverse, and understanding the big picture is helpful for new and potential users of the service.
Decentralisation means that, unlike the major social media sites, **no single entity or company runs the service**. Instead, it is made up of **connected independent sites**, or **instances**. If you wanted, you could run your own instance. It's important to note that, each instance has its own separate admin/moderators, as well as their own code of conduct.
Since mastodon is open-source, you are free to run your own instance, (even a private one that isn't connected to the Fediverse, such as behind a company firewall, or for a closed members-only society).
Under the decentralised model, you get to pick the instance to be based at, without restricting you from viewing posts made by users on different instances. The only difference is that if the user is based on a different instance to you, they aren't just user `@barry`, as on Twitter, but their instance name needs to be included instead e.g. `@barry@mastodon.social`. Think of the email paradigm and the need to specify a domain for a complete email address. Even if you know their common internet handle (e.g. `barry`), there could be someone using that handle on another server, in a similar way to `barry@gmail.com` being different from `barry@outlook.com`, `@barry@mastodon.social` is different from `@barry@mastodon.cloud` on another instance. It's possible use the interface to search for people called barry, and you'll be presented with a few matches.

Under the decentralised model, certain features come into play:

* **Moderation for Anti-abuse/Anti-spam** - everyone who has been on Twitter has seen the relentless tide of spam, smut and hate. With hundreds of millions of users, it's also impossible to control. However, if your network is a collection of smaller servers, with dedicated moderators, the problem becomes more manageable, and a spammer or abusive person would stick out like a sore thumb on a well-behaved instance. A small server with only a few thousand users can easily be moderated by a small group of moderators, and even larger instances can be moderated relatively smoothly.
* **Interact with like-minded people** - one of mastodon's greatest features is one that some people miss entirely.

### Local and Federated Timelines

When you join an instance, you are presented with a multi-column interface that can optionally show:
* your timeline - people you follow,
* notifications - replies, boosts(retweets), favourites/likes, mentions, etc
* local timeline
* federated timeline
* lists (collated groups of users, like Twitter lists)

The local timeline is a chronological feed of all public posts **made by people on your local instance**. If you join an instance of like minded people, you have a ready-made moderated community, Although they aren't necessarily committing to always post "on topic", this is a great opportunity to instantly participate in a community of like minded individuals, without necessarily having to build a set of followers (one of Twitter's problems).

> "The local timeline is a chronological feed of all public posts made by people on your local instance. If you join an instance of like minded people, you have a ready-made moderated community"

The federated timeline is sometimes mistaken as being the entire mastodon feed. However, it is a feed of all users either on your instance, or followed by someone on your instance. On a very small instance, of a handful of users, this is perhaps rather useful, but even small/medium sized instances will produce a random and sometimes unpalatable federated timeline. perhaps with some dedication to the block button, you might be able to curate this feed, but it really does feel like drinking from the Twitter firehose.

### Which instance do I choose?

Many first-time users join one of the most popular instances, such as [mastodon.social](https://mastodon.social), where the mastodon developer Eugen Rochko resides. I would discourage you from joining such a generalist instance - as of January 2019, mastodon.social has over 300,000 users. Joining this instance would add you to a random melting pot of users who are all jabbering about everything (under a fairly liberal [Code of Conduct](https://mastodon.social/about/more). Reading the local timeline won't really be any use and you won't really feel connected. Since they don't block certain remote instances who encourage very NSFW and extreme speech, the federated feed will be very unsavoury, and is perhaps what puts off new users from the whole network. Users who join this instance will need to build followers in a similar way to twitter, and won't be gaining the community aspects of mastodon.

> If you are considering joining mastodon, or at least want to know what it's all about, I appeal to you to join an instance centred around a common interest. Here you will more likely find an existing community of like-minded users.

As a free & open-source software enthusiast, with particular focus for Linux, I want to post, learn, and build community with similar people.
[Fosstodon.org](https://fosstodon.org) is a instance with around 2,000* members, posting on general topics but have a common interest in Free/Open Source Software.
They require members to adhere to a well-defined [Code of Conduct](https://hub.fosstodon.org/code-of-conduct) that ensures constructive behaviour on the instance. No smut; no spam; no advertising or trolling. It's an English language only site that encourages civil discussion under the general advice of "don't be a jerk".
Fosstodon has been gaining traction, with popular open-science projects coming on board, it will hopefully be a defacto place for future FOSS types to join in future. If you are quick, on smaller/medium instances you have a good chance of choosing your username of choice!

Other small/medium sites that are worth checking out are:
* [floss.social](https://floss.social) (only a couple of hundred members*, but that may suit some)
* linuxrocks.online (similar to fosstodon in size but the code of conduct isn't particularly specific - that may suit some people).
* [mastodon.technology](https://mastodon.technology) is described as an instance for people interested in technology, has a decent CoC and has 16,000* members.
* For web developers, [toot.cafe](https://toot.cafe) has around 2,000* members and has a similar CoC, and manage a blocklist of instances that some of the other mentioned sites also use to filter out unsavoury and illicit content from hashtag search, federated timelines, and contact from users on those instances. I've noticed some of these sites appearing in the mastodon.social federated list, leading me to conclude that if they do block instances, they let more illicit stuff through, perhaps contributing to the poor initial experience that I've heard from new users on mastodon.social.
* [infosec.exchange](https://infosec.exchange) is centred around the infosec community.

If you have other niche tastes, or are looking for a specific code of conduct, then [this guide](https://instances.social) that might help you find one. Some sites have some rather, shall we say, niche/exotic interests (just like the saying that there's a subreddit for everything), so take care!

## Frequently Asked Questions

> Why is there no full text search across all instances?

Currently this is not possible by design as it is seen as a bit invasive. The recommendation is to use #hashtags to improve searchability of toots. Full text search of your own posts (posted, received) or other posts you have favourited is available. This doesn't stop someone from writing their own search index, but it doesn't limit some of the behaviours that mastodon is trying to avoid.

> Why is quoting messages not possible, like on Twitter?

Similarly, this is deemed as another unhelpful Twitter feature that is often used to slam-dunk others, or show them up. Instead replying to messages is preferred if you want to engage.

> How can I view a local timeline of another instance without being a member?

This is a missing feature in the web UI and has been requested. There is however handy tool to quickly view recent timelines on various instances. Alternatively, visit the website of the instance, which often allow a peek of the current local timeline (note that some sites show the federated timeline instead)
If you use a mobile client, both mastalab(Android) and toot!(IOS) have a great feature that allow you to follow remote instances without requiring an account.
> I'm well known in the community and concerned others might impersonate me. How do I get verification?

Verification is a matter of trust. Mastodon allows you to link to a website, and then verify ownership of that website, leading to a verified website status on your profile. For many people, this is sufficient. Others are utilising keybase.io to verify their identity.

> Can you suggest some people to follow?

The trunk project has a list of users who have nominated themselves as people who post on certain topics. A wide variety of topics are covered, so it's a start. However, given the large number of mastodon users globally, this certainly doesn't reflect all that's going on. Look around and you'll find plenty of interesting users and bots e.g. newsbot sites with plenty of accounts to follow, if you currently view this kind of thing on twitter and want to make the jump.
If you are on a "birds of a feather" instance where there are like minded people, follow them and also check out who they are following, including your instance moderators.

> How popular is mastodon?

Since the first release in October 2016, Mastodon has grown steadily, through word of mouth, substantial media coverage during April 2017, the #deletefacebook campaign, and external factors such as content decisions by tumblr. Statistics show that toward the end of 2018, 100k users were added over a space of 6 weeks, to total 1.8M users. It's fair to say that the user-base is healthy, and growth is pretty solid. This solid user-base was a deciding factor for me when considering other social networks.

> Isn't it a bit dodgy just joining some random person's instance? Could they be reading my Direct Messages?

Potentially, yes. It's a good idea to check out who runs an instance, and whether you trust them enough. However, you also have a similar issue with the big social networks, and history has shown that they do read your private messages and share them with others.
Under the decentralised model, what's to stop my instance shutting down and losing all my toots?
This is a potential risk, and has happened before (accidental, or deliberate). However, the plus side is that the whole service does not go down, nor is it easy for governments/other to shut down a decentralised service. Individual nodes, perhaps, but others will remain up and new ones will sprout.
Fortunately the interface and open API allow easy backups of all toots, followers, etc in ActivityPub format to upload on another instance if that ever occurred.

> Who pays for this? Is it really free?

Unlike the profit-centred social networks, the Fediverse is run for people, not profit. It is free to use. However, the person who runs your instance will have server hosting costs, and usually have a patreon page to allow members to contribute voluntarily. Similarly, the main mastodon developer is funded by patreon donations. Suddenly the idea that you would never want to pay for Twitter/Facebook, changes as you find yourself much happier to contribute £1 a month to support your instance for the common good.

> Why mastodon rather than some other social network?

It's a good question. Hopefully you are persuaded that the Fediverse is a credible alternative. My reasons for choosing it are a combination of all the features I've listed above, but that wouldn't be sufficient if it didn't have a substantial and growing userbase, and didn't alienate new joiners who would otherwise have to build a following from scratch. Nobody wants a social network with nobody to connect with. There are some other nice options - I have an account on a diaspora* instance called pluspora. The interface looks just like Google+, but I felt that it doesn't have the market share or momentum required to "make it". Also the blocking features don't seem to be as well developed, which will soon lead to a bad experience.

Mastodon is already at the point where it is useful, and has potential to become a real contender after the demise of Google+, Twitter's toxic community, and further revelations about Facebook's use of personal data.

*Usage Statistics were correct as of 2019–02–01
