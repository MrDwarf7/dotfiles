#!/usr/bin/env fish
#

# alias gst 'git status'
alias g "git $args"
alias ga "git add $args"
alias gaa "git add --all $args"
alias gapa "git add --patch $args"
alias gau "git add --update $args"
alias gb "git branch $args"
alias gba "git branch -a $args"
alias grl "git reglog -5 $args"
# gbda               
alias gbl "git blame -b -w $args"
alias gbnm "git branch --no-merged $args"
alias gbr "git branch --remote $args"
alias gbs "git bisect $args"
alias gbsb "git bisect bad $args"
alias gbsg "git bisect good $args"
alias gbsr "git bisect reset $args"
alias gbss "git bisect start $args"
alias gc "git commit -v $args"
alias gc! "git commit -v --amend $args"
alias gca "git commit -v -a $args"
alias gca! "git commit -v -a --amend $args"
alias gcam "git commit -a -m $args"
alias gcan! "git commit -v -a --no-edit --amend $args"
alias gcans! "git commit -v -a -s --no-edit --amend $args"
alias gcb "git checkout -b $args"
alias gcd "git checkout develop $args"
alias gcf "git config --list $args"
alias gcl "git clone --recursive $args"
alias gclean "git clean -df $args"
# gcm
alias gcmsg "git commit -m $args"
alias gcn! "git commit -v --no-edit --amend $args"
alias gco "git checkout $args"
alias gcount "git shortlog -sn $args"
alias gcp "git cherry-pick $args"
alias gcpa "git cherry-pick --abort $args"
alias gcpc "git cherry-pick --continue $args"
alias gcs "git commit -S $args"
alias gd "git diff $args"
alias gdca "git diff --cached $args"
alias gdt "git diff-tree --no-commit-id --name-only -r $args"
alias gdw "git diff --word-diff $args"
# Get-Git-MainBranch 
alias gf "git fetch $args"
alias gfa "git fetch --all --prune $args"
alias gfo "git fetch origin $args"
alias gg "git gui citool $args"
alias gga "git gui citool --amend $args"
# ggf   
# ggfl  
# ggl   
# ggp   
# ggsup 
alias ghh "git help $args"
alias gignore "git update-index --assume-unchanged $args"
alias gignored "git ls-files -v | Select-String "^[a-z]" -CaseSensitive"
alias gl "git pull $args"
alias glg "git log --stat --color $args"
alias glgg "git log --graph --color $args"
alias glgga "git log --graph --decorate --all $args"
alias glgm "git log --graph --max-count=10 $args"
alias glgp "git log --stat --color -p $args"
alias glo "git log --oneline --decorate --color $args"
alias glog "git log --oneline --decorate --color --graph $args"
alias gloga "git log --oneline --decorate --color --graph --all $args"
# glol
# glol
# glum
alias gm "git merge $args"
# gmom
alias gmt "git mergetool --no-prompt $args"
alias gmtvim "git mergetool --no-prompt --tool=vimdiff $args"
# gmum
alias gp "git push $args"
alias gpd "git push --dry-run $args"
alias gpf "git push --force-with-lease $args"
alias gpf! "git push --force $args"
alias gpoat "git push origin --all && git push origin --tags"
alias gpristine "git reset --hard && git clean -dfx"
# gpsup
alias gpu "git push upstream $args"
alias gpv "git push -v $args"
alias gr "git remote $args"
alias gra "git remote add $args"
alias grb "git rebase $args"
alias grba "git rebase --abort $args"
alias grbc "git rebase --continue $args"
alias grbi "git rebase -i $args"
# grbm
alias grbs "git rebase --skip $args"
alias grh "git reset $args"
alias grhh "git reset --hard $args"
alias grmv "git remote rename $args"
alias grrm "git remote remove $args"
alias grs "git restore $args"
alias grset "git remote set-url $args"
# grt
alias gru "git reset -- $args"
alias grup "git remote update $args"
alias grv "git remote -v $args"
alias gsb "git status -sb $args"
alias gsd "git svn dcommit $args"
alias gsh "git show $args"
alias gsi "git submodule init $args"
alias gsps "git show --pretty=short --show-signature $args"
alias gsr "git svn rebase $args"
alias gss "git status -s $args"
alias gst "git status $args"
alias gsta "git stash save $args"
alias gstaa "git stash apply $args"
alias gstc "git stash clear $args"
alias gstd "git stash drop $args"
alias gstl "git stash list $args"
alias gstp "git stash pop $args"
alias gsts "git stash show --text $args"
alias gsu "git submodule update $args"
alias gsw "git switch $args"
alias gts "git tag -s $args"
alias gunignore "git update-index --no-assume-unchanged $args"
# gunwip
alias gup "git pull --rebase $args"
alias gupv "git pull --rebase -v $args"
alias gvt "git verify-tag $args"
alias gwch "git whatchanged -p --abbrev-commit --pretty=medium $args"
# gwip

