
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'gix' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'gix'
    for ($i = 1; $i -lt $commandElements.Count; $i++) {
      $element = $commandElements[$i]
      if ($element -isnot [StringConstantExpressionAst] -or
        $element.StringConstantType -ne [StringConstantType]::BareWord -or
        $element.Value.StartsWith('-') -or
        $element.Value -eq $wordToComplete) {
        break
      }
      $element.Value
    }) -join ';'

  $completions = @(switch ($command) {
      'gix' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'The repository to access')
        [CompletionResult]::new('--repository', '--repository', [CompletionResultType]::ParameterName, 'The repository to access')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Add these values to the configuration in the form of `key=value` or `key`')
        [CompletionResult]::new('--config', '--config', [CompletionResultType]::ParameterName, 'Add these values to the configuration in the form of `key=value` or `key`')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'The amount of threads to use for some operations')
        [CompletionResult]::new('--threads', '--threads', [CompletionResultType]::ParameterName, 'The amount of threads to use for some operations')
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Determine the format to use when outputting statistics')
        [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Determine the format to use when outputting statistics')
        [CompletionResult]::new('--object-hash', '--object-hash', [CompletionResultType]::ParameterName, 'The object format to assume when reading files that don''t inherently know about it, or when writing files')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Display verbose messages and progress information')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Display verbose messages and progress information')
        [CompletionResult]::new('--trace', '--trace', [CompletionResultType]::ParameterName, 'Display structured `tracing` output in a tree-like structure')
        [CompletionResult]::new('--no-verbose', '--no-verbose', [CompletionResultType]::ParameterName, 'Turn off verbose message display for commands where these are shown by default')
        [CompletionResult]::new('--progress', '--progress', [CompletionResultType]::ParameterName, 'Bring up a terminal user interface displaying progress visually')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Don''t default malformed configuration flags, but show an error instead. Ignore IO errors as well')
        [CompletionResult]::new('--strict', '--strict', [CompletionResultType]::ParameterName, 'Don''t default malformed configuration flags, but show an error instead. Ignore IO errors as well')
        [CompletionResult]::new('--progress-keep-open', '--progress-keep-open', [CompletionResultType]::ParameterName, 'The progress TUI will stay up even though the work is already completed')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
        [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
        [CompletionResult]::new('archive', 'archive', [CompletionResultType]::ParameterValue, 'Subcommands for creating worktree archives')
        [CompletionResult]::new('clean', 'clean', [CompletionResultType]::ParameterValue, 'clean')
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('odb', 'odb', [CompletionResultType]::ParameterValue, 'Interact with the object database')
        [CompletionResult]::new('fsck', 'fsck', [CompletionResultType]::ParameterValue, 'Check for missing objects')
        [CompletionResult]::new('tree', 'tree', [CompletionResultType]::ParameterValue, 'Interact with tree objects')
        [CompletionResult]::new('commit', 'commit', [CompletionResultType]::ParameterValue, 'Interact with commit objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of the entire repository')
        [CompletionResult]::new('revision', 'revision', [CompletionResultType]::ParameterValue, 'Query and obtain information about revisions')
        [CompletionResult]::new('rev', 'rev', [CompletionResultType]::ParameterValue, 'Query and obtain information about revisions')
        [CompletionResult]::new('r', 'r', [CompletionResultType]::ParameterValue, 'Query and obtain information about revisions')
        [CompletionResult]::new('credential', 'credential', [CompletionResultType]::ParameterValue, 'A program just like `git credential`')
        [CompletionResult]::new('fetch', 'fetch', [CompletionResultType]::ParameterValue, 'Fetch data from remotes and store it in the repository')
        [CompletionResult]::new('clone', 'clone', [CompletionResultType]::ParameterValue, 'clone')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Interact with the mailmap')
        [CompletionResult]::new('remote', 'remote', [CompletionResultType]::ParameterValue, 'Interact with the remote hosts')
        [CompletionResult]::new('remotes', 'remotes', [CompletionResultType]::ParameterValue, 'Interact with the remote hosts')
        [CompletionResult]::new('attributes', 'attributes', [CompletionResultType]::ParameterValue, 'Interact with the attribute files like .gitattributes')
        [CompletionResult]::new('attrs', 'attrs', [CompletionResultType]::ParameterValue, 'Interact with the attribute files like .gitattributes')
        [CompletionResult]::new('exclude', 'exclude', [CompletionResultType]::ParameterValue, 'Interact with the exclude files like .gitignore')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'index')
        [CompletionResult]::new('submodule', 'submodule', [CompletionResultType]::ParameterValue, 'Interact with submodules')
        [CompletionResult]::new('is-clean', 'is-clean', [CompletionResultType]::ParameterValue, 'is-clean')
        [CompletionResult]::new('is-changed', 'is-changed', [CompletionResultType]::ParameterValue, 'is-changed')
        [CompletionResult]::new('config-tree', 'config-tree', [CompletionResultType]::ParameterValue, 'Show which git configuration values are used or planned')
        [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'compute repository status similar to `git status`')
        [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'Print all entries in a configuration file or access other sub-commands')
        [CompletionResult]::new('corpus', 'corpus', [CompletionResultType]::ParameterValue, 'run algorithms on a corpus of git repositories and store their results for later analysis')
        [CompletionResult]::new('merge-base', 'merge-base', [CompletionResultType]::ParameterValue, 'A command for calculating all merge-bases')
        [CompletionResult]::new('worktree', 'worktree', [CompletionResultType]::ParameterValue, 'Commands for handling worktrees')
        [CompletionResult]::new('free', 'free', [CompletionResultType]::ParameterValue, 'Subcommands that need no git repository to run')
        [CompletionResult]::new('no-repo', 'no-repo', [CompletionResultType]::ParameterValue, 'Subcommands that need no git repository to run')
        [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
        [CompletionResult]::new('generate-completions', 'generate-completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
        [CompletionResult]::new('shell-completions', 'shell-completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;archive' {
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Explicitly set the format. Otherwise derived from the suffix of the output file')
        [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Explicitly set the format. Otherwise derived from the suffix of the output file')
        [CompletionResult]::new('--prefix', '--prefix', [CompletionResultType]::ParameterName, 'Apply the prefix verbatim to any path we add to the archive. Use a trailing `/` if prefix is a directory')
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'The compression strength to use for `.zip` and `.tar.gz` archives, valid from 0-9')
        [CompletionResult]::new('--compression-level', '--compression-level', [CompletionResultType]::ParameterName, 'The compression strength to use for `.zip` and `.tar.gz` archives, valid from 0-9')
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Add the given path to the archive. Directories will always be empty')
        [CompletionResult]::new('--add-path', '--add-path', [CompletionResultType]::ParameterName, 'Add the given path to the archive. Directories will always be empty')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Add the new file from a slash-separated path, which must happen in pairs of two, first the path, then the content')
        [CompletionResult]::new('--add-virtual-file', '--add-virtual-file', [CompletionResultType]::ParameterName, 'Add the new file from a slash-separated path, which must happen in pairs of two, first the path, then the content')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;clean' {
        [CompletionResult]::new('--skip-hidden-repositories', '--skip-hidden-repositories', [CompletionResultType]::ParameterName, 'Enter ignored directories to skip repositories contained within')
        [CompletionResult]::new('--find-untracked-repositories', '--find-untracked-repositories', [CompletionResultType]::ParameterName, 'What kind of repositories to find inside of untracked directories')
        [CompletionResult]::new('--debug', '--debug', [CompletionResultType]::ParameterName, 'Print additional debug information to help understand decisions it made')
        [CompletionResult]::new('-n', '-n', [CompletionResultType]::ParameterName, 'A dummy to easy with muscle-memory. This flag is assumed if provided or not, and has no effect')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'A dummy to easy with muscle-memory. This flag is assumed if provided or not, and has no effect')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Actually perform the operation, which deletes files on disk without chance of recovery')
        [CompletionResult]::new('--execute', '--execute', [CompletionResultType]::ParameterName, 'Actually perform the operation, which deletes files on disk without chance of recovery')
        [CompletionResult]::new('-x', '-x', [CompletionResultType]::ParameterName, 'Remove ignored (and expendable) files')
        [CompletionResult]::new('--ignored', '--ignored', [CompletionResultType]::ParameterName, 'Remove ignored (and expendable) files')
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Remove precious files')
        [CompletionResult]::new('--precious', '--precious', [CompletionResultType]::ParameterName, 'Remove precious files')
        [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'Remove whole directories')
        [CompletionResult]::new('--directories', '--directories', [CompletionResultType]::ParameterName, 'Remove whole directories')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Remove nested repositories, even outside ignored directories')
        [CompletionResult]::new('--repositories', '--repositories', [CompletionResultType]::ParameterName, 'Remove nested repositories, even outside ignored directories')
        [CompletionResult]::new('-m', '-m', [CompletionResultType]::ParameterName, 'Pathspec patterns are used to match the result of the dirwalk, not the dirwalk itself')
        [CompletionResult]::new('--pathspec-matches-result', '--pathspec-matches-result', [CompletionResultType]::ParameterName, 'Pathspec patterns are used to match the result of the dirwalk, not the dirwalk itself')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;commit-graph' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all entries in the commit-graph as reachable by starting from `HEAD`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;commit-graph;verify' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'output statistical information about the pack')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'output statistical information about the pack')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;commit-graph;list' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;commit-graph;help' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all entries in the commit-graph as reachable by starting from `HEAD`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;commit-graph;help;verify' {
        break
      }
      'gix;commit-graph;help;list' {
        break
      }
      'gix;commit-graph;help;help' {
        break
      }
      'gix;odb' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all object names')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Provide general information about the object database')
        [CompletionResult]::new('stats', 'stats', [CompletionResultType]::ParameterValue, 'Count and obtain information on all, possibly duplicate, objects in the database')
        [CompletionResult]::new('statistics', 'statistics', [CompletionResultType]::ParameterValue, 'Count and obtain information on all, possibly duplicate, objects in the database')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;odb;entries' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;odb;info' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;odb;stats' {
        [CompletionResult]::new('--extra-header-lookup', '--extra-header-lookup', [CompletionResultType]::ParameterName, 'Lookup headers again, but without preloading indices')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;odb;statistics' {
        [CompletionResult]::new('--extra-header-lookup', '--extra-header-lookup', [CompletionResultType]::ParameterName, 'Lookup headers again, but without preloading indices')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;odb;help' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all object names')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Provide general information about the object database')
        [CompletionResult]::new('stats', 'stats', [CompletionResultType]::ParameterValue, 'Count and obtain information on all, possibly duplicate, objects in the database')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;odb;help;entries' {
        break
      }
      'gix;odb;help;info' {
        break
      }
      'gix;odb;help;stats' {
        break
      }
      'gix;odb;help;help' {
        break
      }
      'gix;fsck' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;tree' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print entries in a given tree')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Provide information about a tree')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;tree;entries' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Traverse the entire tree and its subtrees respectively, not only this tree')
        [CompletionResult]::new('--recursive', '--recursive', [CompletionResultType]::ParameterName, 'Traverse the entire tree and its subtrees respectively, not only this tree')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Provide files size as well. This is expensive as the object is decoded entirely')
        [CompletionResult]::new('--extended', '--extended', [CompletionResultType]::ParameterName, 'Provide files size as well. This is expensive as the object is decoded entirely')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;tree;info' {
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Provide files size as well. This is expensive as the object is decoded entirely')
        [CompletionResult]::new('--extended', '--extended', [CompletionResultType]::ParameterName, 'Provide files size as well. This is expensive as the object is decoded entirely')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;tree;help' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print entries in a given tree')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Provide information about a tree')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;tree;help;entries' {
        break
      }
      'gix;tree;help;info' {
        break
      }
      'gix;tree;help;help' {
        break
      }
      'gix;commit' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the signature of a commit')
        [CompletionResult]::new('describe', 'describe', [CompletionResultType]::ParameterValue, 'Describe the current commit or the given one using the name of the closest annotated tag in its ancestry')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;commit;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;commit;describe' {
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Consider only the given `n` candidates. This can take longer, but potentially produces more accurate results')
        [CompletionResult]::new('--max-candidates', '--max-candidates', [CompletionResultType]::ParameterName, 'Consider only the given `n` candidates. This can take longer, but potentially produces more accurate results')
        [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'Set the suffix to append if the repository is dirty (not counting untracked files)')
        [CompletionResult]::new('--dirty-suffix', '--dirty-suffix', [CompletionResultType]::ParameterName, 'Set the suffix to append if the repository is dirty (not counting untracked files)')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'Use annotated tag references only, not all tags')
        [CompletionResult]::new('--annotated-tags', '--annotated-tags', [CompletionResultType]::ParameterName, 'Use annotated tag references only, not all tags')
        [CompletionResult]::new('-a', '-a', [CompletionResultType]::ParameterName, 'Use all references under the `ref/` namespaces, which includes tag references, local and remote branches')
        [CompletionResult]::new('--all-refs', '--all-refs', [CompletionResultType]::ParameterName, 'Use all references under the `ref/` namespaces, which includes tag references, local and remote branches')
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Only follow the first parent when traversing the commit graph')
        [CompletionResult]::new('--first-parent', '--first-parent', [CompletionResultType]::ParameterName, 'Only follow the first parent when traversing the commit graph')
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Always display the long format, even if that would not be necessary as the id is located directly on a reference')
        [CompletionResult]::new('--long', '--long', [CompletionResultType]::ParameterName, 'Always display the long format, even if that would not be necessary as the id is located directly on a reference')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print information on stderr to inform about performance statistics')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print information on stderr to inform about performance statistics')
        [CompletionResult]::new('--always', '--always', [CompletionResultType]::ParameterName, 'If there was no way to describe the commit, fallback to using the abbreviated input revision')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;commit;help' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the signature of a commit')
        [CompletionResult]::new('describe', 'describe', [CompletionResultType]::ParameterValue, 'Describe the current commit or the given one using the name of the closest annotated tag in its ancestry')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;commit;help;verify' {
        break
      }
      'gix;commit;help;describe' {
        break
      }
      'gix;commit;help;help' {
        break
      }
      'gix;verify' {
        [CompletionResult]::new('-a', '-a', [CompletionResultType]::ParameterName, 'The algorithm used to verify packs. They differ in costs')
        [CompletionResult]::new('--algorithm', '--algorithm', [CompletionResultType]::ParameterName, 'The algorithm used to verify packs. They differ in costs')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'output statistical information')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'output statistical information')
        [CompletionResult]::new('--decode', '--decode', [CompletionResultType]::ParameterName, 'Decode and parse tags, commits and trees to validate their correctness beyond hashing correctly')
        [CompletionResult]::new('--re-encode', '--re-encode', [CompletionResultType]::ParameterName, 'Decode and parse tags, commits and trees to validate their correctness, and re-encode them')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;revision' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('l', 'l', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('e', 'e', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('parse', 'parse', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('p', 'p', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('prev', 'prev', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;rev' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('l', 'l', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('e', 'e', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('parse', 'parse', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('p', 'p', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('prev', 'prev', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;r' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('l', 'l', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('e', 'e', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('parse', 'parse', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('p', 'p', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('prev', 'prev', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;revision;list' {
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('--svg', '--svg', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;revision;l' {
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('--svg', '--svg', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;rev;list' {
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('--svg', '--svg', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;rev;l' {
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('--svg', '--svg', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;r;list' {
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('--svg', '--svg', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;r;l' {
        [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('--limit', '--limit', [CompletionResultType]::ParameterName, 'How many commits to list at most')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('--svg', '--svg', [CompletionResultType]::ParameterName, 'Write the graph as SVG file to the given path')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;revision;explain' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;revision;e' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;rev;explain' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;rev;e' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;r;explain' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;r;e' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;revision;resolve' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;revision;query' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;revision;parse' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;revision;p' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;rev;resolve' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;rev;query' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;rev;parse' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;rev;p' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;r;resolve' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;r;query' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;r;parse' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;r;p' {
        [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('--blob-format', '--blob-format', [CompletionResultType]::ParameterName, 'How to display blobs')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('--tree-mode', '--tree-mode', [CompletionResultType]::ParameterName, 'How to display trees as obtained with `@:dirname` or `@^{tree}`')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('--explain', '--explain', [CompletionResultType]::ParameterName, 'Instead of resolving a rev-spec, explain what would be done for the first spec')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'Also show the name of the reference which led to the object')
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('--cat-file', '--cat-file', [CompletionResultType]::ParameterName, 'Show the first resulting object similar to how `git cat-file` would, but don''t show the resolved spec')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;revision;previous-branches' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;revision;prev' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;rev;previous-branches' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;rev;prev' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;r;previous-branches' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;r;prev' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;revision;help' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;revision;help;list' {
        break
      }
      'gix;revision;help;explain' {
        break
      }
      'gix;revision;help;resolve' {
        break
      }
      'gix;revision;help;previous-branches' {
        break
      }
      'gix;revision;help;help' {
        break
      }
      'gix;rev;help' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;rev;help;list' {
        break
      }
      'gix;rev;help;explain' {
        break
      }
      'gix;rev;help;resolve' {
        break
      }
      'gix;rev;help;previous-branches' {
        break
      }
      'gix;rev;help;help' {
        break
      }
      'gix;r;help' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;r;help;list' {
        break
      }
      'gix;r;help;explain' {
        break
      }
      'gix;r;help;resolve' {
        break
      }
      'gix;r;help;previous-branches' {
        break
      }
      'gix;r;help;help' {
        break
      }
      'gix;credential' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('fill', 'fill', [CompletionResultType]::ParameterValue, 'Get the credentials fed for `url=<url>` via STDIN')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the credentials fed for `url=<url>` via STDIN')
        [CompletionResult]::new('approve', 'approve', [CompletionResultType]::ParameterValue, 'Approve the information piped via STDIN as obtained with last call to `fill`')
        [CompletionResult]::new('store', 'store', [CompletionResultType]::ParameterValue, 'Approve the information piped via STDIN as obtained with last call to `fill`')
        [CompletionResult]::new('reject', 'reject', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('erase', 'erase', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;credential;fill' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;credential;get' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;credential;approve' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;credential;store' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;credential;reject' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;credential;erase' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;credential;help' {
        [CompletionResult]::new('fill', 'fill', [CompletionResultType]::ParameterValue, 'Get the credentials fed for `url=<url>` via STDIN')
        [CompletionResult]::new('approve', 'approve', [CompletionResultType]::ParameterValue, 'Approve the information piped via STDIN as obtained with last call to `fill`')
        [CompletionResult]::new('reject', 'reject', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;credential;help;fill' {
        break
      }
      'gix;credential;help;approve' {
        break
      }
      'gix;credential;help;reject' {
        break
      }
      'gix;credential;help;help' {
        break
      }
      'gix;fetch' {
        [CompletionResult]::new('-g', '-g', [CompletionResultType]::ParameterName, 'Open the commit graph used for negotiation and write an SVG file to PATH')
        [CompletionResult]::new('--open-negotiation-graph', '--open-negotiation-graph', [CompletionResultType]::ParameterName, 'Open the commit graph used for negotiation and write an SVG file to PATH')
        [CompletionResult]::new('--depth', '--depth', [CompletionResultType]::ParameterName, 'Fetch with the history truncated to the given number of commits as seen from the remote')
        [CompletionResult]::new('--deepen', '--deepen', [CompletionResultType]::ParameterName, 'Extend the current shallow boundary by the given amount of commits, with 0 meaning no change')
        [CompletionResult]::new('--shallow-since', '--shallow-since', [CompletionResultType]::ParameterName, 'Cutoff all history past the given date. Can be combined with shallow-exclude')
        [CompletionResult]::new('--shallow-exclude', '--shallow-exclude', [CompletionResultType]::ParameterName, 'Cutoff all history past the tag-name or ref-name. Can be combined with shallow-since')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'The name of the remote to connect to, or the url of the remote to connect to directly')
        [CompletionResult]::new('--remote', '--remote', [CompletionResultType]::ParameterName, 'The name of the remote to connect to, or the url of the remote to connect to directly')
        [CompletionResult]::new('-n', '-n', [CompletionResultType]::ParameterName, 'Don''t change the local repository, but otherwise try to be as accurate as possible')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Don''t change the local repository, but otherwise try to be as accurate as possible')
        [CompletionResult]::new('-H', '-H ', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('--handshake-info', '--handshake-info', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print statistics about negotiation phase')
        [CompletionResult]::new('--negotiation-info', '--negotiation-info', [CompletionResultType]::ParameterName, 'Print statistics about negotiation phase')
        [CompletionResult]::new('--unshallow', '--unshallow', [CompletionResultType]::ParameterName, 'Remove the shallow boundary and fetch the entire history available on the remote')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;clone' {
        [CompletionResult]::new('--depth', '--depth', [CompletionResultType]::ParameterName, 'Create a shallow clone with the history truncated to the given number of commits')
        [CompletionResult]::new('--shallow-since', '--shallow-since', [CompletionResultType]::ParameterName, 'Cutoff all history past the given date. Can be combined with shallow-exclude')
        [CompletionResult]::new('--shallow-exclude', '--shallow-exclude', [CompletionResultType]::ParameterName, 'Cutoff all history past the tag-name or ref-name. Can be combined with shallow-since')
        [CompletionResult]::new('--ref', '--ref', [CompletionResultType]::ParameterName, 'The name of the reference to check out')
        [CompletionResult]::new('-H', '-H ', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('--handshake-info', '--handshake-info', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('--bare', '--bare', [CompletionResultType]::ParameterName, 'The clone will be bare and a working tree checkout won''t be available')
        [CompletionResult]::new('--no-tags', '--no-tags', [CompletionResultType]::ParameterName, 'Do not clone any tags. Useful to reduce the size of the clone if only branches are needed')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;mailmap' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all entries in configured mailmaps, inform about errors as well')
        [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Print the canonical form of contacts according to the configured mailmaps')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;mailmap;entries' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;mailmap;check' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;mailmap;help' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all entries in configured mailmaps, inform about errors as well')
        [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Print the canonical form of contacts according to the configured mailmaps')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;mailmap;help;entries' {
        break
      }
      'gix;mailmap;help;check' {
        break
      }
      'gix;mailmap;help;help' {
        break
      }
      'gix;remote' {
        [CompletionResult]::new('-n', '-n', [CompletionResultType]::ParameterName, 'The name of the remote to connect to, or the URL of the remote to connect to directly')
        [CompletionResult]::new('--name', '--name', [CompletionResultType]::ParameterName, 'The name of the remote to connect to, or the URL of the remote to connect to directly')
        [CompletionResult]::new('-H', '-H ', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('--handshake-info', '--handshake-info', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('refs', 'refs', [CompletionResultType]::ParameterValue, 'Print all references available on the remote')
        [CompletionResult]::new('ref-map', 'ref-map', [CompletionResultType]::ParameterValue, 'Print all references available on the remote as filtered through ref-specs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;remotes' {
        [CompletionResult]::new('-n', '-n', [CompletionResultType]::ParameterName, 'The name of the remote to connect to, or the URL of the remote to connect to directly')
        [CompletionResult]::new('--name', '--name', [CompletionResultType]::ParameterName, 'The name of the remote to connect to, or the URL of the remote to connect to directly')
        [CompletionResult]::new('-H', '-H ', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('--handshake-info', '--handshake-info', [CompletionResultType]::ParameterName, 'Output additional typically information provided by the server as part of the connection handshake')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('refs', 'refs', [CompletionResultType]::ParameterValue, 'Print all references available on the remote')
        [CompletionResult]::new('ref-map', 'ref-map', [CompletionResultType]::ParameterValue, 'Print all references available on the remote as filtered through ref-specs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;remote;refs' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;remotes;refs' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;remote;ref-map' {
        [CompletionResult]::new('-u', '-u', [CompletionResultType]::ParameterName, 'Also display remote references that were sent by the server, but filtered by the refspec locally')
        [CompletionResult]::new('--show-unmapped-remote-refs', '--show-unmapped-remote-refs', [CompletionResultType]::ParameterName, 'Also display remote references that were sent by the server, but filtered by the refspec locally')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;remotes;ref-map' {
        [CompletionResult]::new('-u', '-u', [CompletionResultType]::ParameterName, 'Also display remote references that were sent by the server, but filtered by the refspec locally')
        [CompletionResult]::new('--show-unmapped-remote-refs', '--show-unmapped-remote-refs', [CompletionResultType]::ParameterName, 'Also display remote references that were sent by the server, but filtered by the refspec locally')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;remote;help' {
        [CompletionResult]::new('refs', 'refs', [CompletionResultType]::ParameterValue, 'Print all references available on the remote')
        [CompletionResult]::new('ref-map', 'ref-map', [CompletionResultType]::ParameterValue, 'Print all references available on the remote as filtered through ref-specs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;remote;help;refs' {
        break
      }
      'gix;remote;help;ref-map' {
        break
      }
      'gix;remote;help;help' {
        break
      }
      'gix;remotes;help' {
        [CompletionResult]::new('refs', 'refs', [CompletionResultType]::ParameterValue, 'Print all references available on the remote')
        [CompletionResult]::new('ref-map', 'ref-map', [CompletionResultType]::ParameterValue, 'Print all references available on the remote as filtered through ref-specs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;remotes;help;refs' {
        break
      }
      'gix;remotes;help;ref-map' {
        break
      }
      'gix;remotes;help;help' {
        break
      }
      'gix;attributes' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('validate-baseline', 'validate-baseline', [CompletionResultType]::ParameterValue, 'Run `git check-attr`  and `git check-ignore` on all files of the index or all files passed via stdin and validate that we get the same outcome when computing attributes')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'List all attributes of the given path-specs and display the result similar to `git check-attr`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;attrs' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('validate-baseline', 'validate-baseline', [CompletionResultType]::ParameterValue, 'Run `git check-attr`  and `git check-ignore` on all files of the index or all files passed via stdin and validate that we get the same outcome when computing attributes')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'List all attributes of the given path-specs and display the result similar to `git check-attr`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;attributes;validate-baseline' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--no-ignore', '--no-ignore', [CompletionResultType]::ParameterName, 'Don''t validated excludes as obtaining them with `check-ignore` can be very slow')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;attrs;validate-baseline' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--no-ignore', '--no-ignore', [CompletionResultType]::ParameterName, 'Don''t validated excludes as obtaining them with `check-ignore` can be very slow')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;attributes;query' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;attrs;query' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;attributes;help' {
        [CompletionResult]::new('validate-baseline', 'validate-baseline', [CompletionResultType]::ParameterValue, 'Run `git check-attr`  and `git check-ignore` on all files of the index or all files passed via stdin and validate that we get the same outcome when computing attributes')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'List all attributes of the given path-specs and display the result similar to `git check-attr`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;attributes;help;validate-baseline' {
        break
      }
      'gix;attributes;help;query' {
        break
      }
      'gix;attributes;help;help' {
        break
      }
      'gix;attrs;help' {
        [CompletionResult]::new('validate-baseline', 'validate-baseline', [CompletionResultType]::ParameterValue, 'Run `git check-attr`  and `git check-ignore` on all files of the index or all files passed via stdin and validate that we get the same outcome when computing attributes')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'List all attributes of the given path-specs and display the result similar to `git check-attr`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;attrs;help;validate-baseline' {
        break
      }
      'gix;attrs;help;query' {
        break
      }
      'gix;attrs;help;help' {
        break
      }
      'gix;exclude' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'Check if path-specs are excluded and print the result similar to `git check-ignore`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;exclude;query' {
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Additional patterns to use for exclusions. They have the highest priority')
        [CompletionResult]::new('--patterns', '--patterns', [CompletionResultType]::ParameterName, 'Additional patterns to use for exclusions. They have the highest priority')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Show actual ignore patterns instead of un-excluding an entry')
        [CompletionResult]::new('--show-ignore-patterns', '--show-ignore-patterns', [CompletionResultType]::ParameterName, 'Show actual ignore patterns instead of un-excluding an entry')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;exclude;help' {
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'Check if path-specs are excluded and print the result similar to `git check-ignore`')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;exclude;help;query' {
        break
      }
      'gix;exclude;help;help' {
        break
      }
      'gix;index' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all entries to standard output')
        [CompletionResult]::new('from-tree', 'from-tree', [CompletionResultType]::ParameterValue, 'Create an index from a tree-ish')
        [CompletionResult]::new('read-tree', 'read-tree', [CompletionResultType]::ParameterValue, 'Create an index from a tree-ish')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;index;entries' {
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'How to output index entries')
        [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'How to output index entries')
        [CompletionResult]::new('--no-attributes', '--no-attributes', [CompletionResultType]::ParameterName, 'Do not visualize excluded entries or attributes per path')
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Load attribute and ignore files from the index, don''t look at the worktree')
        [CompletionResult]::new('--attributes-from-index', '--attributes-from-index', [CompletionResultType]::ParameterName, 'Load attribute and ignore files from the index, don''t look at the worktree')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Display submodule entries as well if their repository exists')
        [CompletionResult]::new('--recurse-submodules', '--recurse-submodules', [CompletionResultType]::ParameterName, 'Display submodule entries as well if their repository exists')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print various statistics to stderr')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;index;from-tree' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('--index-output-path', '--index-output-path', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('--skip-hash', '--skip-hash', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;index;read-tree' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('--index-output-path', '--index-output-path', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('--skip-hash', '--skip-hash', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;index;help' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all entries to standard output')
        [CompletionResult]::new('from-tree', 'from-tree', [CompletionResultType]::ParameterValue, 'Create an index from a tree-ish')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;index;help;entries' {
        break
      }
      'gix;index;help;from-tree' {
        break
      }
      'gix;index;help;help' {
        break
      }
      'gix;submodule' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'Print all direct submodules to standard output')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;submodule;list' {
        [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'Set the suffix to append if the repository is dirty (not counting untracked files)')
        [CompletionResult]::new('--dirty-suffix', '--dirty-suffix', [CompletionResultType]::ParameterName, 'Set the suffix to append if the repository is dirty (not counting untracked files)')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;submodule;help' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'Print all direct submodules to standard output')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;submodule;help;list' {
        break
      }
      'gix;submodule;help;help' {
        break
      }
      'gix;is-clean' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;is-changed' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;config-tree' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;status' {
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'The way status data is displayed')
        [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'The way status data is displayed')
        [CompletionResult]::new('--ignored', '--ignored', [CompletionResultType]::ParameterName, 'If enabled, show ignored files and directories')
        [CompletionResult]::new('--submodules', '--submodules', [CompletionResultType]::ParameterName, 'Define how to display the submodule status. Defaults to git configuration if unset')
        [CompletionResult]::new('--index-worktree-renames', '--index-worktree-renames', [CompletionResultType]::ParameterName, 'Enable rename tracking between the index and the working tree, preventing the collapse of folders as well')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Print additional statistics to help understanding performance')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'Print additional statistics to help understanding performance')
        [CompletionResult]::new('--no-write', '--no-write', [CompletionResultType]::ParameterName, 'Don''t write back a changed index, which forces this operation to always be idempotent')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;config' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;corpus' {
        [CompletionResult]::new('--db', '--db', [CompletionResultType]::ParameterName, 'The path to the database to read and write depending on the sub-command')
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'The path to the root of the corpus to search repositories in')
        [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'The path to the root of the corpus to search repositories in')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Perform a corpus run on all registered repositories')
        [CompletionResult]::new('refresh', 'refresh', [CompletionResultType]::ParameterValue, 'Re-read all repositories under the corpus directory, and add or update them')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;corpus;run' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'The SQL that will be appended to the actual select statement for repositories to apply additional filtering, like `LIMIT 10`')
        [CompletionResult]::new('--repo-sql-suffix', '--repo-sql-suffix', [CompletionResultType]::ParameterName, 'The SQL that will be appended to the actual select statement for repositories to apply additional filtering, like `LIMIT 10`')
        [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'The short_names of the tasks to include when running')
        [CompletionResult]::new('--include-task', '--include-task', [CompletionResultType]::ParameterName, 'The short_names of the tasks to include when running')
        [CompletionResult]::new('-n', '-n', [CompletionResultType]::ParameterName, 'Don''t run any task, but print all repos that would be traversed once')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Don''t run any task, but print all repos that would be traversed once')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;corpus;refresh' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;corpus;help' {
        [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Perform a corpus run on all registered repositories')
        [CompletionResult]::new('refresh', 'refresh', [CompletionResultType]::ParameterValue, 'Re-read all repositories under the corpus directory, and add or update them')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;corpus;help;run' {
        break
      }
      'gix;corpus;help;refresh' {
        break
      }
      'gix;corpus;help;help' {
        break
      }
      'gix;merge-base' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;worktree' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all worktrees, along with some accompanying information')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;worktree;list' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;worktree;help' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all worktrees, along with some accompanying information')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;worktree;help;list' {
        break
      }
      'gix;worktree;help;help' {
        break
      }
      'gix;free' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with mailmaps')
        [CompletionResult]::new('pack', 'pack', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack files and indices')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with a worktree index, typically at .git/index')
        [CompletionResult]::new('discover', 'discover', [CompletionResultType]::ParameterValue, 'Show information about repository discovery and when opening a repository at the current path')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with mailmaps')
        [CompletionResult]::new('pack', 'pack', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack files and indices')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with a worktree index, typically at .git/index')
        [CompletionResult]::new('discover', 'discover', [CompletionResultType]::ParameterValue, 'Show information about repository discovery and when opening a repository at the current path')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;commit-graph' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;commit-graph;verify' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'output statistical information about the pack')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'output statistical information about the pack')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;commit-graph;help' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;commit-graph;help;verify' {
        break
      }
      'gix;free;commit-graph;help;help' {
        break
      }
      'gix;no-repo;commit-graph' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;commit-graph;verify' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'output statistical information about the pack')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'output statistical information about the pack')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;commit-graph;help' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;commit-graph;help;verify' {
        break
      }
      'gix;no-repo;commit-graph;help;help' {
        break
      }
      'gix;free;mailmap' {
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'The path to the mailmap file')
        [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'The path to the mailmap file')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;mailmap;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;mailmap;help' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;mailmap;help;verify' {
        break
      }
      'gix;free;mailmap;help;help' {
        break
      }
      'gix;no-repo;mailmap' {
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'The path to the mailmap file')
        [CompletionResult]::new('--path', '--path', [CompletionResultType]::ParameterName, 'The path to the mailmap file')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;mailmap;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;mailmap;help' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;mailmap;help;verify' {
        break
      }
      'gix;no-repo;mailmap;help;help' {
        break
      }
      'gix;free;pack' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;pack;index' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;pack;index;create' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Specify how to iterate the pack, defaults to ''verify''')
        [CompletionResult]::new('--iteration-mode', '--iteration-mode', [CompletionResultType]::ParameterName, 'Specify how to iterate the pack, defaults to ''verify''')
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Path to the pack file to read (with .pack extension)')
        [CompletionResult]::new('--pack-path', '--pack-path', [CompletionResultType]::ParameterName, 'Path to the pack file to read (with .pack extension)')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;free;pack;index;help' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;pack;index;help;create' {
        break
      }
      'gix;free;pack;index;help;help' {
        break
      }
      'gix;free;pack;multi-index' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('--multi-index-path', '--multi-index-path', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;pack;multi-index;entries' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;pack;multi-index;info' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;pack;multi-index;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;pack;multi-index;create' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;free;pack;multi-index;help' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;pack;multi-index;help;entries' {
        break
      }
      'gix;free;pack;multi-index;help;info' {
        break
      }
      'gix;free;pack;multi-index;help;verify' {
        break
      }
      'gix;free;pack;multi-index;help;create' {
        break
      }
      'gix;free;pack;multi-index;help;help' {
        break
      }
      'gix;free;pack;create' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'the directory containing the ''.git'' repository from which objects should be read')
        [CompletionResult]::new('--repository', '--repository', [CompletionResultType]::ParameterName, 'the directory containing the ''.git'' repository from which objects should be read')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'the way objects are expanded. They differ in costs')
        [CompletionResult]::new('--expansion', '--expansion', [CompletionResultType]::ParameterName, 'the way objects are expanded. They differ in costs')
        [CompletionResult]::new('--counting-threads', '--counting-threads', [CompletionResultType]::ParameterName, 'The amount of threads to use when counting and the `--nondeterminisitc-count` flag is set, defaulting to the globally configured threads')
        [CompletionResult]::new('--pack-cache-size-mb', '--pack-cache-size-mb', [CompletionResultType]::ParameterName, 'The size in megabytes for a cache to speed up pack access for packs with long delta chains. It is shared among all threads, so 4 threads would use their own cache 1/4th of the size')
        [CompletionResult]::new('--object-cache-size-mb', '--object-cache-size-mb', [CompletionResultType]::ParameterName, 'The size in megabytes for a cache to speed up accessing entire objects, bypassing object database access when hit. It is shared among all threads, so 4 threads would use their own cache 1/4th of the size')
        [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'The directory into which to write the pack file')
        [CompletionResult]::new('--output-directory', '--output-directory', [CompletionResultType]::ParameterName, 'The directory into which to write the pack file')
        [CompletionResult]::new('--nondeterministic-count', '--nondeterministic-count', [CompletionResultType]::ParameterName, 'if set, the counting phase may be accelerated using multithreading')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'If set statistical information will be presented to inform about pack creation details. It''s a form of instrumentation for developers to help improve pack generation')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'If set statistical information will be presented to inform about pack creation details. It''s a form of instrumentation for developers to help improve pack generation')
        [CompletionResult]::new('--thin', '--thin', [CompletionResultType]::ParameterName, 'if set, delta-objects whose base object wouldn''t be in the pack will not be recompressed as base object, but instead refer to its base object using its object id')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;free;pack;receive' {
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'The protocol version to use. Valid values are 1 and 2')
        [CompletionResult]::new('--protocol', '--protocol', [CompletionResultType]::ParameterName, 'The protocol version to use. Valid values are 1 and 2')
        [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'the directory into which to write references. Existing files will be overwritten')
        [CompletionResult]::new('--refs-directory', '--refs-directory', [CompletionResultType]::ParameterName, 'the directory into which to write references. Existing files will be overwritten')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'If set once or more times, these references will be fetched instead of all advertised ones')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'If set once or more times, these references will be fetched instead of all advertised ones')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;free;pack;explode' {
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'The amount of checks to run')
        [CompletionResult]::new('--check', '--check', [CompletionResultType]::ParameterName, 'The amount of checks to run')
        [CompletionResult]::new('--verify', '--verify', [CompletionResultType]::ParameterName, 'Read written objects back and assert they match their source. Fail the operation otherwise')
        [CompletionResult]::new('--delete-pack', '--delete-pack', [CompletionResultType]::ParameterName, 'delete the pack and index file after the operation is successful')
        [CompletionResult]::new('--sink-compress', '--sink-compress', [CompletionResultType]::ParameterName, 'Compress bytes even when using the sink, i.e. no object directory is specified')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;free;pack;verify' {
        [CompletionResult]::new('-a', '-a', [CompletionResultType]::ParameterName, 'The algorithm used to verify packs. They differ in costs')
        [CompletionResult]::new('--algorithm', '--algorithm', [CompletionResultType]::ParameterName, 'The algorithm used to verify packs. They differ in costs')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'output statistical information')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'output statistical information')
        [CompletionResult]::new('--decode', '--decode', [CompletionResultType]::ParameterName, 'Decode and parse tags, commits and trees to validate their correctness beyond hashing correctly')
        [CompletionResult]::new('--re-encode', '--re-encode', [CompletionResultType]::ParameterName, 'Decode and parse tags, commits and trees to validate their correctness, and re-encode them')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;free;pack;help' {
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;pack;help;index' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        break
      }
      'gix;free;pack;help;index;create' {
        break
      }
      'gix;free;pack;help;multi-index' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        break
      }
      'gix;free;pack;help;multi-index;entries' {
        break
      }
      'gix;free;pack;help;multi-index;info' {
        break
      }
      'gix;free;pack;help;multi-index;verify' {
        break
      }
      'gix;free;pack;help;multi-index;create' {
        break
      }
      'gix;free;pack;help;create' {
        break
      }
      'gix;free;pack;help;receive' {
        break
      }
      'gix;free;pack;help;explode' {
        break
      }
      'gix;free;pack;help;verify' {
        break
      }
      'gix;free;pack;help;help' {
        break
      }
      'gix;no-repo;pack' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;pack;index' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;pack;index;create' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Specify how to iterate the pack, defaults to ''verify''')
        [CompletionResult]::new('--iteration-mode', '--iteration-mode', [CompletionResultType]::ParameterName, 'Specify how to iterate the pack, defaults to ''verify''')
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Path to the pack file to read (with .pack extension)')
        [CompletionResult]::new('--pack-path', '--pack-path', [CompletionResultType]::ParameterName, 'Path to the pack file to read (with .pack extension)')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;no-repo;pack;index;help' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;pack;index;help;create' {
        break
      }
      'gix;no-repo;pack;index;help;help' {
        break
      }
      'gix;no-repo;pack;multi-index' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('--multi-index-path', '--multi-index-path', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;pack;multi-index;entries' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;pack;multi-index;info' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;pack;multi-index;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;pack;multi-index;create' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;no-repo;pack;multi-index;help' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;pack;multi-index;help;entries' {
        break
      }
      'gix;no-repo;pack;multi-index;help;info' {
        break
      }
      'gix;no-repo;pack;multi-index;help;verify' {
        break
      }
      'gix;no-repo;pack;multi-index;help;create' {
        break
      }
      'gix;no-repo;pack;multi-index;help;help' {
        break
      }
      'gix;no-repo;pack;create' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'the directory containing the ''.git'' repository from which objects should be read')
        [CompletionResult]::new('--repository', '--repository', [CompletionResultType]::ParameterName, 'the directory containing the ''.git'' repository from which objects should be read')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'the way objects are expanded. They differ in costs')
        [CompletionResult]::new('--expansion', '--expansion', [CompletionResultType]::ParameterName, 'the way objects are expanded. They differ in costs')
        [CompletionResult]::new('--counting-threads', '--counting-threads', [CompletionResultType]::ParameterName, 'The amount of threads to use when counting and the `--nondeterminisitc-count` flag is set, defaulting to the globally configured threads')
        [CompletionResult]::new('--pack-cache-size-mb', '--pack-cache-size-mb', [CompletionResultType]::ParameterName, 'The size in megabytes for a cache to speed up pack access for packs with long delta chains. It is shared among all threads, so 4 threads would use their own cache 1/4th of the size')
        [CompletionResult]::new('--object-cache-size-mb', '--object-cache-size-mb', [CompletionResultType]::ParameterName, 'The size in megabytes for a cache to speed up accessing entire objects, bypassing object database access when hit. It is shared among all threads, so 4 threads would use their own cache 1/4th of the size')
        [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'The directory into which to write the pack file')
        [CompletionResult]::new('--output-directory', '--output-directory', [CompletionResultType]::ParameterName, 'The directory into which to write the pack file')
        [CompletionResult]::new('--nondeterministic-count', '--nondeterministic-count', [CompletionResultType]::ParameterName, 'if set, the counting phase may be accelerated using multithreading')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'If set statistical information will be presented to inform about pack creation details. It''s a form of instrumentation for developers to help improve pack generation')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'If set statistical information will be presented to inform about pack creation details. It''s a form of instrumentation for developers to help improve pack generation')
        [CompletionResult]::new('--thin', '--thin', [CompletionResultType]::ParameterName, 'if set, delta-objects whose base object wouldn''t be in the pack will not be recompressed as base object, but instead refer to its base object using its object id')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;no-repo;pack;receive' {
        [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'The protocol version to use. Valid values are 1 and 2')
        [CompletionResult]::new('--protocol', '--protocol', [CompletionResultType]::ParameterName, 'The protocol version to use. Valid values are 1 and 2')
        [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'the directory into which to write references. Existing files will be overwritten')
        [CompletionResult]::new('--refs-directory', '--refs-directory', [CompletionResultType]::ParameterName, 'the directory into which to write references. Existing files will be overwritten')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'If set once or more times, these references will be fetched instead of all advertised ones')
        [CompletionResult]::new('--reference', '--reference', [CompletionResultType]::ParameterName, 'If set once or more times, these references will be fetched instead of all advertised ones')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;no-repo;pack;explode' {
        [CompletionResult]::new('-c', '-c', [CompletionResultType]::ParameterName, 'The amount of checks to run')
        [CompletionResult]::new('--check', '--check', [CompletionResultType]::ParameterName, 'The amount of checks to run')
        [CompletionResult]::new('--verify', '--verify', [CompletionResultType]::ParameterName, 'Read written objects back and assert they match their source. Fail the operation otherwise')
        [CompletionResult]::new('--delete-pack', '--delete-pack', [CompletionResultType]::ParameterName, 'delete the pack and index file after the operation is successful')
        [CompletionResult]::new('--sink-compress', '--sink-compress', [CompletionResultType]::ParameterName, 'Compress bytes even when using the sink, i.e. no object directory is specified')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;no-repo;pack;verify' {
        [CompletionResult]::new('-a', '-a', [CompletionResultType]::ParameterName, 'The algorithm used to verify packs. They differ in costs')
        [CompletionResult]::new('--algorithm', '--algorithm', [CompletionResultType]::ParameterName, 'The algorithm used to verify packs. They differ in costs')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'output statistical information')
        [CompletionResult]::new('--statistics', '--statistics', [CompletionResultType]::ParameterName, 'output statistical information')
        [CompletionResult]::new('--decode', '--decode', [CompletionResultType]::ParameterName, 'Decode and parse tags, commits and trees to validate their correctness beyond hashing correctly')
        [CompletionResult]::new('--re-encode', '--re-encode', [CompletionResultType]::ParameterName, 'Decode and parse tags, commits and trees to validate their correctness, and re-encode them')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'gix;no-repo;pack;help' {
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;pack;help;index' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        break
      }
      'gix;no-repo;pack;help;index;create' {
        break
      }
      'gix;no-repo;pack;help;multi-index' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        break
      }
      'gix;no-repo;pack;help;multi-index;entries' {
        break
      }
      'gix;no-repo;pack;help;multi-index;info' {
        break
      }
      'gix;no-repo;pack;help;multi-index;verify' {
        break
      }
      'gix;no-repo;pack;help;multi-index;create' {
        break
      }
      'gix;no-repo;pack;help;create' {
        break
      }
      'gix;no-repo;pack;help;receive' {
        break
      }
      'gix;no-repo;pack;help;explode' {
        break
      }
      'gix;no-repo;pack;help;verify' {
        break
      }
      'gix;no-repo;pack;help;help' {
        break
      }
      'gix;free;index' {
        [CompletionResult]::new('--object-hash', '--object-hash', [CompletionResultType]::ParameterName, 'The object format to assume when reading files that don''t inherently know about it, or when writing files')
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('--index-path', '--index-path', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;index;from-list' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('--index-output-path', '--index-output-path', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('--skip-hash', '--skip-hash', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;index;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;index;info' {
        [CompletionResult]::new('--no-details', '--no-details', [CompletionResultType]::ParameterName, 'Do not extract specific extension information to gain only a superficial idea of the index''s composition')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;index;checkout-exclusive' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'The path to `.git` repository from which objects can be obtained to write the actual files referenced in the index. Use this measure the impact on extracting objects on overall performance')
        [CompletionResult]::new('--repository', '--repository', [CompletionResultType]::ParameterName, 'The path to `.git` repository from which objects can be obtained to write the actual files referenced in the index. Use this measure the impact on extracting objects on overall performance')
        [CompletionResult]::new('-k', '-k', [CompletionResultType]::ParameterName, 'Ignore errors and keep checking out as many files as possible, and report all errors at the end of the operation')
        [CompletionResult]::new('--keep-going', '--keep-going', [CompletionResultType]::ParameterName, 'Ignore errors and keep checking out as many files as possible, and report all errors at the end of the operation')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Enable to query the object database yet write only empty files. This is useful to measure the overhead of ODB query compared to writing the bytes to disk')
        [CompletionResult]::new('--empty-files', '--empty-files', [CompletionResultType]::ParameterName, 'Enable to query the object database yet write only empty files. This is useful to measure the overhead of ODB query compared to writing the bytes to disk')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;index;help' {
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;index;help;from-list' {
        break
      }
      'gix;free;index;help;verify' {
        break
      }
      'gix;free;index;help;info' {
        break
      }
      'gix;free;index;help;checkout-exclusive' {
        break
      }
      'gix;free;index;help;help' {
        break
      }
      'gix;no-repo;index' {
        [CompletionResult]::new('--object-hash', '--object-hash', [CompletionResultType]::ParameterName, 'The object format to assume when reading files that don''t inherently know about it, or when writing files')
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('--index-path', '--index-path', [CompletionResultType]::ParameterName, 'The path to the index file')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;index;from-list' {
        [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('--index-output-path', '--index-output-path', [CompletionResultType]::ParameterName, 'Path to the index file to be written. If none is given it will be kept in memory only as a way to measure performance. One day we will probably write the index back by default, but that requires us to write more of the index to work')
        [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Overwrite the specified index file if it already exists')
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('--skip-hash', '--skip-hash', [CompletionResultType]::ParameterName, 'Don''t write the trailing hash for a performance gain')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;index;verify' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;index;info' {
        [CompletionResult]::new('--no-details', '--no-details', [CompletionResultType]::ParameterName, 'Do not extract specific extension information to gain only a superficial idea of the index''s composition')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;index;checkout-exclusive' {
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'The path to `.git` repository from which objects can be obtained to write the actual files referenced in the index. Use this measure the impact on extracting objects on overall performance')
        [CompletionResult]::new('--repository', '--repository', [CompletionResultType]::ParameterName, 'The path to `.git` repository from which objects can be obtained to write the actual files referenced in the index. Use this measure the impact on extracting objects on overall performance')
        [CompletionResult]::new('-k', '-k', [CompletionResultType]::ParameterName, 'Ignore errors and keep checking out as many files as possible, and report all errors at the end of the operation')
        [CompletionResult]::new('--keep-going', '--keep-going', [CompletionResultType]::ParameterName, 'Ignore errors and keep checking out as many files as possible, and report all errors at the end of the operation')
        [CompletionResult]::new('-e', '-e', [CompletionResultType]::ParameterName, 'Enable to query the object database yet write only empty files. This is useful to measure the overhead of ODB query compared to writing the bytes to disk')
        [CompletionResult]::new('--empty-files', '--empty-files', [CompletionResultType]::ParameterName, 'Enable to query the object database yet write only empty files. This is useful to measure the overhead of ODB query compared to writing the bytes to disk')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;index;help' {
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;index;help;from-list' {
        break
      }
      'gix;no-repo;index;help;verify' {
        break
      }
      'gix;no-repo;index;help;info' {
        break
      }
      'gix;no-repo;index;help;checkout-exclusive' {
        break
      }
      'gix;no-repo;index;help;help' {
        break
      }
      'gix;free;discover' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;no-repo;discover' {
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;free;help' {
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with mailmaps')
        [CompletionResult]::new('pack', 'pack', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack files and indices')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with a worktree index, typically at .git/index')
        [CompletionResult]::new('discover', 'discover', [CompletionResultType]::ParameterValue, 'Show information about repository discovery and when opening a repository at the current path')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;free;help;commit-graph' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        break
      }
      'gix;free;help;commit-graph;verify' {
        break
      }
      'gix;free;help;mailmap' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        break
      }
      'gix;free;help;mailmap;verify' {
        break
      }
      'gix;free;help;pack' {
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        break
      }
      'gix;free;help;pack;index' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        break
      }
      'gix;free;help;pack;index;create' {
        break
      }
      'gix;free;help;pack;multi-index' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        break
      }
      'gix;free;help;pack;multi-index;entries' {
        break
      }
      'gix;free;help;pack;multi-index;info' {
        break
      }
      'gix;free;help;pack;multi-index;verify' {
        break
      }
      'gix;free;help;pack;multi-index;create' {
        break
      }
      'gix;free;help;pack;create' {
        break
      }
      'gix;free;help;pack;receive' {
        break
      }
      'gix;free;help;pack;explode' {
        break
      }
      'gix;free;help;pack;verify' {
        break
      }
      'gix;free;help;index' {
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        break
      }
      'gix;free;help;index;from-list' {
        break
      }
      'gix;free;help;index;verify' {
        break
      }
      'gix;free;help;index;info' {
        break
      }
      'gix;free;help;index;checkout-exclusive' {
        break
      }
      'gix;free;help;discover' {
        break
      }
      'gix;free;help;help' {
        break
      }
      'gix;no-repo;help' {
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with mailmaps')
        [CompletionResult]::new('pack', 'pack', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack files and indices')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with a worktree index, typically at .git/index')
        [CompletionResult]::new('discover', 'discover', [CompletionResultType]::ParameterValue, 'Show information about repository discovery and when opening a repository at the current path')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;no-repo;help;commit-graph' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        break
      }
      'gix;no-repo;help;commit-graph;verify' {
        break
      }
      'gix;no-repo;help;mailmap' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        break
      }
      'gix;no-repo;help;mailmap;verify' {
        break
      }
      'gix;no-repo;help;pack' {
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        break
      }
      'gix;no-repo;help;pack;index' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        break
      }
      'gix;no-repo;help;pack;index;create' {
        break
      }
      'gix;no-repo;help;pack;multi-index' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        break
      }
      'gix;no-repo;help;pack;multi-index;entries' {
        break
      }
      'gix;no-repo;help;pack;multi-index;info' {
        break
      }
      'gix;no-repo;help;pack;multi-index;verify' {
        break
      }
      'gix;no-repo;help;pack;multi-index;create' {
        break
      }
      'gix;no-repo;help;pack;create' {
        break
      }
      'gix;no-repo;help;pack;receive' {
        break
      }
      'gix;no-repo;help;pack;explode' {
        break
      }
      'gix;no-repo;help;pack;verify' {
        break
      }
      'gix;no-repo;help;index' {
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        break
      }
      'gix;no-repo;help;index;from-list' {
        break
      }
      'gix;no-repo;help;index;verify' {
        break
      }
      'gix;no-repo;help;index;info' {
        break
      }
      'gix;no-repo;help;index;checkout-exclusive' {
        break
      }
      'gix;no-repo;help;discover' {
        break
      }
      'gix;no-repo;help;help' {
        break
      }
      'gix;completions' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
        [CompletionResult]::new('--shell', '--shell', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;generate-completions' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
        [CompletionResult]::new('--shell', '--shell', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;shell-completions' {
        [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
        [CompletionResult]::new('--shell', '--shell', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'gix;help' {
        [CompletionResult]::new('archive', 'archive', [CompletionResultType]::ParameterValue, 'Subcommands for creating worktree archives')
        [CompletionResult]::new('clean', 'clean', [CompletionResultType]::ParameterValue, 'clean')
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('odb', 'odb', [CompletionResultType]::ParameterValue, 'Interact with the object database')
        [CompletionResult]::new('fsck', 'fsck', [CompletionResultType]::ParameterValue, 'Check for missing objects')
        [CompletionResult]::new('tree', 'tree', [CompletionResultType]::ParameterValue, 'Interact with tree objects')
        [CompletionResult]::new('commit', 'commit', [CompletionResultType]::ParameterValue, 'Interact with commit objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of the entire repository')
        [CompletionResult]::new('revision', 'revision', [CompletionResultType]::ParameterValue, 'Query and obtain information about revisions')
        [CompletionResult]::new('credential', 'credential', [CompletionResultType]::ParameterValue, 'A program just like `git credential`')
        [CompletionResult]::new('fetch', 'fetch', [CompletionResultType]::ParameterValue, 'Fetch data from remotes and store it in the repository')
        [CompletionResult]::new('clone', 'clone', [CompletionResultType]::ParameterValue, 'clone')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Interact with the mailmap')
        [CompletionResult]::new('remote', 'remote', [CompletionResultType]::ParameterValue, 'Interact with the remote hosts')
        [CompletionResult]::new('attributes', 'attributes', [CompletionResultType]::ParameterValue, 'Interact with the attribute files like .gitattributes')
        [CompletionResult]::new('exclude', 'exclude', [CompletionResultType]::ParameterValue, 'Interact with the exclude files like .gitignore')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'index')
        [CompletionResult]::new('submodule', 'submodule', [CompletionResultType]::ParameterValue, 'Interact with submodules')
        [CompletionResult]::new('is-clean', 'is-clean', [CompletionResultType]::ParameterValue, 'is-clean')
        [CompletionResult]::new('is-changed', 'is-changed', [CompletionResultType]::ParameterValue, 'is-changed')
        [CompletionResult]::new('config-tree', 'config-tree', [CompletionResultType]::ParameterValue, 'Show which git configuration values are used or planned')
        [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'compute repository status similar to `git status`')
        [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'Print all entries in a configuration file or access other sub-commands')
        [CompletionResult]::new('corpus', 'corpus', [CompletionResultType]::ParameterValue, 'run algorithms on a corpus of git repositories and store their results for later analysis')
        [CompletionResult]::new('merge-base', 'merge-base', [CompletionResultType]::ParameterValue, 'A command for calculating all merge-bases')
        [CompletionResult]::new('worktree', 'worktree', [CompletionResultType]::ParameterValue, 'Commands for handling worktrees')
        [CompletionResult]::new('free', 'free', [CompletionResultType]::ParameterValue, 'Subcommands that need no git repository to run')
        [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'gix;help;archive' {
        break
      }
      'gix;help;clean' {
        break
      }
      'gix;help;commit-graph' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all entries in the commit-graph as reachable by starting from `HEAD`')
        break
      }
      'gix;help;commit-graph;verify' {
        break
      }
      'gix;help;commit-graph;list' {
        break
      }
      'gix;help;odb' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all object names')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Provide general information about the object database')
        [CompletionResult]::new('stats', 'stats', [CompletionResultType]::ParameterValue, 'Count and obtain information on all, possibly duplicate, objects in the database')
        break
      }
      'gix;help;odb;entries' {
        break
      }
      'gix;help;odb;info' {
        break
      }
      'gix;help;odb;stats' {
        break
      }
      'gix;help;fsck' {
        break
      }
      'gix;help;tree' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print entries in a given tree')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Provide information about a tree')
        break
      }
      'gix;help;tree;entries' {
        break
      }
      'gix;help;tree;info' {
        break
      }
      'gix;help;commit' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the signature of a commit')
        [CompletionResult]::new('describe', 'describe', [CompletionResultType]::ParameterValue, 'Describe the current commit or the given one using the name of the closest annotated tag in its ancestry')
        break
      }
      'gix;help;commit;verify' {
        break
      }
      'gix;help;commit;describe' {
        break
      }
      'gix;help;verify' {
        break
      }
      'gix;help;revision' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all commits reachable from the given rev-spec')
        [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Provide the revision specification like `@~1` to explain')
        [CompletionResult]::new('resolve', 'resolve', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        [CompletionResult]::new('previous-branches', 'previous-branches', [CompletionResultType]::ParameterValue, 'Return the names and hashes of all previously checked-out branches')
        break
      }
      'gix;help;revision;list' {
        break
      }
      'gix;help;revision;explain' {
        break
      }
      'gix;help;revision;resolve' {
        break
      }
      'gix;help;revision;previous-branches' {
        break
      }
      'gix;help;credential' {
        [CompletionResult]::new('fill', 'fill', [CompletionResultType]::ParameterValue, 'Get the credentials fed for `url=<url>` via STDIN')
        [CompletionResult]::new('approve', 'approve', [CompletionResultType]::ParameterValue, 'Approve the information piped via STDIN as obtained with last call to `fill`')
        [CompletionResult]::new('reject', 'reject', [CompletionResultType]::ParameterValue, 'Try to resolve the given revspec and print the object names')
        break
      }
      'gix;help;credential;fill' {
        break
      }
      'gix;help;credential;approve' {
        break
      }
      'gix;help;credential;reject' {
        break
      }
      'gix;help;fetch' {
        break
      }
      'gix;help;clone' {
        break
      }
      'gix;help;mailmap' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all entries in configured mailmaps, inform about errors as well')
        [CompletionResult]::new('check', 'check', [CompletionResultType]::ParameterValue, 'Print the canonical form of contacts according to the configured mailmaps')
        break
      }
      'gix;help;mailmap;entries' {
        break
      }
      'gix;help;mailmap;check' {
        break
      }
      'gix;help;remote' {
        [CompletionResult]::new('refs', 'refs', [CompletionResultType]::ParameterValue, 'Print all references available on the remote')
        [CompletionResult]::new('ref-map', 'ref-map', [CompletionResultType]::ParameterValue, 'Print all references available on the remote as filtered through ref-specs')
        break
      }
      'gix;help;remote;refs' {
        break
      }
      'gix;help;remote;ref-map' {
        break
      }
      'gix;help;attributes' {
        [CompletionResult]::new('validate-baseline', 'validate-baseline', [CompletionResultType]::ParameterValue, 'Run `git check-attr`  and `git check-ignore` on all files of the index or all files passed via stdin and validate that we get the same outcome when computing attributes')
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'List all attributes of the given path-specs and display the result similar to `git check-attr`')
        break
      }
      'gix;help;attributes;validate-baseline' {
        break
      }
      'gix;help;attributes;query' {
        break
      }
      'gix;help;exclude' {
        [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'Check if path-specs are excluded and print the result similar to `git check-ignore`')
        break
      }
      'gix;help;exclude;query' {
        break
      }
      'gix;help;index' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Print all entries to standard output')
        [CompletionResult]::new('from-tree', 'from-tree', [CompletionResultType]::ParameterValue, 'Create an index from a tree-ish')
        break
      }
      'gix;help;index;entries' {
        break
      }
      'gix;help;index;from-tree' {
        break
      }
      'gix;help;submodule' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'Print all direct submodules to standard output')
        break
      }
      'gix;help;submodule;list' {
        break
      }
      'gix;help;is-clean' {
        break
      }
      'gix;help;is-changed' {
        break
      }
      'gix;help;config-tree' {
        break
      }
      'gix;help;status' {
        break
      }
      'gix;help;config' {
        break
      }
      'gix;help;corpus' {
        [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Perform a corpus run on all registered repositories')
        [CompletionResult]::new('refresh', 'refresh', [CompletionResultType]::ParameterValue, 'Re-read all repositories under the corpus directory, and add or update them')
        break
      }
      'gix;help;corpus;run' {
        break
      }
      'gix;help;corpus;refresh' {
        break
      }
      'gix;help;merge-base' {
        break
      }
      'gix;help;worktree' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all worktrees, along with some accompanying information')
        break
      }
      'gix;help;worktree;list' {
        break
      }
      'gix;help;free' {
        [CompletionResult]::new('commit-graph', 'commit-graph', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with commit-graphs')
        [CompletionResult]::new('mailmap', 'mailmap', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with mailmaps')
        [CompletionResult]::new('pack', 'pack', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack files and indices')
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with a worktree index, typically at .git/index')
        [CompletionResult]::new('discover', 'discover', [CompletionResultType]::ParameterValue, 'Show information about repository discovery and when opening a repository at the current path')
        break
      }
      'gix;help;free;commit-graph' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a commit graph')
        break
      }
      'gix;help;free;commit-graph;verify' {
        break
      }
      'gix;help;free;mailmap' {
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Parse all entries in the mailmap and report malformed lines or collisions')
        break
      }
      'gix;help;free;mailmap;verify' {
        break
      }
      'gix;help;free;pack' {
        [CompletionResult]::new('index', 'index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with pack indices (.idx)')
        [CompletionResult]::new('multi-index', 'multi-index', [CompletionResultType]::ParameterValue, 'Subcommands for interacting with multi-pack indices (named "multi-pack-index")')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a new pack with a set of objects')
        [CompletionResult]::new('receive', 'receive', [CompletionResultType]::ParameterValue, 'Use the gix-protocol to receive a pack, emulating a clone')
        [CompletionResult]::new('explode', 'explode', [CompletionResultType]::ParameterValue, 'Dissolve a pack into its loose objects')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify the integrity of a pack, index or multi-index file')
        break
      }
      'gix;help;free;pack;index' {
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'create a pack index from a pack data file')
        break
      }
      'gix;help;free;pack;index;create' {
        break
      }
      'gix;help;free;pack;multi-index' {
        [CompletionResult]::new('entries', 'entries', [CompletionResultType]::ParameterValue, 'Display all entries of a multi-index as: *oid* *pack-id* *pack-offset*')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print general information about a multi-index file')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Verify a multi-index quickly without inspecting objects themselves')
        [CompletionResult]::new('create', 'create', [CompletionResultType]::ParameterValue, 'Create a multi-pack index from one or more pack index files, overwriting possibly existing files')
        break
      }
      'gix;help;free;pack;multi-index;entries' {
        break
      }
      'gix;help;free;pack;multi-index;info' {
        break
      }
      'gix;help;free;pack;multi-index;verify' {
        break
      }
      'gix;help;free;pack;multi-index;create' {
        break
      }
      'gix;help;free;pack;create' {
        break
      }
      'gix;help;free;pack;receive' {
        break
      }
      'gix;help;free;pack;explode' {
        break
      }
      'gix;help;free;pack;verify' {
        break
      }
      'gix;help;free;index' {
        [CompletionResult]::new('from-list', 'from-list', [CompletionResultType]::ParameterValue, 'Create an index from a list of empty files, one per line of the input')
        [CompletionResult]::new('verify', 'verify', [CompletionResultType]::ParameterValue, 'Validate constraints and assumptions of an index along with its integrity')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Print information about the index structure')
        [CompletionResult]::new('checkout-exclusive', 'checkout-exclusive', [CompletionResultType]::ParameterValue, 'Checkout the index into a directory with exclusive write access, similar to what would happen during clone')
        break
      }
      'gix;help;free;index;from-list' {
        break
      }
      'gix;help;free;index;verify' {
        break
      }
      'gix;help;free;index;info' {
        break
      }
      'gix;help;free;index;checkout-exclusive' {
        break
      }
      'gix;help;free;discover' {
        break
      }
      'gix;help;completions' {
        break
      }
      'gix;help;help' {
        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
    Sort-Object -Property ListItemText
}
