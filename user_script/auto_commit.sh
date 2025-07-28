prompt="generate commits of local changes. here is instruction. \
	1: go to root directory of current git repository. if current directory is out of git, finish. \
	2: create branches for changes. you should create several branches to keep git history to be clean. \
	each branch represents one block of semantics within changes. \
	2: generate commits at each branches. each commits should be good commit. that means semantically minimal and easy to understand the purpose. \
	commit message can be multilined. with title & body format. take care of treatment of multilined command in cli. \
	commit message uses markdown format. \
	3: create Pull Request for each branches. you can use 'gh' command which is installed in this environment. \
	you should reflect local changes to remote. \
	Merging work should be done by me in PR page of remote repository site in github. \
	4: show commit summary with branches you created and chronological list of commits you generated. \
	your output shhould be well colorized and clear with markdown format. \
"

if [ $(uname) = "Darwin" ]; then
	q chat --trust-all-tools "${prompt}"
elif [ $(uname) = "Linux" ]; then
	amazon-q chat --trust-all-tools --no-interactive "${prompt}"
fi


