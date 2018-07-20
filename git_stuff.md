# Git Tips #
- Git merge doc: https://www.atlassian.com/git/tutorials/using-branches/git-merge
- pbxproj trash: https://stackoverflow.com/questions/37407969/how-to-solve-conflicts-about-project-pbxproj-in-xcode-use-git (see below for specific details)
- ignore a git file: https://stackoverflow.com/questions/4475457/add-all-files-to-a-commit-except-a-single-file

## When done with branch update [updatedbranch] (and possibly merge with other branches [otherbranch]) ##
1. git checkout **updatedbranch** -> will say "Switched to branch '**updatedbranch**'"
2. git status -> will say "On branch **updatedbranch**... ". If there are changes not staged for commit (with red text under it), it means you have to:
  1. git add .
  2. git status -> should be no red text anymore, changes to be committed should have green text under
  3. git commit -m " "
  4. Push to the branch you were working on
    1. git push -> if have already pushed to **updatedbranch**
    2. git push --set-upstream origin **updatedbranch** -> if first time pushing to **updatedbranch**
3. If you want to push **updatedbranch** to **otherbranch**:
  1. GO TO GITHUB
  2. do pull request (connect **otherbranch** to **updatedbranch**)
  3. make the request, delete **updatedbranch** if not using anymore (make sure you also delete it locally)
  4. git checkout **otherbranch** -> goes to **otherbranch**
  5. git pull

## .pbxproj trash ##
Use Kin (https://github.com/Karumi/Kin) to find trash in the .pbxproj:
1. /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
2. brew install python@2
3. Download zip file from the Kin github repo https://github.com/Karumi/Kin
4. Go into the unzipped zip file (Downloads/Kin-master)
5. pip2 install kin
6. python setup.py install -> if this results in an error then run:
  1. hash -r python
  2. python setup.py install
  
And you're done! To use kin, just run "kin" in your project directory. Alternatively, you can have it find the project yourself by running "kin ItemShareApp/item-share-app.xcodeproj/project.pbxproj"

## please enter commit message to explain why merge is necessary BS"
It's bc it uses a certain editor for this, and so you have to play along with the editor's rules:
1. press "i"
2. enter merge message
3. press "esc"
4. write ":wq"
5. press enter

b o o m

## Misc ##
- **git checkout branchname**                        -> switches branches you're working in
- **git branch branchname**                          -> creates new branch
- **git checkout -b branchname**                     -> creates new branch and switches into that new branch
- **git branch -d branchname**                       -> deletes it locally (to delete remotely, go onto GitHub)
- **git branch**                                     -> lists all branches in repo
- **git checkout -b newbranch existingbranch**       -> bases newbranch off of existingbranch
- **git add .**\                                     -> after adding all files, will undo the addition of a file
  **git reset -- filename**                    
- **git update-index --assume-unchanged "filename"** -> git will start ignoring changes to a file

