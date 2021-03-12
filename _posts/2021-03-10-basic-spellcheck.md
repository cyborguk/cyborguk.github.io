---
layout: post
title: "A basic spell-checker for static sites"
categories:
  - article
tags:
  - blog
  - howto
---

If your blog is generated with a static site generator such as Hugo or Jekyll,
you might not catch spelling errors in your content. An ideal devops-style
workflow should check your markdown quality and spelling automatically when
pushing a commit. As a starting point, I'm going to provide an easy script to
manually spell-check your markdown before committing changes.

## How it works

In the top level of my repository folder, I have a directory called `tests`.
This contains a script called `spell-checker.sh` and a personal dictionary file
called `.aspell-excluded_words.en_GB.pws`. The script loops over any markdown
files in a specified directory and runs `aspell` on the markdown files found
within. I'm making an assumption you are on a Unix-like system with the
popular `aspell` package installed.

The script can be found at the bottom of the article. It is mostly comprised of
comments and workaround to avoid checking code blocks and comments, then it
checks spelling using the aspell system dictionary, plus any words you have
added to your own dictionary file. 

## The personal dictionary file

The personal dictionary is a list of words you consider to be good, but do not
exist in the system dictionary. My one tends to be full of technical words and
brand names. Of course you could use a pre-made list if you have one.

To make a new personal dictionary file in the tests folder, do

```
echo "personal_ws-1.1 en" > tests/.aspell-excluded_words.en_GB.pws
```

After that, add any personal words, one per line.
the first few lines of my personal dictionary look like this:
 
```
personal_ws-1.1 en
ActivityPub
ADSL
blocklist
Bomberman
```

Now we are ready to go.

## First run

Even with only a handful of blog posts, the first time you run the script may
produce hundreds of words considered "bad", because we need to populate our
personal dictionary. If you have hundreds of posts and you can't face the idea,
you could try checking against this year's posts only, perhaps.

Run the script from the top level of your repository directory, with

```
./tests/spell-checker.sh`
```

To filter the output to just print the list of words not recognised by either
the system dictionary or the personal one, we can run

```
./tests/spell-checker.sh | grep '\-\-\-'
--- compiz
--- Deepin
--- Digg
--- distro
--- Distros
--- Docky
--- flatpak
--- FOSS
--- KDE
--- kdenlive
--- LTS
--- PPA
--- RedHat
<snip>
```

Ok, this is useful data. If you think these are mostly good words, you can add
them to the personal dictionary with:

```
./tests/spell-checker.sh | grep '\-\-\-' | \
 awk '{print $2}' >> tests/.aspell-excluded_words.en_GB.pws
```

Open the file in a text editor and keep only the lines with words you consider
good. 

Now, when you run `./tests/spell-checker.sh` you should only see results for
badly spelled words, along with the line number where it occurs, and a total
number of errors at the end. Keep editing either your personal dictionary or
the misspelled words in your blog posts until you get to zero errors!
 
![Output from script](/assets/images/spellcheck.png){: .centre-image }

{: .image-caption}
*Running the spell checker on this post. I will add these to the dictionary*

The script is quite straightforward but does perform some sanitisation on the
markdown first to cope with code blocks and html. It should work with markdown
produced for typical mkdocs, hugo or jekyll sites. If you don't want to add a
particular word to your personal dictionary, but want the spell checker to
ignore it, you can surround it with `<!--IGNORE_SPELLING_START-->` and
`<!--IGNORE_SPELLING_END-->` comments.

One way you might want to modify your script is to check only a single file if
it is passed as a parameter perhaps.

Once you have a working spell checker, you might want to apply a markdown
linter, or something to check your hyperlinks. I might cover this another time.

<script src="https://gist.github.com/cyborguk/34478b49e884d47456515dbdf2d0acd0.js"></script>

Let me know how you get on by pinging me at [Mastodon](https://fosstodon.org/@simon).
 

