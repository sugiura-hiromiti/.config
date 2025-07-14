q chat -a --no-interactive "generate commits of local changes. here is instruction. \
	1: go to root directory of current git repository. if current directory is out of git, finish. \
	2: generate commits. each commits should be good commits. that means semantically minimal and easy to understand the purpose. \
	commit message can be multilined. with title & body format. take care of treatment of multilined command in cli. \
	commit message uses markdown format. \
	3: reflect commits to remote. if failed to push, prompt the reason then finish. \
	4: show commit summary with commits you generated chronologically. remember showing diff of each commits. \
	your output shhould be well colorized and clear with markdown format. \
	5: convert your commit summary into well designed html. save it to 'commit_summary.html'. \
	6: if possible, open 'commit_summary.html' in new browser's tab \
"
