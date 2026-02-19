#!/bin/zsh

# created Friday, January 17, 2025, 14:07:49
# confirmed to work Saturday, January 18, 2025, 12:28:21
# "https://unicode.org/Public/emoji/"
# "https://unicode.org/Public/emoji/latest/"

## make sure necessary binaries exist
function ensureGivenBinaryExists()
{
	command -v "$1" >/dev/null 2>&1 || { echo >&2 "[\"$1\" required to run, but \"$1\" was not found in \$PATH. Aborting...]"; exit 1; }
}

ensureGivenBinaryExists git
ensureGivenBinaryExists awk
ensureGivenBinaryExists sed
ensureGivenBinaryExists grep
ensureGivenBinaryExists curl

## are you sure you wanna update?
echo '[are you sure you want to update emojipickerlist.txt?]'
echo '[this will redownload and replace the current "emoji-test.txt"]'
echo -n '[enter "YES" to continue] > '
read yesNoPromptResult 
if [ "$yesNoPromptResult" != "YES" ]; then
	echo '[aborting...]'
	exit 1
fi

## download emoji-test.txt
curl 'https://unicode.org/Public/emoji/latest/emoji-test.txt' -o 'resources/emoji-test.txt' || { echo >&2 '[something went wrong. Aborting...]'; exit 1; }

## parse emoji-test.txt
grep -E 'qualified|group' 'resources/emoji-test.txt' \
	| sed 's/.* ; .* # /DONTDELETETHISLINE/' \
	| sed 's/ E[0123456789]*\.[0123456789]* / /' \
	| sed 's/# group:/DONTDELETETHISLINE# group:/' \
	| sed 's/# subgroup:/DONTDELETETHISLINE# subgroup:/' \
	| sed -n '/DONTDELETETHISLINE/p' \
	| sed 's/DONTDELETETHISLINE//' > 'resources/emoji-test.initialParse.txt'

awk '\
	BEGIN { matchedgroup=""; matchedsubgroup="" } \
	/# group: /{ matchedgroup=substr($0, 10) } \
	/# subgroup: /{ matchedsubgroup=substr($0, 13) } \
	{ if(!match($0, /# .*group: /)) print $0,"|",matchedgroup,"|",matchedsubgroup } \
	'\
	'resources/emoji-test.initialParse.txt' > 'resources/emoji-test.finalParse.txt'

## preserve ancestor file for next update
cp 'resources/emoji-test.finalParse.txt' 'resources/emojipickerlist.nextancestor.txt'

if [ ! -f 'resources/emojipickerlist.ancestor.txt' ]; then
	echo '[ancestor file not found!]'
	echo '[creating ancestor file...]'
	cp 'resources/emojipickerlist.nextancestor.txt' 'resources/emojipickerlist.ancestor.txt'
fi

## merge changes/updates
git merge-file -p 'resources/emoji-test.finalParse.txt' 'resources/emojipickerlist.ancestor.txt' 'resources/emojipickerlist.txt' \
	> 'resources/oldnewmergedemojipickerlist.txt'
	#Given three files <current>, <base> and <other>, git merge-file incorporates
	#all changes that lead from <base> to <other> into <current>. The result
	#ordinarily goes into <current>. git merge-file is useful for combining separate
	#changes to an original. Suppose <base> is the original, and both <current> and
	#<other> are modifications of <base>, then git merge-file combines both changes.

## replace old ancestor with new ancestor file
echo
echo '[replacing old ancestor file with new ancestor file...]'
mv -fv 'resources/emojipickerlist.nextancestor.txt' 'resources/emojipickerlist.ancestor.txt'

## replace old emojipickerlist.txt with new emojipickerlist.txt
echo
echo '[replacing old emojipickerlist with new emojipickerlist]'
mv -fv 'resources/oldnewmergedemojipickerlist.txt' 'resources/emojipickerlist.txt'

## cleanup tempfiles
echo
echo -e "\033[0;31m[READ CAREFULLY]\033[0m"
echo '[you have to decide whether to remove temp files from this emoji update or not]'
echo '[follow the prompts from the following "rm" command]'
rm -iv 'resources/emoji-test.txt' 'resources/emoji-test.initialParse.txt' 'resources/emoji-test.finalParse.txt'

echo
echo '[done!]'
