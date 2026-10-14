# Day 24 Advanced Git: Merge, Rebase, Stash

## Task 1

1. observe the git do fast-forward merge or a megerge commit 


- git does the fast-forward commit in main branch of feature branch.

- because `main` branch had not diverged form 'feature-login' not merge commit.


2 - **what is fast-forward merge** ?

- fast forward merge mens when you create feacture branch from main and write commites in feature and then you merge in main then its easily merge this is fast forward.

  - ***what does git create a merge commit ?***

- the merge commit mens wheen you create feuture branch form main and then main write commit after creating feauture then you feature also done some commit the its merge to main feuture changes then its show you merge commit. because main is diveged after create feature branch.


- ***what is a merge conflict?**

- the conflict mens if we changes in both branches same file same line then show error of merge conflict




## Task 2

# git rebase

1. what does rebase actually do to your commits ?

- reabse put the feature branch commit on top of the latest commit form main.

2. how history diffrent form merge ?

- in merge they combine the bothe branch history seprate but in rebase it put clean history in one line without m commit make extra.

3. why should you never rebase commits that have been pushed and shared with others ?

- because if we pushed on github the rebase this then commit id will be change and it come difficulties in colaboraions.

- if anyone pull this branch histroy and i chages locally and push forcfully on github then after pushed team pull this they dont have latest change that time come problem thats way shared branchdes not use rebase.


4. when would use rebase vs merge.

- when you want a clean and liner commit history

- before merging a feature branch into main branch


# merge 

- use merge wheen you want preserve complete branch history 


- when working on shared branches with team.



# Task 3 


1. what does squash merging do 

- squash to multiple commit merng  in main branch then it do on commit of multiple commit it look clean and proper. if we dont't need small samll commit history.! !


2. when whould you use squash merge vs regular merge

- if we want multiple commit history which you commit small small commit add then you can use normal merge


- when you dont want small samall commit history insted of this you want one main commit to replace of it and look clear then use squash commit.



3. what is the trade-off of squshing


- tred-off the squsshing is benefits insted of samll samll changes comit we do on main commit in this under all commit. it look profecinall and clean main branch


- the disadvatages of squash tread-off we write one main commit whic is sqaush it look nice but but we lost the orignal changes later if devloper want debuge the code then i cant find which commit i add css page where i soolved buf in file like this typs of disadvanteges. !!





# Task 4


1. what is the diffrence between git stash pop and git stash apply


- **stash apply**
- restore stashed changes
- jepps the stash entry for future use


# - git stash pop

- rstore the stashed changes
- remove the stage entry after a sucessful restore

2. when would you use stash in a real world 


- when switching branches with unfinished work

- when handling urgent bug


- when we dont commit our file do anothere thigs or emergency work



# Task 5

1. what is cherry-pick do ?

- cheryy pick pick one one commit whic you want only and merge in your targt branch.


2. when you will use cherry pick 

- when i need to do specific commit merge in main branch then use cherry-pick


3. what can go wrong with cherry-picking


- dependencies from earlier commits may be missing


- conflicts may occur if the required files or code difference between branches



