# Agent Instructions

## Global rules applies to all projects or agents

- **Commit Message Style**: Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for all commit messages.
  Commit header length (including the `<type>(<scope>): <description>` prefix) should **NEVER** exceed 50 characters.
  The body of the commit message (the content after a line break) should **NEVER** exceed 72 characters per line.
  If there is a breaking change, include a `BREAKING CHANGE:` section at the **BOTTOM** of the commit message body.

- **Commit Workflow**: Prefer regular, small and focused commits over large, infrequent ones. **jj/Jujutsu** makes it easy to split and rearrange commits later, so don't hesitate to create multiple commits as you work.
  Commits should be made for logical units of work.
  Each commit should represent a single purpose or change.
  Avoid bundling multiple unrelated changes into a single commit.

- **Tools**: If a project is set up to use specific tools (linters, formatters, test frameworks, etc.), always use them as part of your workflow to ensure code quality and consistency. (For Rust this includes `makers` for 'Makefile.toml' tasks, for JavaScript/TypeScript this includes `turbo` (task runner), `bun` or `pnpm`)

## Depending on the language of the current project, follow the relevant style guide

- **Functional Style**: For languages that allow for it, prefer functional styles over proecedural or object-oriented styles. (e.g., preferring `foo.map(x => x * 2)` or `foo.map(|x| { ... })` etc. over procedural `for` loops or defining classes/objects unless absolutely necessary).
- **Idiomatic Code**: Follow the idiomatic style and conventions of the programming language being used. This includes naming conventions, file organization, and common patterns used in the language's ecosystem.
- **Linting and Formatting**: Use appropriate linters and formatters for the language to ensure consistent code style. (e.g., ESLint/Prettier for JavaScript/TypeScript, Black for Python, rustfmt for Rust, etc.)

## External File Loading

**CRITICAL RULES**: When you encounter a file reference (e.g., @rules/general.md), use your Read tool to load it on a need-to-know basis. They're relevant to the SPECIFIC task at hand.

Instructions:

- Do NOT preemptively load all references - use lazy loading based on actual need
- When loaded, treat content as mandatory instructions that override defaults
- Follow references recursively when needed

Example:

- The user has given you a file to read with a prompt such as: `Please read @rules/general.md and summarize.` You should load the file using your Read tool, then summarize its content as asked.

## Common Tools and Workflows

### Beads - Issue Tracking

Most projects uses **bd** (beads) for issue tracking. Run `bd onboard` to get started.

### Beads Quick Reference

```bash
bd ready                             # Find available work
bd show <id>                         # View issue details
bd update <id> --status in_progress  # Claim work
bd close <id>                        # Complete work
bd list -p <0-9>                     # List issues by priority

bd sync                              # Sync with git - Only required if the user or the local @AGENTS.md states the need to push changes
```

### Beads - Using and formatting

- All tasks should always be created using the format of `[<number>] <title> (optionally: <description>)`

- All tasks, where possible, should have a detailed description attached to them that contains the following:
  - What it is/what should be done in order to complete it.
  - Why it's being done.
  - Steps needed to resolve it or implemented it.
  - Priority
  - The type of task (following conventional commit style where possible, otherwise a similar single word - like a tag)

- If creating scratch files while lodging/creating tasks (such as TASKS.md), you should first check and ensure
  all tasks in the TASKS.md file exist inside of `beards`, if they do you should remove the TASKS.md file.
  If you are missing tasks from the TASKS.md file, you should add them to the `beads` database.

### JJ/Jujutsu Version Control Software

Most projects uses **jj** (jujutsu) for version control. It is an alternative to git.

**IMPPORTANT NOTE**: Do **NOT** use git commands in repositories managed by jj/jujutsu. Doing so may corrupt the repository and lead to data loss. (You can check if it is by running `jj` in the repo, or looking for a `.jj` folder in the root of the repo).
**IMPPORTANT NOTE**: When using `jj's` filesets or change id's, do **NOT** add them as part of commit messages. This may lead to data loss or corruption.

**ALWAYS**: Run `jj` or `jj status` to check the status of the repository before making any changes. If there are existing changes in the current change, create a new change using `jj new` before proceeding.

