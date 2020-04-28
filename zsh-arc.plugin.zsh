# Basic zsh aliases and functions for Yandex Arc by Anton Rudeshko.
# Based on https://github.com/ohmyzsh/ohmyzsh/blob/2eb3e9d57cf69f3c2fa557f9047e0a648d80b235/plugins/git/git.plugin.zsh

function arc_current_branch() {
  if arc root &> /dev/null; then
    cat $(arc root)/.arc/HEAD | sed 's/Symbolic: "\(.*\)"/\1/'
  fi
}

# Compare file content between commits A & B.
# $1 — file path
# $2 — commit A
# $3 — commit B
function adf {
    diff -u \
        <(arc show ${2}:${1}) \
        <(arc show ${3}:${1})
}

# Compare trees between commits A & B.
# $1 — path
# $2 — commit A
# $3 — commit B
function adft {
    diff -u \
        <(arc ls-tree --full-name -r $2 $1) \
        <(arc ls-tree --full-name -r $3 $1)
}

# Compare arc & git work copies.
# $1 — arc repo path
# $2 — git repo path
function agd {
    diff -u \
        <(cd $1 && find . -type f -print0 | sort -z | xargs -0 shasum) \
        <(cd $2 && find . -not -path "./.git/*" -type f -print0 | sort -z | xargs -0 shasum)
}

#
# Aliases
# (sorted alphabetically)
#

alias aa='arc add'
alias aaa='arc add --all'
alias aapa='arc add --patch'
alias aau='arc add --update'
alias aav='arc add --verbose'

# may shadow /usr/sbin/ab - Apache HTTP server benchmarking tool
alias ab='arc branch'
alias aba='arc branch --all'
alias abd='arc branch --delete'
alias abda='arc branch --merged | command grep -vE "^(\+|\*|\s*(trunk)\s*$)" | command xargs -n 1 arc branch -d'
alias abD='arc branch -D'
alias abl='arc blame'

# may shadow /usr/sbin/ac - display connect-time accounting
alias ac='arc commit'
alias ac!='arc commit --amend'
alias acn!='arc commit --no-edit --amend'
alias aca='arc commit --all'
alias aca!='arc commit --all --amend'
alias acan!='arc commit --all --no-edit --amend'
alias acam='arc commit --all --message'
alias acb='arc checkout -b'
alias aclean='arc clean -d'
alias apristine='arc reset --hard $(arc_current_branch) && arc clean -dx'
alias act='arc checkout trunk'
alias acmsg='arc commit --message'
alias aco='arc checkout'
alias acp='arc cherry-pick'
alias acpa='arc cherry-pick --abort'
alias acpc='arc cherry-pick --continue'
alias acps='arc cherry-pick --skip'

alias ad='arc diff'
alias adca='arc diff --cached'
alias ads='arc diff --staged'

alias af='arc fetch'
alias afa='arc fetch --all'

alias afg='arc ls-files | grep'

function agf() {
  [[ "$#" != 1 ]] && local b="$(arc_current_branch)"
  arc push --force "${b:=$1}"
}

alias agpull='arc pull "$(arc_current_branch)"'
alias agpush='arc push "$(arc_current_branch)"'

alias agsup='arc branch --set-upstream-to=arcadia/$(arc_current_branch)'
alias apsup='arc push --set-upstream arcadia $(arc_current_branch)'

alias al='arc pull'
alias alg='arc log --stat'
alias algg='arc log --graph'
alias algm='arc log --graph --max-count=10'
alias alo='arc log --oneline'
alias alols="arc log --graph --stat"
alias alog='arc log --oneline --graph'

# may shadow /usr/sbin/amt - Abstract Machine Test Utility
alias amt='arc mergetool --no-prompt'
alias amtvim='arc mergetool --no-prompt --tool=vimdiff'

alias ap='arc push'
alias apf!='arc push --force'

alias apr='arc pr'
alias aprc='arc pr create'
alias aprco='arc pr checkout'
alias aprl='arc pr list'
alias aprla='arc pr list --all'
alias aprv='arc pr view'

alias arb='arc rebase'
alias arba='arc rebase --abort'
alias arbc='arc rebase --continue'
alias arbi='arc rebase --interactive'
alias arbs='arc rebase --skip'
alias arev='arc revert'
alias arh='arc reset'
alias arhh='arc reset --hard'
alias aroh='arc reset arcadia/$(arc_current_branch) --hard'
alias arm='arc rm'
alias armc='arc rm --cached'
alias ars='arc restore'
alias arss='arc restore --source'
alias art='cd "$(arc root || echo .)"'
alias aru='arc reset --'

alias asb='arc status -sb'
alias ash='arc show'
alias ass='arc status -s'
alias ast='arc status'

alias astaa='arc stash apply'
alias astc='arc stash clear'
alias astd='arc stash drop'
alias astl='arc stash list'
alias astp='arc stash pop'
alias asts='arc stash show'

alias ats='arc tag -s'
alias atv='arc tag | sort -V'

alias aunwip='arc log -n 1 | grep -q -c "\-\-wip\-\-" && arc reset HEAD~1'
alias awip='arc add -A; arc rm $(arc ls-files --deleted) 2> /dev/null; arc commit --message "--wip-- [skip ci]"'
