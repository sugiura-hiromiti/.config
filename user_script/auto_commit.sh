prompt="you are professional of git. you also very good at coding. \
	generate commits of local changes. here is instruction. \
	1: go to root directory of current git repository. if current directory is out of git, finish. \
	2: classify all file changes by semantics of those changes have. and for each semantics, create branch.
	2: generate commits in each branch. all commits should be good commit. that means semantically minimal and easy to understand the purpose. \
	remember changes in a same file can be committed separatery per hunk. \
	commit message can be multilined. with title & body format. take care of treatment of multilined command in cli. \
	commit message uses markdown format. \
	4: reflect local changes to remove with creating Pull Request for each branch. \
"

if [ $(uname) = "Darwin" ]; then
elif [ $(uname) ="Linux" ]; then
fi


amazon-q chat -a  --no-interactive --model claude-3.7-sonnet