alias gfp "git fetch --all && git pull --all"

#
##### These will need to be functions (And converted to fish) #####
# as they store a variable during execution

# gbda               $MainBranch = Get-Git-MainBranch
#                    $MergedBranchs = $(git branch --merged | Select-String "^(\*|\s*($MainBranch|develop|dev)\s*$)" -NotMatch).Line
#                    $MergedBranchs | ForEach-Object {
#                         if ([string]::IsNullOrEmpty($_)) {
#                                 return
#                         }
#                         git branch -d $_.Trim()
#                    }
#
#
# gcm                $MainBranch = Get-Git-MainBranch
#                    git checkout $MainBranch $args
#
#
# Get-Git-MainBranch git rev-parse --git-dir *> $null
#
#                    if ($LASTEXITCODE -ne 0) {
#                        return
#                    }
#                    $branches = @('main', 'trunk')
#                    foreach ($branch in $branches) {
#                        & git show-ref -q --verify refs/heads/$branch
#
#                        if ($LASTEXITCODE -eq 0) {
#                            return $branch
#                        }
#                    }
#                    return 'master'
#
# ggf                $CurrentBranch = Get-Git-CurrentBranch
#                    git push --force origin $CurrentBranch
#
# ggfl               $CurrentBranch = Get-Git-CurrentBranch
#                    git push --force-with-lease origin $CurrentBranch
#
# ggl                $CurrentBranch = Get-Git-CurrentBranch
#                    git pull origin $CurrentBranch
#
# ggp                $CurrentBranch = Get-Git-CurrentBranch
#                    git push origin $CurrentBranch
#
# ggsup              $CurrentBranch = Get-Git-CurrentBranch
#                    git branch --set-upstream-to=origin/$CurrentBranch
#
# glol               git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
#                    $args
#
# glola              git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
#                    --all $args
#
# glum               $MainBranch = Get-Git-MainBranch
#                    git pull upstream $MainBranch $args
#
# gmom               $MainBranch = Get-Git-MainBranch
#                    git merge origin/$MainBranch $args
#
# gmum               $MainBranch = Get-Git-MainBranch
#                    git merge upstream/$MainBranch $args
#
# gpsup              $CurrentBranch = Get-Git-CurrentBranch
#                    git push --set-upstream origin $CurrentBranch
#
# grbm               $MainBranch = Get-Git-MainBranch
#                    git rebase $MainBranch $args
#
# grt                try {
#                         $RootPath = git rev-parse --show-toplevel
#                    }
#                    catch {
#                         $RootPath = "."
#                    }
#                    Set-Location $RootPath
#
# gunwip             Write-Output $(git log -n 1 | Select-String "--wip--" -Quiet).Count
#                    git reset HEAD~1
#
# gwip               git add -A
#                    git rm $(git ls-files --deleted) 2> $null
#                    git commit --no-verify -m "--wip-- [skip ci]"
#
#
#
