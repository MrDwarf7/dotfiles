---
name: jj
description: "Comprehensive guide to using Jujutsu (jj) VCS for version control operations. Use when working with jj repositories, managing changes, branching, merging, or any VCS operations. Triggers on: jj commands, jujutsu workflow, version control with jj, jj help."
---

# Jujutsu (jj) Version Control System

Jujutsu is a modern version control system designed as a Git replacement that uses Git repositories as storage layer while providing superior UX and safety.

---

## The Job

1. Understand the current jj repository state and context
2. Execute appropriate jj commands for the task
3. Help agents transition from Git mental models to jj concepts
4. Provide guidance on jj-specific workflows and best practices

---

## Core Concepts

### Changes vs Commits

- **Git:** Separates working copy, staging area, and commits
- **jj:** Everything is a "change" - unified concept that includes working copy state
- **No staging area:** Modifications are automatically part of the current change

### Revision Identifiers

- `@` - Current working copy (like Git's HEAD)
- `@-` - Parent of current working copy
- `@+` - Child of current working copy
- `::` - Ancestor operator (like `..` in Git)
- `&` - Intersection operator
- `|` - Union operator
- `~` - Negation operator

### Immutable vs Mutable

- **Mutable changes:** Can be rewritten (default: not on main branches)
- **Immutable changes:** Protected from rewriting (default: on main branches)
- Use `--ignore-immutable` to override protection

---

## Essential Commands

### Repository Status

```bash
jj status              # Show repository status
jj log                 # Show commit history
jj show @              # Show current change details
jj diff                # Show working copy changes
```

### Creating Changes

```bash
# NEVER use `jj commit` for creating commits - use `jj new` instead
jj new                 # Create new empty change
jj describe -m "msg"   # Add message to current change
jj new "feature name"   # Create change with message
```

### Editing History

```bash
jj split <files>       # Split change by files
jj split               # Interactive split
jj squash              # Combine changes
jj rebase -r <from> -d <to>  # Rebase changes
jj edit <revision>      # Checkout specific change
```

### Bookmarks (Branches)

```bash
jj bookmark list        # List bookmarks
jj bookmark create <name>    # Create bookmark
jj bookmark move <name> --to @  # Move bookmark to current change
jj bookmark delete <name> # Delete bookmark
```

### Remote Operations

```bash
jj git fetch           # Pull from remote
jj git push            # Push to remote
jj git clone <url>     # Clone repository
jj git init            # Initialize new repo
```

---

## Critical Workflows

### Daily Development Workflow

1. **Start work:** `jj new` or `jj new "feature description"`
2. **Make changes:** Edit files (changes auto-tracked)
3. **Review:** `jj diff` and `jj status`
4. **Save work:** `jj describe -m "implement feature"`
5. **Repeat:** Create new changes as needed
6. **Push:** `jj bookmark move feature --to @ && jj git push`

### Working with Existing Changes

```bash
# Check current state
jj status

# If there are existing changes, review and describe them
jj describe -m "summary of existing work"

# OR create new change for fresh work
jj new "fresh task description"
```

### Commit Management

```bash
# Split large changes into smaller ones
jj split src/config/file1.ts -m "feat: update file1"

# Combine related changes
jj squash -into @- -m "feat: combined feature"

# Move change to different parent
jj rebase -r @ -d main
```

### Branch Management

```bash
# Create feature branch
jj bookmark create feature-name

# Move branch to current change
jj bookmark move feature-name --to @

# Move to different change
jj bookmark move feature-name --to specific-revision
```

---

## Self-Teaching Documentation Access

### Built-in Help System

```bash
jj help                # Main help
jj help <command>      # Command-specific help
jj help -k tutorial    # Tutorial access
jj help -k bookmarks   # Bookmark concepts
jj help -k revsets     # Revision selector language
```

### Key Help Topics

- `jj help -k bookmarks` - Bookmark management
- `jj help -k revsets` - Revision selection syntax
- `jj help -k templates` - Output formatting
- `jj help -k conflicts` - Conflict resolution
- `jj help -k operation-log` - Operation history

### Learning Commands

```bash
jj operation log        # Show operation history
jj operation undo      # Undo last operation
jj op show <id>       # Show specific operation details
```

---

## Git to JJ Command Mapping

| Git Command               | JJ Equivalent                                   | Notes                      |
| ------------------------- | ----------------------------------------------- | -------------------------- |
| `git status`              | `jj status`                                     | More detailed output       |
| `git log`                 | `jj log`                                        | Uses revsets for filtering |
| `git add . && git commit` | `jj describe`                                   | No staging needed          |
| `git checkout -b branch`  | `jj new && jj bookmark create branch`           | Two-step process           |
| `git checkout branch`     | `jj edit branch`                                | Edits any revision         |
| `git commit --amend`      | `jj describe`                                   | Edit current change        |
| `git rebase -i`           | `jj rebase`                                     | More flexible              |
| `git cherry-pick`         | `jj new <commit> && jj rebase -r @ -d HEAD`     |                            |
| `git branch`              | `jj bookmark list`                              | Bookmarks vs branches      |
| `git push origin branch`  | `jj bookmark move branch --to @ && jj git push` |                            |
| `git pull`                | `jj git fetch`                                  |                            |

---

## Safety Features

### Operation Log

- Every command is logged and reversible
- `jj operation undo` undoes last operation
- `jj operation log` shows full history
- `jj op restore <id>` restores to any state

### No Detached HEAD

- Checking out any revision creates a new working copy commit
- Cannot lose work by checking out old commits
- Safe exploration of history

### Conflict Resolution

- Conflicts are clearly marked and manageable
- `jj resolve` opens merge tool
- Multiple resolution strategies available

---

## Configuration

### Essential Settings

```bash
jj config set user.name "Your Name"
jj config set user.email "your@email.com"
jj config set ui.default-description-template "type: {commit_type}\n\n{description}"
```

### Useful Aliases

```bash
jj config set alias.st "status"
jj config set alias.co "edit"
jj config set alias.ci "describe"
```

---

## Troubleshooting

### Common Issues

1. **"Cannot edit immutable change"**
   - Use `--ignore-immutable` flag
   - Or work on mutable changes

2. **"Divergent operations"**
   - Use `jj operation log` to see conflicts
   - Choose which to keep with `jj operation abandon`

3. **Conflicted bookmarks**
   - Resolve with `jj bookmark resolve`
   - Or use `jj bookmark forget` to reset

### Recovery Commands

```bash
jj operation undo      # Undo last mistake
jj git refresh        # Sync with Git backend
jj workspace update-stale  # Fix workspace issues
```

---

## Integration Patterns

### With Git Remotes

- jj stores changes in Git format internally
- `jj git push` converts jj changes to Git commits
- `jj git fetch` imports Git commits as jj changes
- Can work alongside Git users seamlessly

### CI/CD Integration

- Use `jj git export` before CI runs
- Most CI tools work with exported Git repo
- Bookmark names become branch names in Git

---

## Best Practices

### Change Organization

- Keep changes small and focused
- Use descriptive messages with conventional commit format
- Split large changes before finalizing
- Use bookmarks for long-lived work

### Workflow Tips

1. **Always `jj status` before major operations**
2. **Use `jj new` for fresh work**
3. **Describe changes frequently**
4. **Move bookmarks when work is complete**
5. **Push regularly to share progress**

### Safety Rules

1. **NEVER use `jj commit`** - use `jj new` + `jj describe`
2. **Always check `jj status` before new work**
3. **Use operation log to recover from mistakes**
4. **Test with `jj git push --dry-run` before pushing**

---

## Advanced Features

### Revsets for Complex Selection

```bash
jj log -r "description(glob:'feat:*')"      # Features only
jj log -r "::@ & mutable()"                 # Mutable ancestors
jj log -r "heads(main..)"                   # Unmerged changes
```

### Parallel Development

```bash
jj parallelize       # Make changes siblings
jj new -p @ -p @-   # New change with multiple parents
```

### Templates for Custom Output

```bash
jj log -T 'commit_id.short() ++ " " ++ description'  # Custom format
jj status -T 'modify_count ++ " modified files"'    # Custom status
```

---

## When to Use This Skill

Use this skill when you need to:

- Work with jj repositories
- Convert from Git workflows to jj
- Manage complex version control operations
- Resolve conflicts or recover from mistakes
- Set up jj configuration
- Understand jj-specific concepts
- Automate VCS workflows with jj

---

## Quick Reference Commands

```bash
# Daily workflow
jj status              # Check state
jj new "task name"     # Start new work
jj describe -m "msg"    # Save work
jj bookmark move name --to @  # Tag work
jj git push            # Share work

# Recovery
jj operation undo      # Undo mistake
jj git refresh        # Sync backend
jj workspace update-stale  # Fix workspace

# Exploration
jj help -k <topic>    # Learn
jj operation log      # History
jj log -r <revset>   # Filter history
```

---

Remember: jj prioritizes safety and flexibility over Git compatibility. Embrace the operation log and immutable-by-default design patterns for optimal workflow.