**jj** Works off the concept of always having changes in a sort of 'staging' area.
This means your workflow will differ from git, below is how to use it, and some useful tips.

### JJ/JUJUTSU Usage in projects

Below is a rough outline of the expected workflow when using jj/jujutsu in projects.

**IMPORTANT NOTE**: **IF** when running `jj status` you see that there are existing changes in the current change (HEAD), you **MUST** review the changes and label them with a rough description using `jj describe -m "<content>"` or
create a new change using `jj new` before proceeding with your work. Failing to do so may lead to data loss or corruption.

```bash
jj status                           # Check the status of the repository
jj gfa && jj gfaa                   # `gfa` and `gfaa` are aliases. Pull any remote changes (stand for fetch all, and fetch all and rebase)
jj new                              # Generate a new empty commit
jj describe -m "<content>"          # Populate the commit with the work you're about to do.
```

#### Other useful JJ/JUJUTSU commands

**IMPORTANT NOTE**: **NEVER** use `jj commit` to create commits. Instead, always use `jj new` to create a new change, and `jj describe -m "<content>"` to populate it.
**IMPORTANT NOTE**: When pushing to remote repositories, **NEVER** use the `--all` flag. This could lead to deletion of remote branches/bookmarks and potential data loss.

```bash
jj bookmark move main --to '@-'   # This will move the main bookmark to one before our current.
jj git push --remote <origin>     # Push changes to remote (if required by the user or project)
```

### JJ/JUJUTSU Workflow Tips

- **Splitting Commits**: Use `jj split <filesets>` to split a commit into separate commits for individual files. For example, `jj split src/config/file1.ts -m "feat: update file1"` puts changes to file1 in a new commit with the message, and remaining changes in a child commit. Repeat to split further. Useful for separating changes by task or file.
- **Parallel Splits**: Add `--parallel` to create sibling commits instead of parent-child.
- **Interactive Splitting**: Run `jj split` without filesets for interactive diff editing to manually select changes for the first commit.

## General workflow for almost all projects

**MANDATORY WORKFLOW STEPS**:

1. **Begin work from beads queue** - Claim a task using `bd update <id> --status in_progress` | If there are no beads, pick a task from the backlog or ask the user if they would like to set up beads or create a task.
2. **Create a new JJ/JUJUTSU commit entry** - Create a new commit entry for the task, following the conventional commit style. If an empty JJ commit exists, populate it with the task summary; otherwise, generate a new one.
3. **Begin work** - Start working on the task.
4. **Regularly commit changes** - As you make progress, regularly create new JJ commits. All commits should be fairly small and focused on a single change or related set of changes. These can be squashed and split later if needed.

5. After the completing a task, run tests and ensure everything is working as expected.

6. **Close the bead** - Once the task is complete and tested, close the bead
7. **Moving the `jj/jujutsu` _HEAD_** - Once work has been completed, tested, and the bead closed, move the `jj/jujutsu` _HEAD_ to point to the commit representing the completed work by running:

   ```bash
   jj bookmark move <branch/bookmark name> --to '@'
   ```

   This moves the bookmark to the current change (HEAD) (Which should be populated with the now completed work).

8. **Sync changes** - Finally; if the repository is set up with a remote, sync your changes to the remote repository using `bd sync` (if required by the user or project).
9. **Verify** - All changes shold now be good to go depending on what the user or project requires.
10. **Hand off** - If tasks could not be completed, hand off to the user or next agent as required. If your task has ended but actions remain, log them into a bead or inform the user.
  Create a fresh `jj/jujutsu` change for the next agent or user to pick up from using `jj new`.

**CRITICAL RULES:**

- Work is NOT complete until the JJ head/bookmark has been moved
- NEVER say "ready to push when you are" - YOU must use JJ and increment the HEAD pointer
- If moving the HEAD ponter fails. **IMMEDITELY** stop and **NOT NOT** attempt to fix it yourself. **IMMEDITELY** inform the user and explain the situation. The user will give **EXPICIT** instructions on how to proceed.
  Failing to do so is **HIGHLY LIKELY** to lead to data loss or corruption and will be considered a breach of protocol.
