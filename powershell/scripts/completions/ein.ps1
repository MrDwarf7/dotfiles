
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'ein' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'ein'
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
        'ein' {
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'The amount of threads to use. If unset, use all cores, if 0 use al physical cores')
            [CompletionResult]::new('--threads', '--threads', [CompletionResultType]::ParameterName, 'The amount of threads to use. If unset, use all cores, if 0 use al physical cores')
            [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Do not display verbose messages and progress information')
            [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Do not display verbose messages and progress information')
            [CompletionResult]::new('--progress', '--progress', [CompletionResultType]::ParameterName, 'Bring up a terminal user interface displaying progress visually')
            [CompletionResult]::new('--progress-keep-open', '--progress-keep-open', [CompletionResultType]::ParameterName, 'The progress TUI will stay up even though the work is already completed')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initialize the repository in the current directory')
            [CompletionResult]::new('initialize', 'initialize', [CompletionResultType]::ParameterValue, 'Initialize the repository in the current directory')
            [CompletionResult]::new('tool', 'tool', [CompletionResultType]::ParameterValue, 'A selection of useful tools')
            [CompletionResult]::new('t', 't', [CompletionResultType]::ParameterValue, 'A selection of useful tools')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
            [CompletionResult]::new('generate-completions', 'generate-completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
            [CompletionResult]::new('shell-completions', 'shell-completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;init' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;initialize' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;tool' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('find', 'find', [CompletionResultType]::ParameterValue, 'Find all repositories in a given directory')
            [CompletionResult]::new('organize', 'organize', [CompletionResultType]::ParameterValue, 'Move all repositories found in a directory into a structure matching their clone URLs')
            [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('q', 'q', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('estimate-hours', 'estimate-hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('h', 'h', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('hours', 'hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;t' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('find', 'find', [CompletionResultType]::ParameterValue, 'Find all repositories in a given directory')
            [CompletionResult]::new('organize', 'organize', [CompletionResultType]::ParameterValue, 'Move all repositories found in a directory into a structure matching their clone URLs')
            [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('q', 'q', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('estimate-hours', 'estimate-hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('h', 'h', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('hours', 'hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;tool;find' {
            [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'If set, print additional information to help understand why the traversal is slow')
            [CompletionResult]::new('--debug', '--debug', [CompletionResultType]::ParameterName, 'If set, print additional information to help understand why the traversal is slow')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;t;find' {
            [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'If set, print additional information to help understand why the traversal is slow')
            [CompletionResult]::new('--debug', '--debug', [CompletionResultType]::ParameterName, 'If set, print additional information to help understand why the traversal is slow')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;tool;organize' {
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'The directory to use when finding input repositories to move into position')
            [CompletionResult]::new('--repository-source', '--repository-source', [CompletionResultType]::ParameterName, 'The directory to use when finding input repositories to move into position')
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'The directory to which to move repositories found in the repository-source')
            [CompletionResult]::new('--destination-directory', '--destination-directory', [CompletionResultType]::ParameterName, 'The directory to which to move repositories found in the repository-source')
            [CompletionResult]::new('--execute', '--execute', [CompletionResultType]::ParameterName, 'The operation will be in dry-run mode unless this flag is set')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;t;organize' {
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'The directory to use when finding input repositories to move into position')
            [CompletionResult]::new('--repository-source', '--repository-source', [CompletionResultType]::ParameterName, 'The directory to use when finding input repositories to move into position')
            [CompletionResult]::new('-t', '-t', [CompletionResultType]::ParameterName, 'The directory to which to move repositories found in the repository-source')
            [CompletionResult]::new('--destination-directory', '--destination-directory', [CompletionResultType]::ParameterName, 'The directory to which to move repositories found in the repository-source')
            [CompletionResult]::new('--execute', '--execute', [CompletionResultType]::ParameterName, 'The operation will be in dry-run mode unless this flag is set')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;tool;query' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('--object-cache-size-mb', '--object-cache-size-mb', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('--find-copies-harder', '--find-copies-harder', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('trace-file', 'trace-file', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;tool;q' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('--object-cache-size-mb', '--object-cache-size-mb', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('--find-copies-harder', '--find-copies-harder', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('trace-file', 'trace-file', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;tool;query;trace-path' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;tool;query;trace-file' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;tool;q;trace-path' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;tool;q;trace-file' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;tool;query;help' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;tool;query;help;trace-path' {
            break
        }
        'ein;tool;query;help;help' {
            break
        }
        'ein;tool;q;help' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;tool;q;help;trace-path' {
            break
        }
        'ein;tool;q;help;help' {
            break
        }
        'ein;t;query' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('--object-cache-size-mb', '--object-cache-size-mb', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('--find-copies-harder', '--find-copies-harder', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('trace-file', 'trace-file', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;t;q' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('--object-cache-size-mb', '--object-cache-size-mb', [CompletionResultType]::ParameterName, 'The total amount of object cache memory in MB. Bigger repos may benefit from more memory')
            [CompletionResult]::new('-C', '-C ', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('--find-copies-harder', '--find-copies-harder', [CompletionResultType]::ParameterName, 'Find identical copies in the entire tree, not only in the set of modified files')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('trace-file', 'trace-file', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;t;query;trace-path' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;t;query;trace-file' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;t;q;trace-path' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;t;q;trace-file' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;t;query;help' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;t;query;help;trace-path' {
            break
        }
        'ein;t;query;help;help' {
            break
        }
        'ein;t;q;help' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;t;q;help;trace-path' {
            break
        }
        'ein;t;q;help;help' {
            break
        }
        'ein;tool;estimate-hours' {
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('--no-bots', '--no-bots', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('--file-stats', '--file-stats', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('--line-stats', '--line-stats', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('--show-pii', '--show-pii', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('--omit-unify-identities', '--omit-unify-identities', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;tool;h' {
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('--no-bots', '--no-bots', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('--file-stats', '--file-stats', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('--line-stats', '--line-stats', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('--show-pii', '--show-pii', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('--omit-unify-identities', '--omit-unify-identities', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;tool;hours' {
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('--no-bots', '--no-bots', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('--file-stats', '--file-stats', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('--line-stats', '--line-stats', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('--show-pii', '--show-pii', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('--omit-unify-identities', '--omit-unify-identities', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;t;estimate-hours' {
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('--no-bots', '--no-bots', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('--file-stats', '--file-stats', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('--line-stats', '--line-stats', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('--show-pii', '--show-pii', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('--omit-unify-identities', '--omit-unify-identities', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;t;h' {
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('--no-bots', '--no-bots', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('--file-stats', '--file-stats', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('--line-stats', '--line-stats', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('--show-pii', '--show-pii', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('--omit-unify-identities', '--omit-unify-identities', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;t;hours' {
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('--no-bots', '--no-bots', [CompletionResultType]::ParameterName, 'Ignore github bots which match the `[bot]` search string')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('--file-stats', '--file-stats', [CompletionResultType]::ParameterName, 'Collect additional information about file modifications, additions and deletions (without rename tracking)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('--line-stats', '--line-stats', [CompletionResultType]::ParameterName, 'Collect additional information about lines added and deleted (without rename tracking)')
            [CompletionResult]::new('-p', '-p', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('--show-pii', '--show-pii', [CompletionResultType]::ParameterName, 'Show personally identifiable information before the summary. Includes names and email addresses')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('--omit-unify-identities', '--omit-unify-identities', [CompletionResultType]::ParameterName, 'Omit unifying identities by name and email which can lead to the same author appear multiple times due to using different names or email addresses')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'ein;tool;help' {
            [CompletionResult]::new('find', 'find', [CompletionResultType]::ParameterValue, 'Find all repositories in a given directory')
            [CompletionResult]::new('organize', 'organize', [CompletionResultType]::ParameterValue, 'Move all repositories found in a directory into a structure matching their clone URLs')
            [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('estimate-hours', 'estimate-hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;tool;help;find' {
            break
        }
        'ein;tool;help;organize' {
            break
        }
        'ein;tool;help;query' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            break
        }
        'ein;tool;help;query;trace-path' {
            break
        }
        'ein;tool;help;estimate-hours' {
            break
        }
        'ein;tool;help;help' {
            break
        }
        'ein;t;help' {
            [CompletionResult]::new('find', 'find', [CompletionResultType]::ParameterValue, 'Find all repositories in a given directory')
            [CompletionResult]::new('organize', 'organize', [CompletionResultType]::ParameterValue, 'Move all repositories found in a directory into a structure matching their clone URLs')
            [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('estimate-hours', 'estimate-hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;t;help;find' {
            break
        }
        'ein;t;help;organize' {
            break
        }
        'ein;t;help;query' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            break
        }
        'ein;t;help;query;trace-path' {
            break
        }
        'ein;t;help;estimate-hours' {
            break
        }
        'ein;t;help;help' {
            break
        }
        'ein;completions' {
            [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
            [CompletionResult]::new('--shell', '--shell', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;generate-completions' {
            [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
            [CompletionResult]::new('--shell', '--shell', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;shell-completions' {
            [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
            [CompletionResult]::new('--shell', '--shell', [CompletionResultType]::ParameterName, 'The shell to generate completions for. Otherwise it''s derived from the environment')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'ein;help' {
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Initialize the repository in the current directory')
            [CompletionResult]::new('tool', 'tool', [CompletionResultType]::ParameterValue, 'A selection of useful tools')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate shell completions to stdout or a directory')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'ein;help;init' {
            break
        }
        'ein;help;tool' {
            [CompletionResult]::new('find', 'find', [CompletionResultType]::ParameterValue, 'Find all repositories in a given directory')
            [CompletionResult]::new('organize', 'organize', [CompletionResultType]::ParameterValue, 'Move all repositories found in a directory into a structure matching their clone URLs')
            [CompletionResult]::new('query', 'query', [CompletionResultType]::ParameterValue, 'a database accelerated engine to extract information and query it')
            [CompletionResult]::new('estimate-hours', 'estimate-hours', [CompletionResultType]::ParameterValue, 'Estimate hours worked based on a commit history')
            break
        }
        'ein;help;tool;find' {
            break
        }
        'ein;help;tool;organize' {
            break
        }
        'ein;help;tool;query' {
            [CompletionResult]::new('trace-path', 'trace-path', [CompletionResultType]::ParameterValue, 'Follow a file through the entire history reachable from HEAD')
            break
        }
        'ein;help;tool;query;trace-path' {
            break
        }
        'ein;help;tool;estimate-hours' {
            break
        }
        'ein;help;completions' {
            break
        }
        'ein;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
