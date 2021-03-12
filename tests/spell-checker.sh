#!/bin/bash
# Spell checker for cyb.org.uk
# Initialise variables
EXITCODE=0
DICTFILE="./tests/.aspell-excluded_words.en_GB.pws"
ERRORS_FOUND=0

cleanup() {
        rm $INPUTFILE.tmp
}

trap cleanup SIGINT SIGTERM SIGKILL SIGHUP

# Gather the list of markdown files and process them
# If jekyll, use "_posts" for the find path
# If hugo, use "content" for the find path
# If mkdocs, use "docs"
for filepath in $(find _posts -type f -name "*.md" -print); do
	INPUTFILE=$filepath


    # NOTE;
    #   We do not delete lines so that we can preserve line numbering, instead
    #   we just empty them

    # Removes ignored sections
    # To ignore a section surround it with
    # <!--IGNORE_SPELLING_START-->...<!--IGNORE_SPELLING_END-->
    # For obvious reasons this should be used sparingly.
    # eg:
    #   <!--IGNORE_SPELLING_START-->
    #   SD ASF ASAS
    #   <!--IGNORE_SPELLING_END-->
    #
    SED_REMOVE_IGNORES_INLINE='s/<!--IGNORE_SPELLING_START-->[^<]\+<!--IGNORE_SPELLING_END-->//g'
    SED_REMOVE_IGNORES='/<!--IGNORE_SPELLING_START-->/,/<!--IGNORE_SPELLING_END-->/s/.*//g'
    # Removes hyperlinks but leaves content of text side behind
    # eg:
    #   [bob](/url) ![image](/imageurl) [alice][alicespage]
    #   bob image alice
    SED_REMOVE_HYPERLINKS='s/!*\[\([^]]*\)\]([^)]\+)/\1/g'
    SED_REMOVE_HYPERLINKS_SQUARE='s/\[\([^]]*\)\]\[[^]]\+\]/\1/g'
    # Remove HTML comments (of the form <!-- ... --> or <!--- ... -->)
    SED_REMOVE_HTML_COMMENTS='s/<!--.*-->//g'
    # Remove HTML comments (of the form <!-- ... --> or <!--- ... -->) split
    # over several (complete) lines
    SED_REMOVE_MULTILINE_HTML_COMMENTS='/<!--/,/-->/s/^.*$//'
    # Removes notebox definition before title
    # eg:
    #   !!! note "A Title"
    #   A Title
    SED_REMOVE_NOTEBOX_DEF_BEFORE_TITLE='s/^!!! [^ ]\+ "\([^"]\+\)"/\1/'
    # Remove notebox definition without title (does not check for title should
    # be run after $SED_REMOVE_NOTEBOX_DEF_BEFORE_TITLE
    # eg:
    #   !!! note
    #
    SED_REMOVE_NOTEBOX_DEF='s/^!!!.*$//'
    # Remove code blocks
    # eg:
    #   ```bash
    #   echo bob
    #   ```
    #
    SED_REMOVE_CODE_BLOCKS='/```/,/```/s/^.*$//'
    # Remove inline code / script and style tags
    # Since the contents is likely non-english
    # eg:
    #   this is <code>not</code> sparta
    #   <style>a.btn {display: none;}</style>
    #   <script> asciinema_player.core.CreatePlayer('player', 'cast.json')</script>
    #   this is sparta
    #
    SED_REMOVE_INLINE_CODE_TAGS='s/<\(code\|style\|script\)>[^<]\+<\/\1>//g'
    # Remove multiline code / script and style tags
    # eg:
    #   <code>
    #   bob
    #   </code>
    # Note:
    #   Due to backreferences not working in addresses this is 3 expressions
    code_part='/<code>/,/<\/code>/s/.*//g'
    style_part='/<style>/,/<\/style>/s/.*//g'
    script_part='/<script>/,/<\/script>/s/.*//g'
    SED_REMOVE_MULTILINE_CODE_TAGS="${code_part};${style_part};${script_part}"
    # Remove inline selfclosing html
    # eg:
    #   <img src="" />
    #
    SED_REMOVE_INLINE_SELFCLOSING_HTML='s|<[^>]\+/>||g'
    # Remove inline html, leaving contents as its likely text
    # eg:
    #   hello <div class=weird>bob</div>
    #   hello bob
    SED_REMOVE_INLINE_HTML='s|<[^>]\+>\([^<]*\)</[^/]\+>|\1|g'
    # Remove multiline selfclosing html
    # eg:
    #   <img src=""
    #   />
    #
    #
    SED_REMOVE_MULTILINE_SELFCLOSING_HTML='/<[^>]\+$/,/\/>/s/^.*$//'
    # Remove multiline html
    # eg:
    # <div>
    #   nope
    # </div>
    #
    #   nope
    #
    SED_REMOVE_MULTILINE_HTML='/<[^>]\+>/,/<\/[^>]\+>/s/\(<[^>]\+>\)*\(.*\)/\2/'
    # Remove inline text between backticks (assumed to be code), expects
    # $SED_REMOVE_CODE_BLOCKS to have been run
    # eg:
    #   `bob` not `awesome` yet
    #    not yet
    SED_REMOVE_BACKTICKS='s/`[^`]\+`//g'
    # Remove page includes
    # eg:
    #   {!dogs/doge!}
    #
    SED_REMOVE_INCLUDES='s/{![^!]\+!}//g'

    # Order is important, as this is the order they've been designed and tested
    # in. The multiline expressions expect inline matches to be dealt with
    # already.
	sed -e "${SED_REMOVE_IGNORES_INLINE};
            ${SED_REMOVE_IGNORES};
            ${SED_REMOVE_CODE_BLOCKS};
            ${SED_REMOVE_INLINE_CODE_TAGS};
            ${SED_REMOVE_BACKTICKS};
            ${SED_REMOVE_HYPERLINKS};
            ${SED_REMOVE_HYPERLINKS_SQUARE};
            ${SED_REMOVE_HTML_COMMENTS};
            ${SED_REMOVE_MULTILINE_HTML_COMMENTS};
            ${SED_REMOVE_NOTEBOX_DEF_BEFORE_TITLE};
            ${SED_REMOVE_NOTEBOX_DEF};
            ${SED_REMOVE_MULTILINE_CODE_TAGS};
            ${SED_REMOVE_INLINE_SELFCLOSING_HTML};
            ${SED_REMOVE_INLINE_HTML};
            ${SED_REMOVE_MULTILINE_SELFCLOSING_HTML};
            ${SED_REMOVE_MULTILINE_HTML};
            ${SED_REMOVE_INCLUDES};
            " $INPUTFILE > $INPUTFILE.tmp

    bad_words=$(cat $INPUTFILE.tmp | aspell list --lang=en_GB \
                                                 --encoding=UTF-8 \
                                                 --ignore-case \
                                                 --personal=${DICTFILE}
    )

    if [ "$bad_words" ]; then
        # Get a running total of errors found
        bad_increment=`echo $bad_words | wc -w`
        ERRORS_FOUND=$((ERRORS_FOUND+$bad_increment))
	# get rid of dupes and also we don't care about case.
	# otherwise we produce too many results when we run the grep.
	# xargs needs -0 to deal with any ' characters it finds
        bad_words_unique=`echo $bad_words | tr ' ' '\n' | sort -fu | xargs -0`
        EXITCODE=1
        echo -e "\nError in file: $INPUTFILE\n"

        for word in $bad_words_unique; do
            echo "--- ${word}"

            # Get line for word, if not exact match, switch to full search
            grep "\b${word}\b" -in $INPUTFILE.tmp
            if [ $? == 1 ]; then
                grep "${word}" -in $INPUTFILE.tmp
            fi
        done
    fi

	cleanup
done

echo -e "\nTotal errors: ${ERRORS_FOUND}"

exit $EXITCODE

