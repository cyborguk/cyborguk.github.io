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
you might not catch spelling errors in your content. An ideal workflow will
check your markdown quality and spelling automatically when pushing a commit.
As a starting point, I'm going to provide an easy script to manually
spell-check your markdown before committing changes.

## How it works

In the top level of my repository, I have a directory called `tests`. This has
a script called `spell-checker.sh` and a personal dictionary file called
`.aspell-excluded_words.en_GB.pws`. The script will cycle over any markdown
files in a specified directory and run `aspell` on the markdown files found
within, so I'm making an assumption you are on a Unix-like system with the
popular `aspell` package installed.

The script can be found at the bottom of the article. It is mostly comprised of
comments and workaround to avoid checking code blocks and comments, then it
checks spelling using the aspell system dictionary, plus any words you have
added to your own dictionary file. 

## The personal dictionary file
The personal dictionary is a list of words you consider to be good, but do not
exist in the system dictionary. My one tends to be full of technical words and
brand names. Of course you could use a pre-made list if you have one. The only
requirement is that the first line of the file, for English language checks is
`personal_ws-1.1 en`. After that, add new words, one per line - for example,
the first few lines of my personal dictionary look like this:
 
```
personal_ws-1.1 en
ActivityPub
ADSL
blocklist
Bomberman
```

## First run

Run the script from your top-level directory, with

```
./tests/spell-checker.sh`
```

Even with only a handful of blog posts, the first time you run the script may
produce hundreds of "bad" words, because we need to populate our personal dictionary. 

To output the list of bad words, we can run

```
./tests/spell-checker.sh.new | grep '\-\-\-'
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

Ok, this is useful. You can output just the words into a file with 

```
./tests/spell-checker.sh.new | grep '\-\-\-' | awk '{print $2}' > badwords.txt
```

Some of these will be legitimate words, and some will be errors, so you've got
some checking to do here. Open the file in an editor and keep only the good
words. When finished, add them to your personal dictionary file.

```
# Create a personal dictionary file if you haven't already
# Careful, since this will overwrite an existing one
echo "personal_ws-1.1 en" > tests/.aspell-excluded_words.en_GB.pws
# Append your known-good words from badwords.txt
cat badwords.txt >> tests/.aspell-excluded_words.en_GB.pws
```

Now, when you run `./tests/spell-checker.sh` you should only see results for
incorrect words, along with the line number where it occurs.

<script src="https://gist.github.com/cyborguk/34478b49e884d47456515dbdf2d0acd0.js"></script>


