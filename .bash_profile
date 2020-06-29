#---------------------------------------------------------------------------------------------------------------------------------------
#
#   Author: alexkons (github)
#   Description: File used to hold Bash configuration, aliases, functions, completions, etc...
#   Copy from : https://gist.github.com/kjbrum/77b7af04191267b053e9
#   Sections:
#   1.  ENVIRONMENT SETUP
#   2.  MAKE TERMINAL BETTER
#   3.  FOLDER MANAGEMENT
#   4.  MISC ALIAS'
#   5.  GIT SHORTCUTS
#   6.  OS X COMMANDS
#   7.  TAB COMPLETION
#
#---------------------------------------------------------------------------------------------------------------------------------------


#---------------------------------------------------------------------------------------------------------------------------------------
#   1.  ENVIRONMENT SETUP
#---------------------------------------------------------------------------------------------------------------------------------------

# Github
export GITHUB_TOKEN='xxx'

# Get Git branch of current directory
git_branch () {
    if git rev-parse --git-dir >/dev/null 2>&1
        # then echo -e "" git:\($(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')\)
        then echo -e "" \[$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')\]
    else
        echo ""
    fi
}

# Set a specific color for the status of the Git repo
git_color() {
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
        then echo "" # nothing
    else
        if [[ "$STATUS" != *'working tree clean'* ]]
            then echo -e '\033[0;31m' # red if need to commit
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
                then echo -e '\033[0;33m' # yellow if need to push
            else
                echo -e '\033[0;32m' # else green
            fi
        fi
    fi
}
