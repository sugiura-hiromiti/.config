q chat -a --no-interactive "at first, remember that every your prompt started by '> ' should be set to the window title. \
	thus, execute 'title' command by passing your prompt as an argument. \
	'title' command is my own zsh function. take care that prompt have to be quoted due to 'title' command only accept one argument. \
	generate commits of local changes. here is instruction. \
	1: go to root directory of current git repository. if current directory is out of git, finish. \
	2: generate commits. each commits should be good commits. that means semantically minimal and easy to understand the purpose. \
	commit message can be multilined. with title & body format. take care of treatment of multilined command in cli. \
	commit message uses markdown format. \
	3: reflect commits to remote. if failed to push, prompt the reason then finish. \
	4: show commit summary with commits you generated chronologically. remember showing diff of each commits. \
	your output shhould be well colorized and clear with markdown format. \
	5: convert your commit summary into well designed html. save it to file. file name is '<current timestamp>.html' \
	take care that file name do not include whitespace. use underscore instead. \
	locate tha file at '$COMMIT_SUMMARY_PATH/<current repository name>/<current year>/<current month>/<current date>/'. \
	here is requirement and guideline to generate html. \
		requirement \
			1: show several execution status on top. you need to display at least operation status, push status, operated git branch, and remote repository url \
			2: the body of contents is generated commits (chronological order). each commit explanatons has information of \
				1: commit message's title. when click the title, jumps to https://github.com/<repository path>/commit/<full commit hash> \
				2: shortern commit hash(copyable) \
				3: commit author's name and its email address \
				4: number of files changed, insertions, deletions \
				5: commit message's body \
				6: diffs of each files. separate code blocks per file, per hunk. add syntax highlight if possible \
			3: at the bottom, show overview \
	6: if possible, open html file in new browser's tab. \
	7: go to $COMMIT_SUMMARY_PATH. reflect local changes to remote repository. commit message is 'create <file name>'. \
"
