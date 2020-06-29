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

#---------------------------------------------------------------------------------------------------------------------------------------
#   2.  MAKE TERMINAL BETTER
#---------------------------------------------------------------------------------------------------------------------------------------

# Misc Commands
alias resource='source ~/.bash_profile'                                         # Source bash_profile
alias ll='ls -alh'                                                              # List files
alias llr='ls -alhr'                                                            # List files (reverse)
alias lls='ls -alhS'                                                            # List files by size
alias llsr='ls -alhSr'                                                          # List files by size (reverse)
alias lld='ls -alht'                                                            # List files by date
alias lldr='ls -alhtr'                                                          # List files by date (reverse)
alias lldc='ls -alhtU'                                                          # List files by date created
alias lldcr='ls -alhtUr'                                                        # List files by date created (reverse)
h() { history | grep "$1"; }                                                    # Shorthand for `history` with added grepping

disk-usage() { du -hs "$@" | sort -nr; }                                        # List disk usage of all the files in a directory (use -hr to sort on server)
dirdiff() { diff -u <( ls "$1" | sort)  <( ls "$2" | sort ); }                  # Compare the contents of 2 directories

#---------------------------------------------------------------------------------------------------------------------------------------
#   3.  FOLDER MANAGEMENT
#---------------------------------------------------------------------------------------------------------------------------------------

# Clear a directory
cleardir() {
    while true; do
        read -ep 'Completely clear current directory? [y/N] ' response
        case $response in
            [Yy]* )
                bash -c 'rm -rfv ./*'
                bash -c 'rm -rfv ./.*'
                break;;
            * )
                echo 'Skipped clearing the directory...'
                break;;
        esac
    done
}

mktar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }    # Creates a *.tar.gz archive of a file or folder
mkzip() { zip -r "${1%%/}.zip" "$1" ; }               # Create a *.zip archive of a file or folder


#---------------------------------------------------------------------------------------------------------------------------------------
#   4.  MISC ALIAS'
#---------------------------------------------------------------------------------------------------------------------------------------


# Start a web server to share the files in the current directory
startserver() {
    # PHP
    path="$1"
    if [ -z "$path" ]; then
        path="."
    fi
    open http://localhost:3000
    php -t $path -S localhost:3000
}
