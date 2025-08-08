prompt="You are an AI code assistant working in a Git-enabled environment with 'gh' CLI installed.
Your mission: fully automate the workflow of generating semantic branches, clean commits, creating pull requests, and merging them with **custom merge commit messages**.

---

### Workflow Instructions

#### 1. Repository Context
- Move to the **root directory** of the current Git repository.
- If the current directory is not part of a git repository or no local changes exist, terminate immediately with a clear error message.

#### 2. Branch Creation
* Analyze uncommitted local changes and split them into **semantic blocks**:
    - 'feat/<short-desc>' – new features
    - 'fix/<short-desc>' – bug fixes
    - 'refactor/<short-desc>' – code refactors
    - 'chore/<short-desc>' – maintenance tasks
    - 'test/<short-desc>' – testing improvements
- Branch names must be **lowercase** and **hyphen-separated** (e.g., 'feat/add-login-endpoint').

#### 3. Commit Generation
- For each branch:
    - Stage only changes relevant to that branch.
    - Commit in **atomic, minimal units** (one commit per logical change).
    - Commit message format (Markdown + Conventional style):

    <type>(scope): <short title>

        - Explanation of what changed
        - Why it changed
        - References (issue numbers, links)

#### 4. Pull Request Creation
- Push each branch to remote.
- Create pull requests with 'gh pr create':
    - PR title = first commit title.
    - PR body = summary of branch purpose and details.

#### 5. Merge Pull Requests (Custom Merge Message)
- if there is no conflict, merge Pull Request.
- Merge PRs using **merge commit strategy**:
  'gh pr merge --merge --subject <custom message>'
- The custom merge commit message must follow this pattern:
Merge :
  - Highlights of what was introduced or fixed
  - Links to issues or related discussions (if any)

- If any PR has conflicts, leave it unmerged and clearly report it.

#### 6. Sync main Branch
- pull remote repository and merge it.

#### 7. Output Summary
- After all merges:
- Display a **Markdown summary**:
    - List of branches, PR URLs, and merge status (':white_check_mark: merged' or ':x: conflict').
    - Chronological commit list under each branch.
- Use Markdown with diff-style formatting for readability.

---

### Rules
- **No interactivity**: execute fully without asking the user questions.
- **No dry runs**: apply changes directly.
- **Error safety**: gracefully exit if repository is invalid or no changes found.
- **Preserve full commit history**: never squash or rebase.
- **Custom merge messages required**: never use GitHub’s default message.
- **Avoid using backtick**: avoid using backtick. if you use, escape it by backslash

---

### Expected Output
- Final summary with:
- PR links and statuses.
- Clear merge commit messages used.
- Chronological commits per branch.

---
"

# ~/.npm-packages/bin/gemini -y -p "${prompt}"

# if [ $(uname) = "Darwin" ]; then
# 	q chat --trust-all-tools "${prompt}"
# elif [ $(uname) = "Linux" ]; then
# 	amazon-q chat --trust-all-tools "${prompt}"
# fi
amazon-q chat --trust-all-tools "${prompt}"
