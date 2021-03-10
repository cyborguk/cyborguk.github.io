#!/bin/bash
# Spell checker for cyb.org.uk
# Licenced under GPL

EXITCODE=0
DICTFILE="./tests/.aspell-excluded_words.en_GB.pws"
TOTAL_ERRORS=0

cleanup() {
        rm $INPUTFILE.tmp
}

trap cleanup SIGINT SIGTERM SIGKILL SIGHUP

# Gather the list of markdown files and process them
# If jekyll, use _posts for the find path
# If hugo, use content for the find path
for filepath in $(find _posts -type f -name "*.md" -print); do
	INPUTFILE=$filepath

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
    #
    # Remove code blocks
    # eg:
    #   ```bash
    #   echo bob
    #   ```
    #
    SED_REMOVE_CODE_BLOCKS='/```/,/```/s/^.*$//'
    #
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
    #
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
        EXITCODE=1
        echo -e "\nError in file: $INPUTFILE\n"

        for word in $bad_words; do
            TOTAL_ERRORS=$((TOTAL_ERRORS+1))
            echo "--- ${word}"

            # Get line for word, if not exact match, switch to full search
            grep "\b${word}\b" -n $INPUTFILE.tmp
            if [ $? == 1 ]; then
                grep "${word}" -n $INPUTFILE.tmp
            fi
        done
    fi

	cleanup
done

echo -e "\nTotal errors: ${TOTAL_ERRORS}"

exit $EXITCODE
