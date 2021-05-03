---
layout: post
title: Be more productive with use of your BASH history
categories:
  - article
tags:
  - blog
  - howto
---

If you spend time working in the terminal, whether for work or leisure, a lot
of the commands you type often have a dependency on other recent commands, 
might be repetitive actions, or be very similar to other commands previously
run. Gaining mastery over your shell history is a great way to be more
productive in the terminal. 

I'm going to share some tips which improve my speed while using the shell to
perform common sysadmin tasks, or file manipulation.

## Get a better history

New users to the Linux command-line might first grasp the `history` command, or
perhaps the up/down arrows to
show recent commands. They might have also learned to use tab-complete
extensively, maybe a little too much. They may even use the `ctrl-r` command to
search the history. This offers some degree of productivity, but we can do
better than this. 

Depending on your operating system, you may have some of the following
suggestions applied by default, whether as a global setting or applied at a
local level in the `.bashrc` folder in your home directory. To apply new
settings, I suggest you make a backup of this file, and open it in your
favourite editor. After saving, you can load the new settings with `source
~/.bashrc`, or logout/login again. 

### 1. Use HISTIGNORE to remove pointless commands from history

Some bash commands are used to provide some moment-in-time information but
don't change your environment, and aren't useful in your history. Adding the
HISTIGNORE variable to your `.bashrc` file allows you to choose which
standalone commands to drop from your history. Here's an example: 

```
export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ls:uptime:df'
```

Add to this list or remove from it as you see fit - some people use the `ll` as
an alias of `ls -alF`. A frequent user might want to stop this from appearing
in their history too.

As a bonus, if you don't want certain sensitive commands appearing in your
history, for example if you are specifying a password or API key on the command
line, then you can use the following option to make sure that any command
beginning with a space does not appear in the history file:

```
export HISTCONTROL=ignorespace
```

This isn't the only option: for example, the `ignoredups` option will only
store one copy of a command if the consecutive command is identical. 

### 2. Don't lose important history

Without the `histappend` option, you will find that if you open multiple
concurrent shell sessions, then only entries from the last exiting shell is
saved (history is saved in memory and written to the history file upon exit).
Another annoyance can be that you may share a root shell with other
administrators on a server, and important history gets lost because the history
file is too small. I usually set a history file size of at least 10,000 entries
to avoid losing an audit trail, or useful commands. 

```
shopt -s histappend
export HISTSIZE=10000
```

### 3. Recalling commands effectively

Now that you have a more streamlined command history, we can do more that
up/down arrow to select previous commands. 
The `!!` command recalls the previous line. For example.

```
$ pwd
/etc
$ !!
pwd
/etc
```

This can be used as part of a command, so `sudo !!` will run the previous
command with sudo privileges. You can cause a lot of damage by blindly running
sudo with recalled commands, so you should add `:p` on the end of the command
to recall but not actually run the command. It will then appear as the last
command in your history which can be accessed with a single press of the
up-arrow key. 

Also you can run a command from your history by putting a `!` in front of the
line number provided by the history command. Due to the higher likelihood of
mistyping a number here, I tend to add the `:p` to show me the command but not
run it. Then I can do up arrow to show the command in order to check it and run
it with a carriage return  

```
$ rm -r temp/
$ mkdir temp
$ touch temp/test
$ !!
touch temp/test
$ history | tail -4
  179  rm -r temp/
  180  mkdir temp
  181  touch temp/test
  182  touch temp/test
  183  history | tail -5
$ !179:p
rm -r temp
$ !180
touch temp/test
```

You can also call the last used occurrence of a command with a `!` in front.
For example, `!ping` will run the last command you ran beginning with `ping`.
This is a powerful time saver, which I use all the time (e.g. `!vim` will open
the vim editor with the last file I opened - handy when performing a few
consecutive edits on a file) but you need to be sure of what you
are doing when using riskier commands. Again, you can add a `:p` to show
expansions without actually executing them. 

If you are a really risk-averse person, you can skip the use of `:p` and add
`shopt -s histverify` to your `.bashrc` file and every command expanded with
`!` will be recalled on the current line but will wait for you to press enter. 

### 4. Using parameters from the previous line with !$ and !*

One of my favourite efficiency tips is use of `!$` and `!*` to refer to parts
of the previous command (as opposed to `!!` for the whole command).

Using `!$` will expand to the last parameter of the last command, which can
save you a lot of typing or copy-pasting. For example, rename a file, then edit
it:

```
$ mv list.txt items.txt
$ vim !$
vim items.txt
$ cp !$ shopping.txt
cp items.txt shopping.txt
```

The `!$` expands to the value of the last parameter of the previous line, i.e
after the `mv` command, `!$` expands to `items.txt`.

Using `!*` will expand the value of all of the parameters on the previous line
(i.e. the whole line except the first word). Not quite as commonly used as `!$`
which I use *constantly* but handy nonetheless. In this example, we remove some
log files and then create some empty versions of the same file: 

```
$ rm /var/log/httpd/access.log /var/log/httpd/error.log
$ touch !*
touch /var/log/httpd/access.log /var/log/httpd/error.log
```

### 5. Replace a matching word from the previous line with ^

This is another big time-saver which a use a lot, particularly when you are
manipulating files with long path names. The `^` symbol allows you to repeat
the previous command after switching a matching word. For example:

```
$ rm /var/log/httpd/error.log
$ ^error^access
rm /var/log/httpd/access.log
```

### 6. Use readline for partial history search

This isn't strictly a BASHism, but it will change your life! Adding certain
values to `~/.inputrc` will allow you to do things like this:  

* type `ssh <up arrow>` and cycle through your previous ssh sessions
* type `git <up arrow>` and cycle through previous git commands
* type `cp -r <up arrow>` and cycle through previous recursive copies you did - notice that it doesn't have to be just one word

It really makes a difference - you will find yourself typing `history | grep
ssh`, or searching history aimlessly with arrow keys a whole lot less!

To enable this functionality, create a file called `.inputrc` in your home
directory, containing the following lines, then restart your bash session 

```
# include the system-wide settings
$include /etc/inputrc
# enable partial history search
"\e[A": history-search-backward
"\e[B": history-search-forward
```

If you aren't getting left/right arrow functionality, and ctrl-left/right isn't
working to skip words, you might need to add:

```
# Use arrow keys to move character left/right
"\e[C": forward-char
"\e[D": backward-char
# Use Ctrl and Arrow keys to move along words
"\e[1;3C": forward-word
"\e[1;3D": backward-word
```
  
One gotcha is that if you are expecting to use regular up/down arrow to browse
your full history, then you need to have a blank line before doing this - not
even any spaces entered!

Let me know how you get on by pinging me on [Mastodon](https://fosstodon.org/@simon).
 

