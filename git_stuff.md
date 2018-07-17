# Git Tips #

## When done with branch update [<updatedbranch>] (and possibly merge with other branches [<otherbranch>]) ##
1. git checkout <updatedbranch> -> will say "Switched to branch '<updatedbranch>'"
2. git status -> will say "On branch <updatedbranch> ... ". If there are changes not staged for commit (with red text under it), it means you have to:
  1. git add .
  2. git status -> should be no red text anymore, changes to be committed should have green text under
  3. git commit -m " "
  4. Push to the branch you were working on
    1. git push -> if have already pushed to <updatedbranch>
    2. git push --set-upstream origin <updatedbranch> -> if first time pushing to <updatedbranch>
3. If you want to push <updatedbranch> to <otherbranch>:
  1. GO TO GITHUB
  2. do pull request (connect <otherbranch> to <updatedbranch>)
  3. make the request, delete <updatedbranch> if not using anymore
  4. git checkout <otherbranch> -> goes to <otherbranch>
  5. git pull

## Misc ##
**git checkout <branch>**    -> switches branches you're working in
**git branch <branch>**      -> creates new branch
**git checkout -b <branch>** -> creates new branch and switches into that new branch
**git branch -d <branch>**   -> deletes it locally (to delete remotely, go onto GitHub)
**git branch**               -> lists all branches in repo