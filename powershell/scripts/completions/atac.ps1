
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'atac' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commandElements = $commandAst.CommandElements
  $command = @(
    'atac'
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
      'atac' {
        [CompletionResult]::new('-d', '-d', [CompletionResultType]::ParameterName, 'Main application directory, containing JSON/YAML collections files, the atac.toml config file and the atac.log file')
        [CompletionResult]::new('--directory', '--directory', [CompletionResultType]::ParameterName, 'Main application directory, containing JSON/YAML collections files, the atac.toml config file and the atac.log file')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
        [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
        [CompletionResult]::new('collection', 'collection', [CompletionResultType]::ParameterValue, 'Collection commands')
        [CompletionResult]::new('request', 'request', [CompletionResultType]::ParameterValue, 'Request commands')
        [CompletionResult]::new('try', 'try', [CompletionResultType]::ParameterValue, 'One-shot request sender')
        [CompletionResult]::new('env', 'env', [CompletionResultType]::ParameterValue, 'Environment commands')
        [CompletionResult]::new('import', 'import', [CompletionResultType]::ParameterValue, 'Import a collection or a request from other file formats (Postman v2.1.0, cURL)')
        [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Create a completion file')
        [CompletionResult]::new('man', 'man', [CompletionResultType]::ParameterValue, 'Generate ATAC man page')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;collection' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all collections')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe a collection')
        [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create a new collection')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a collection')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a collection')
        [CompletionResult]::new('send', 'send', [CompletionResultType]::ParameterValue, 'Send all the collection''s requests')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;collection;list' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use')
        [CompletionResult]::new('--request-names', '--request-names', [CompletionResultType]::ParameterName, 'Also print request names')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;collection;info' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use')
        [CompletionResult]::new('--without-request-names', '--without-request-names', [CompletionResultType]::ParameterName, 'Also print request names')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;collection;new' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;collection;delete' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;collection;rename' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;collection;send' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use, e.g. my_env (from file .env.my_env)')
        [CompletionResult]::new('--hide-content', '--hide-content', [CompletionResultType]::ParameterName, 'Hide response content')
        [CompletionResult]::new('--status-code', '--status-code', [CompletionResultType]::ParameterName, 'Show the status code')
        [CompletionResult]::new('--duration', '--duration', [CompletionResultType]::ParameterName, 'Show the duration')
        [CompletionResult]::new('--headers', '--headers', [CompletionResultType]::ParameterName, 'Show the response headers')
        [CompletionResult]::new('--cookies', '--cookies', [CompletionResultType]::ParameterName, 'Show the response cookies')
        [CompletionResult]::new('--console', '--console', [CompletionResultType]::ParameterName, 'Show the pre and post-request script console output')
        [CompletionResult]::new('--request-name', '--request-name', [CompletionResultType]::ParameterName, 'Show the request name')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;collection;help' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all collections')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe a collection')
        [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create a new collection')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a collection')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a collection')
        [CompletionResult]::new('send', 'send', [CompletionResultType]::ParameterValue, 'Send all the collection''s requests')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;collection;help;list' {
        break
      }
      'atac;collection;help;info' {
        break
      }
      'atac;collection;help;new' {
        break
      }
      'atac;collection;help;delete' {
        break
      }
      'atac;collection;help;rename' {
        break
      }
      'atac;collection;help;send' {
        break
      }
      'atac;collection;help;help' {
        break
      }
      'atac;request' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe a request')
        [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create a request')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a request')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a request')
        [CompletionResult]::new('url', 'url', [CompletionResultType]::ParameterValue, 'Get or set a request URL')
        [CompletionResult]::new('method', 'method', [CompletionResultType]::ParameterValue, 'Get or set a request method')
        [CompletionResult]::new('params', 'params', [CompletionResultType]::ParameterValue, 'Get, set, add, delete, rename or toggle a query param')
        [CompletionResult]::new('auth', 'auth', [CompletionResultType]::ParameterValue, 'Get or set a request auth method')
        [CompletionResult]::new('header', 'header', [CompletionResultType]::ParameterValue, 'Get, set, add, delete, rename or toggle a header')
        [CompletionResult]::new('body', 'body', [CompletionResultType]::ParameterValue, 'Get or set a request body')
        [CompletionResult]::new('scripts', 'scripts', [CompletionResultType]::ParameterValue, 'Get or set pre- and post-request scripts')
        [CompletionResult]::new('send', 'send', [CompletionResultType]::ParameterValue, 'Send a request')
        [CompletionResult]::new('settings', 'settings', [CompletionResultType]::ParameterValue, 'Get or set a request setting')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;info' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;new' {
        [CompletionResult]::new('-u', '-u', [CompletionResultType]::ParameterName, 'Request URL')
        [CompletionResult]::new('--url', '--url', [CompletionResultType]::ParameterName, 'Request URL')
        [CompletionResult]::new('-m', '-m', [CompletionResultType]::ParameterName, 'Request method')
        [CompletionResult]::new('--method', '--method', [CompletionResultType]::ParameterName, 'Request method')
        [CompletionResult]::new('--add-param', '--add-param', [CompletionResultType]::ParameterName, 'Add a query param (can be used multiple times)')
        [CompletionResult]::new('--auth-basic', '--auth-basic', [CompletionResultType]::ParameterName, 'Set a basic auth method')
        [CompletionResult]::new('--auth-bearer-token', '--auth-bearer-token', [CompletionResultType]::ParameterName, 'Set a bearer token auth method')
        [CompletionResult]::new('--add-header', '--add-header', [CompletionResultType]::ParameterName, 'Add a header (can be used multiple times)')
        [CompletionResult]::new('--body-file', '--body-file', [CompletionResultType]::ParameterName, 'Set a file body')
        [CompletionResult]::new('--add-body-multipart', '--add-body-multipart', [CompletionResultType]::ParameterName, 'Set a multipart form body (adds a value each time used)')
        [CompletionResult]::new('--add-body-form', '--add-body-form', [CompletionResultType]::ParameterName, 'Set a form body (adds a value each time used)')
        [CompletionResult]::new('--body-raw', '--body-raw', [CompletionResultType]::ParameterName, 'Set a raw test body')
        [CompletionResult]::new('--body-json', '--body-json', [CompletionResultType]::ParameterName, 'Set a JSON body')
        [CompletionResult]::new('--body-xml', '--body-xml', [CompletionResultType]::ParameterName, 'Set an XML body')
        [CompletionResult]::new('--body-html', '--body-html', [CompletionResultType]::ParameterName, 'Set an HTML body')
        [CompletionResult]::new('--body-javascript', '--body-javascript', [CompletionResultType]::ParameterName, 'Set an JavaScript body')
        [CompletionResult]::new('--pre-request-script', '--pre-request-script', [CompletionResultType]::ParameterName, 'Set a pre-request script')
        [CompletionResult]::new('--post-request-script', '--post-request-script', [CompletionResultType]::ParameterName, 'Set a post-request script')
        [CompletionResult]::new('--no-base-headers', '--no-base-headers', [CompletionResultType]::ParameterName, 'Do not use base headers (cache-control, user-agent, accept, accept-encoding, connection)')
        [CompletionResult]::new('--no-proxy', '--no-proxy', [CompletionResultType]::ParameterName, 'Do not use config proxy')
        [CompletionResult]::new('--no-redirects', '--no-redirects', [CompletionResultType]::ParameterName, 'Do not allow redirects')
        [CompletionResult]::new('--no-cookies', '--no-cookies', [CompletionResultType]::ParameterName, 'Do not store received cookies')
        [CompletionResult]::new('--no-pretty', '--no-pretty', [CompletionResultType]::ParameterName, 'Do not pretty print response content')
        [CompletionResult]::new('--accept-invalid-certs', '--accept-invalid-certs', [CompletionResultType]::ParameterName, 'Accept invalid certificates')
        [CompletionResult]::new('--accept-invalid-hostnames', '--accept-invalid-hostnames', [CompletionResultType]::ParameterName, 'Accept invalid hostnames')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;delete' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;rename' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;url' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request URL')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request URL')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;url;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;url;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;url;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request URL')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request URL')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;url;help;get' {
        break
      }
      'atac;request;url;help;set' {
        break
      }
      'atac;request;url;help;help' {
        break
      }
      'atac;request;method' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;method;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;method;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;method;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;method;help;get' {
        break
      }
      'atac;request;method;help;set' {
        break
      }
      'atac;request;method;help;help' {
        break
      }
      'atac;request;params' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;params;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;add' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;delete' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;rename' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;toggle' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;all' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;params;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;params;help;get' {
        break
      }
      'atac;request;params;help;set' {
        break
      }
      'atac;request;params;help;add' {
        break
      }
      'atac;request;params;help;delete' {
        break
      }
      'atac;request;params;help;rename' {
        break
      }
      'atac;request;params;help;toggle' {
        break
      }
      'atac;request;params;help;all' {
        break
      }
      'atac;request;params;help;help' {
        break
      }
      'atac;request;auth' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request auth method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request auth method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;auth;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;auth;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('no-auth', 'no-auth', [CompletionResultType]::ParameterValue, 'No auth method')
        [CompletionResult]::new('basic-auth', 'basic-auth', [CompletionResultType]::ParameterValue, 'Basic auth method')
        [CompletionResult]::new('basic', 'basic', [CompletionResultType]::ParameterValue, 'Basic auth method')
        [CompletionResult]::new('bearer-token', 'bearer-token', [CompletionResultType]::ParameterValue, 'Bearer token auth method')
        [CompletionResult]::new('bearer', 'bearer', [CompletionResultType]::ParameterValue, 'Bearer token auth method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;auth;set;no-auth' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;auth;set;basic-auth' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;auth;set;basic' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;auth;set;bearer-token' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;auth;set;bearer' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;auth;set;help' {
        [CompletionResult]::new('no-auth', 'no-auth', [CompletionResultType]::ParameterValue, 'No auth method')
        [CompletionResult]::new('basic-auth', 'basic-auth', [CompletionResultType]::ParameterValue, 'Basic auth method')
        [CompletionResult]::new('bearer-token', 'bearer-token', [CompletionResultType]::ParameterValue, 'Bearer token auth method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;auth;set;help;no-auth' {
        break
      }
      'atac;request;auth;set;help;basic-auth' {
        break
      }
      'atac;request;auth;set;help;bearer-token' {
        break
      }
      'atac;request;auth;set;help;help' {
        break
      }
      'atac;request;auth;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request auth method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request auth method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;auth;help;get' {
        break
      }
      'atac;request;auth;help;set' {
        [CompletionResult]::new('no-auth', 'no-auth', [CompletionResultType]::ParameterValue, 'No auth method')
        [CompletionResult]::new('basic-auth', 'basic-auth', [CompletionResultType]::ParameterValue, 'Basic auth method')
        [CompletionResult]::new('bearer-token', 'bearer-token', [CompletionResultType]::ParameterValue, 'Bearer token auth method')
        break
      }
      'atac;request;auth;help;set;no-auth' {
        break
      }
      'atac;request;auth;help;set;basic-auth' {
        break
      }
      'atac;request;auth;help;set;bearer-token' {
        break
      }
      'atac;request;auth;help;help' {
        break
      }
      'atac;request;header' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;header;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;add' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;delete' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;rename' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;toggle' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;all' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;header;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;header;help;get' {
        break
      }
      'atac;request;header;help;set' {
        break
      }
      'atac;request;header;help;add' {
        break
      }
      'atac;request;header;help;delete' {
        break
      }
      'atac;request;header;help;rename' {
        break
      }
      'atac;request;header;help;toggle' {
        break
      }
      'atac;request;header;help;all' {
        break
      }
      'atac;request;header;help;help' {
        break
      }
      'atac;request;body' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request body')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request body')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair (multipart & form body only)')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;body;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('no-body', 'no-body', [CompletionResultType]::ParameterValue, 'no-body')
        [CompletionResult]::new('file', 'file', [CompletionResultType]::ParameterValue, 'file')
        [CompletionResult]::new('multipart', 'multipart', [CompletionResultType]::ParameterValue, 'multipart')
        [CompletionResult]::new('form', 'form', [CompletionResultType]::ParameterValue, 'form')
        [CompletionResult]::new('raw', 'raw', [CompletionResultType]::ParameterValue, 'raw')
        [CompletionResult]::new('json', 'json', [CompletionResultType]::ParameterValue, 'json')
        [CompletionResult]::new('xml', 'xml', [CompletionResultType]::ParameterValue, 'xml')
        [CompletionResult]::new('html', 'html', [CompletionResultType]::ParameterValue, 'html')
        [CompletionResult]::new('javascript', 'javascript', [CompletionResultType]::ParameterValue, 'javascript')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;body;set;no-body' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;file' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;multipart' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;form' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;raw' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;json' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;xml' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;html' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;javascript' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;set;help' {
        [CompletionResult]::new('no-body', 'no-body', [CompletionResultType]::ParameterValue, 'no-body')
        [CompletionResult]::new('file', 'file', [CompletionResultType]::ParameterValue, 'file')
        [CompletionResult]::new('multipart', 'multipart', [CompletionResultType]::ParameterValue, 'multipart')
        [CompletionResult]::new('form', 'form', [CompletionResultType]::ParameterValue, 'form')
        [CompletionResult]::new('raw', 'raw', [CompletionResultType]::ParameterValue, 'raw')
        [CompletionResult]::new('json', 'json', [CompletionResultType]::ParameterValue, 'json')
        [CompletionResult]::new('xml', 'xml', [CompletionResultType]::ParameterValue, 'xml')
        [CompletionResult]::new('html', 'html', [CompletionResultType]::ParameterValue, 'html')
        [CompletionResult]::new('javascript', 'javascript', [CompletionResultType]::ParameterValue, 'javascript')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;body;set;help;no-body' {
        break
      }
      'atac;request;body;set;help;file' {
        break
      }
      'atac;request;body;set;help;multipart' {
        break
      }
      'atac;request;body;set;help;form' {
        break
      }
      'atac;request;body;set;help;raw' {
        break
      }
      'atac;request;body;set;help;json' {
        break
      }
      'atac;request;body;set;help;xml' {
        break
      }
      'atac;request;body;set;help;html' {
        break
      }
      'atac;request;body;set;help;javascript' {
        break
      }
      'atac;request;body;set;help;help' {
        break
      }
      'atac;request;body;key' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;body;key;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;add' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;delete' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;rename' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;toggle' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;all' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;body;key;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;body;key;help;get' {
        break
      }
      'atac;request;body;key;help;set' {
        break
      }
      'atac;request;body;key;help;add' {
        break
      }
      'atac;request;body;key;help;delete' {
        break
      }
      'atac;request;body;key;help;rename' {
        break
      }
      'atac;request;body;key;help;toggle' {
        break
      }
      'atac;request;body;key;help;all' {
        break
      }
      'atac;request;body;key;help;help' {
        break
      }
      'atac;request;body;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request body')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request body')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair (multipart & form body only)')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;body;help;get' {
        break
      }
      'atac;request;body;help;set' {
        [CompletionResult]::new('no-body', 'no-body', [CompletionResultType]::ParameterValue, 'no-body')
        [CompletionResult]::new('file', 'file', [CompletionResultType]::ParameterValue, 'file')
        [CompletionResult]::new('multipart', 'multipart', [CompletionResultType]::ParameterValue, 'multipart')
        [CompletionResult]::new('form', 'form', [CompletionResultType]::ParameterValue, 'form')
        [CompletionResult]::new('raw', 'raw', [CompletionResultType]::ParameterValue, 'raw')
        [CompletionResult]::new('json', 'json', [CompletionResultType]::ParameterValue, 'json')
        [CompletionResult]::new('xml', 'xml', [CompletionResultType]::ParameterValue, 'xml')
        [CompletionResult]::new('html', 'html', [CompletionResultType]::ParameterValue, 'html')
        [CompletionResult]::new('javascript', 'javascript', [CompletionResultType]::ParameterValue, 'javascript')
        break
      }
      'atac;request;body;help;set;no-body' {
        break
      }
      'atac;request;body;help;set;file' {
        break
      }
      'atac;request;body;help;set;multipart' {
        break
      }
      'atac;request;body;help;set;form' {
        break
      }
      'atac;request;body;help;set;raw' {
        break
      }
      'atac;request;body;help;set;json' {
        break
      }
      'atac;request;body;help;set;xml' {
        break
      }
      'atac;request;body;help;set;html' {
        break
      }
      'atac;request;body;help;set;javascript' {
        break
      }
      'atac;request;body;help;key' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;request;body;help;key;get' {
        break
      }
      'atac;request;body;help;key;set' {
        break
      }
      'atac;request;body;help;key;add' {
        break
      }
      'atac;request;body;help;key;delete' {
        break
      }
      'atac;request;body;help;key;rename' {
        break
      }
      'atac;request;body;help;key;toggle' {
        break
      }
      'atac;request;body;help;key;all' {
        break
      }
      'atac;request;body;help;help' {
        break
      }
      'atac;request;scripts' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current pre- or post-request script')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set a pre- or post-request script')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;scripts;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;scripts;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;scripts;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current pre- or post-request script')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set a pre- or post-request script')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;scripts;help;get' {
        break
      }
      'atac;request;scripts;help;set' {
        break
      }
      'atac;request;scripts;help;help' {
        break
      }
      'atac;request;send' {
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use, e.g. my_env (from file .env.my_env)')
        [CompletionResult]::new('--hide-content', '--hide-content', [CompletionResultType]::ParameterName, 'Hide response content')
        [CompletionResult]::new('--status-code', '--status-code', [CompletionResultType]::ParameterName, 'Show the status code')
        [CompletionResult]::new('--duration', '--duration', [CompletionResultType]::ParameterName, 'Show the duration')
        [CompletionResult]::new('--headers', '--headers', [CompletionResultType]::ParameterName, 'Show the response headers')
        [CompletionResult]::new('--cookies', '--cookies', [CompletionResultType]::ParameterName, 'Show the response cookies')
        [CompletionResult]::new('--console', '--console', [CompletionResultType]::ParameterName, 'Show the pre and post-request script console output')
        [CompletionResult]::new('--request-name', '--request-name', [CompletionResultType]::ParameterName, 'Show the request name')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;settings' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the request settings')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request setting')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;settings;all' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;request;settings;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'atac;request;settings;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
        break
      }
      'atac;request;settings;help' {
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the request settings')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request setting')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;settings;help;all' {
        break
      }
      'atac;request;settings;help;get' {
        break
      }
      'atac;request;settings;help;set' {
        break
      }
      'atac;request;settings;help;help' {
        break
      }
      'atac;request;help' {
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe a request')
        [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create a request')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a request')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a request')
        [CompletionResult]::new('url', 'url', [CompletionResultType]::ParameterValue, 'Get or set a request URL')
        [CompletionResult]::new('method', 'method', [CompletionResultType]::ParameterValue, 'Get or set a request method')
        [CompletionResult]::new('params', 'params', [CompletionResultType]::ParameterValue, 'Get, set, add, delete, rename or toggle a query param')
        [CompletionResult]::new('auth', 'auth', [CompletionResultType]::ParameterValue, 'Get or set a request auth method')
        [CompletionResult]::new('header', 'header', [CompletionResultType]::ParameterValue, 'Get, set, add, delete, rename or toggle a header')
        [CompletionResult]::new('body', 'body', [CompletionResultType]::ParameterValue, 'Get or set a request body')
        [CompletionResult]::new('scripts', 'scripts', [CompletionResultType]::ParameterValue, 'Get or set pre- and post-request scripts')
        [CompletionResult]::new('send', 'send', [CompletionResultType]::ParameterValue, 'Send a request')
        [CompletionResult]::new('settings', 'settings', [CompletionResultType]::ParameterValue, 'Get or set a request setting')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;request;help;info' {
        break
      }
      'atac;request;help;new' {
        break
      }
      'atac;request;help;delete' {
        break
      }
      'atac;request;help;rename' {
        break
      }
      'atac;request;help;url' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request URL')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request URL')
        break
      }
      'atac;request;help;url;get' {
        break
      }
      'atac;request;help;url;set' {
        break
      }
      'atac;request;help;method' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        break
      }
      'atac;request;help;method;get' {
        break
      }
      'atac;request;help;method;set' {
        break
      }
      'atac;request;help;params' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;request;help;params;get' {
        break
      }
      'atac;request;help;params;set' {
        break
      }
      'atac;request;help;params;add' {
        break
      }
      'atac;request;help;params;delete' {
        break
      }
      'atac;request;help;params;rename' {
        break
      }
      'atac;request;help;params;toggle' {
        break
      }
      'atac;request;help;params;all' {
        break
      }
      'atac;request;help;auth' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request auth method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request auth method')
        break
      }
      'atac;request;help;auth;get' {
        break
      }
      'atac;request;help;auth;set' {
        [CompletionResult]::new('no-auth', 'no-auth', [CompletionResultType]::ParameterValue, 'No auth method')
        [CompletionResult]::new('basic-auth', 'basic-auth', [CompletionResultType]::ParameterValue, 'Basic auth method')
        [CompletionResult]::new('bearer-token', 'bearer-token', [CompletionResultType]::ParameterValue, 'Bearer token auth method')
        break
      }
      'atac;request;help;auth;set;no-auth' {
        break
      }
      'atac;request;help;auth;set;basic-auth' {
        break
      }
      'atac;request;help;auth;set;bearer-token' {
        break
      }
      'atac;request;help;header' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;request;help;header;get' {
        break
      }
      'atac;request;help;header;set' {
        break
      }
      'atac;request;help;header;add' {
        break
      }
      'atac;request;help;header;delete' {
        break
      }
      'atac;request;help;header;rename' {
        break
      }
      'atac;request;help;header;toggle' {
        break
      }
      'atac;request;help;header;all' {
        break
      }
      'atac;request;help;body' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request body')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request body')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair (multipart & form body only)')
        break
      }
      'atac;request;help;body;get' {
        break
      }
      'atac;request;help;body;set' {
        [CompletionResult]::new('no-body', 'no-body', [CompletionResultType]::ParameterValue, 'no-body')
        [CompletionResult]::new('file', 'file', [CompletionResultType]::ParameterValue, 'file')
        [CompletionResult]::new('multipart', 'multipart', [CompletionResultType]::ParameterValue, 'multipart')
        [CompletionResult]::new('form', 'form', [CompletionResultType]::ParameterValue, 'form')
        [CompletionResult]::new('raw', 'raw', [CompletionResultType]::ParameterValue, 'raw')
        [CompletionResult]::new('json', 'json', [CompletionResultType]::ParameterValue, 'json')
        [CompletionResult]::new('xml', 'xml', [CompletionResultType]::ParameterValue, 'xml')
        [CompletionResult]::new('html', 'html', [CompletionResultType]::ParameterValue, 'html')
        [CompletionResult]::new('javascript', 'javascript', [CompletionResultType]::ParameterValue, 'javascript')
        break
      }
      'atac;request;help;body;set;no-body' {
        break
      }
      'atac;request;help;body;set;file' {
        break
      }
      'atac;request;help;body;set;multipart' {
        break
      }
      'atac;request;help;body;set;form' {
        break
      }
      'atac;request;help;body;set;raw' {
        break
      }
      'atac;request;help;body;set;json' {
        break
      }
      'atac;request;help;body;set;xml' {
        break
      }
      'atac;request;help;body;set;html' {
        break
      }
      'atac;request;help;body;set;javascript' {
        break
      }
      'atac;request;help;body;key' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;request;help;body;key;get' {
        break
      }
      'atac;request;help;body;key;set' {
        break
      }
      'atac;request;help;body;key;add' {
        break
      }
      'atac;request;help;body;key;delete' {
        break
      }
      'atac;request;help;body;key;rename' {
        break
      }
      'atac;request;help;body;key;toggle' {
        break
      }
      'atac;request;help;body;key;all' {
        break
      }
      'atac;request;help;scripts' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current pre- or post-request script')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set a pre- or post-request script')
        break
      }
      'atac;request;help;scripts;get' {
        break
      }
      'atac;request;help;scripts;set' {
        break
      }
      'atac;request;help;send' {
        break
      }
      'atac;request;help;settings' {
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the request settings')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request setting')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        break
      }
      'atac;request;help;settings;all' {
        break
      }
      'atac;request;help;settings;get' {
        break
      }
      'atac;request;help;settings;set' {
        break
      }
      'atac;request;help;help' {
        break
      }
      'atac;try' {
        [CompletionResult]::new('-u', '-u', [CompletionResultType]::ParameterName, 'Request URL')
        [CompletionResult]::new('--url', '--url', [CompletionResultType]::ParameterName, 'Request URL')
        [CompletionResult]::new('-m', '-m', [CompletionResultType]::ParameterName, 'Request method')
        [CompletionResult]::new('--method', '--method', [CompletionResultType]::ParameterName, 'Request method')
        [CompletionResult]::new('--add-param', '--add-param', [CompletionResultType]::ParameterName, 'Add a query param (can be used multiple times)')
        [CompletionResult]::new('--auth-basic', '--auth-basic', [CompletionResultType]::ParameterName, 'Set a basic auth method')
        [CompletionResult]::new('--auth-bearer-token', '--auth-bearer-token', [CompletionResultType]::ParameterName, 'Set a bearer token auth method')
        [CompletionResult]::new('--add-header', '--add-header', [CompletionResultType]::ParameterName, 'Add a header (can be used multiple times)')
        [CompletionResult]::new('--body-file', '--body-file', [CompletionResultType]::ParameterName, 'Set a file body')
        [CompletionResult]::new('--add-body-multipart', '--add-body-multipart', [CompletionResultType]::ParameterName, 'Set a multipart form body (adds a value each time used)')
        [CompletionResult]::new('--add-body-form', '--add-body-form', [CompletionResultType]::ParameterName, 'Set a form body (adds a value each time used)')
        [CompletionResult]::new('--body-raw', '--body-raw', [CompletionResultType]::ParameterName, 'Set a raw test body')
        [CompletionResult]::new('--body-json', '--body-json', [CompletionResultType]::ParameterName, 'Set a JSON body')
        [CompletionResult]::new('--body-xml', '--body-xml', [CompletionResultType]::ParameterName, 'Set an XML body')
        [CompletionResult]::new('--body-html', '--body-html', [CompletionResultType]::ParameterName, 'Set an HTML body')
        [CompletionResult]::new('--body-javascript', '--body-javascript', [CompletionResultType]::ParameterName, 'Set an JavaScript body')
        [CompletionResult]::new('--pre-request-script', '--pre-request-script', [CompletionResultType]::ParameterName, 'Set a pre-request script')
        [CompletionResult]::new('--post-request-script', '--post-request-script', [CompletionResultType]::ParameterName, 'Set a post-request script')
        [CompletionResult]::new('--env', '--env', [CompletionResultType]::ParameterName, 'Name of the environment to use, e.g. my_env (from file .env.my_env)')
        [CompletionResult]::new('--no-base-headers', '--no-base-headers', [CompletionResultType]::ParameterName, 'Do not use base headers (cache-control, user-agent, accept, accept-encoding, connection)')
        [CompletionResult]::new('--no-proxy', '--no-proxy', [CompletionResultType]::ParameterName, 'Do not use config proxy')
        [CompletionResult]::new('--no-redirects', '--no-redirects', [CompletionResultType]::ParameterName, 'Do not allow redirects')
        [CompletionResult]::new('--no-cookies', '--no-cookies', [CompletionResultType]::ParameterName, 'Do not store received cookies')
        [CompletionResult]::new('--no-pretty', '--no-pretty', [CompletionResultType]::ParameterName, 'Do not pretty print response content')
        [CompletionResult]::new('--accept-invalid-certs', '--accept-invalid-certs', [CompletionResultType]::ParameterName, 'Accept invalid certificates')
        [CompletionResult]::new('--accept-invalid-hostnames', '--accept-invalid-hostnames', [CompletionResultType]::ParameterName, 'Accept invalid hostnames')
        [CompletionResult]::new('--hide-content', '--hide-content', [CompletionResultType]::ParameterName, 'Hide response content')
        [CompletionResult]::new('--status-code', '--status-code', [CompletionResultType]::ParameterName, 'Show the status code')
        [CompletionResult]::new('--duration', '--duration', [CompletionResultType]::ParameterName, 'Show the duration')
        [CompletionResult]::new('--headers', '--headers', [CompletionResultType]::ParameterName, 'Show the response headers')
        [CompletionResult]::new('--cookies', '--cookies', [CompletionResultType]::ParameterName, 'Show the response cookies')
        [CompletionResult]::new('--console', '--console', [CompletionResultType]::ParameterName, 'Show the pre and post-request script console output')
        [CompletionResult]::new('--request-name', '--request-name', [CompletionResultType]::ParameterName, 'Show the request name')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe an environment')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;env;info' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env;key' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;env;key;get' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env;key;set' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env;key;add' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env;key;delete' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env;key;rename' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;env;key;help' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;env;key;help;get' {
        break
      }
      'atac;env;key;help;set' {
        break
      }
      'atac;env;key;help;add' {
        break
      }
      'atac;env;key;help;delete' {
        break
      }
      'atac;env;key;help;rename' {
        break
      }
      'atac;env;key;help;help' {
        break
      }
      'atac;env;help' {
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe an environment')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;env;help;info' {
        break
      }
      'atac;env;help;key' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        break
      }
      'atac;env;help;key;get' {
        break
      }
      'atac;env;help;key;set' {
        break
      }
      'atac;env;help;key;add' {
        break
      }
      'atac;env;help;key;delete' {
        break
      }
      'atac;env;help;key;rename' {
        break
      }
      'atac;env;help;help' {
        break
      }
      'atac;import' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('postman', 'postman', [CompletionResultType]::ParameterValue, 'Import a Postman v2.1.0 file')
        [CompletionResult]::new('curl', 'curl', [CompletionResultType]::ParameterValue, 'Import a curl file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;import;postman' {
        [CompletionResult]::new('--max-depth', '--max-depth', [CompletionResultType]::ParameterName, 'Max depth at which import should stop creating nested collections and only get the deeper requests')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;import;curl' {
        [CompletionResult]::new('--max-depth', '--max-depth', [CompletionResultType]::ParameterName, 'Max depth at which import should stop creating nested collections and only get the deeper requests')
        [CompletionResult]::new('-r', '-r', [CompletionResultType]::ParameterName, 'Search for deeper files')
        [CompletionResult]::new('--recursive', '--recursive', [CompletionResultType]::ParameterName, 'Search for deeper files')
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;import;help' {
        [CompletionResult]::new('postman', 'postman', [CompletionResultType]::ParameterValue, 'Import a Postman v2.1.0 file')
        [CompletionResult]::new('curl', 'curl', [CompletionResultType]::ParameterValue, 'Import a curl file')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;import;help;postman' {
        break
      }
      'atac;import;help;curl' {
        break
      }
      'atac;import;help;help' {
        break
      }
      'atac;completions' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;man' {
        [CompletionResult]::new('--dry-run', '--dry-run', [CompletionResultType]::ParameterName, 'Avoid saving data to the collection and environment files')
        [CompletionResult]::new('--no-ansi-log', '--no-ansi-log', [CompletionResultType]::ParameterName, 'Avoid using ANSI format for log file/output')
        [CompletionResult]::new('-v', '-v', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('--verbose', '--verbose', [CompletionResultType]::ParameterName, 'Increase logging verbosity')
        [CompletionResult]::new('-q', '-q', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('--quiet', '--quiet', [CompletionResultType]::ParameterName, 'Decrease logging verbosity')
        [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
        [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
        break
      }
      'atac;help' {
        [CompletionResult]::new('collection', 'collection', [CompletionResultType]::ParameterValue, 'Collection commands')
        [CompletionResult]::new('request', 'request', [CompletionResultType]::ParameterValue, 'Request commands')
        [CompletionResult]::new('try', 'try', [CompletionResultType]::ParameterValue, 'One-shot request sender')
        [CompletionResult]::new('env', 'env', [CompletionResultType]::ParameterValue, 'Environment commands')
        [CompletionResult]::new('import', 'import', [CompletionResultType]::ParameterValue, 'Import a collection or a request from other file formats (Postman v2.1.0, cURL)')
        [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Create a completion file')
        [CompletionResult]::new('man', 'man', [CompletionResultType]::ParameterValue, 'Generate ATAC man page')
        [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
        break
      }
      'atac;help;collection' {
        [CompletionResult]::new('list', 'list', [CompletionResultType]::ParameterValue, 'List all collections')
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe a collection')
        [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create a new collection')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a collection')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a collection')
        [CompletionResult]::new('send', 'send', [CompletionResultType]::ParameterValue, 'Send all the collection''s requests')
        break
      }
      'atac;help;collection;list' {
        break
      }
      'atac;help;collection;info' {
        break
      }
      'atac;help;collection;new' {
        break
      }
      'atac;help;collection;delete' {
        break
      }
      'atac;help;collection;rename' {
        break
      }
      'atac;help;collection;send' {
        break
      }
      'atac;help;request' {
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe a request')
        [CompletionResult]::new('new', 'new', [CompletionResultType]::ParameterValue, 'Create a request')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a request')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a request')
        [CompletionResult]::new('url', 'url', [CompletionResultType]::ParameterValue, 'Get or set a request URL')
        [CompletionResult]::new('method', 'method', [CompletionResultType]::ParameterValue, 'Get or set a request method')
        [CompletionResult]::new('params', 'params', [CompletionResultType]::ParameterValue, 'Get, set, add, delete, rename or toggle a query param')
        [CompletionResult]::new('auth', 'auth', [CompletionResultType]::ParameterValue, 'Get or set a request auth method')
        [CompletionResult]::new('header', 'header', [CompletionResultType]::ParameterValue, 'Get, set, add, delete, rename or toggle a header')
        [CompletionResult]::new('body', 'body', [CompletionResultType]::ParameterValue, 'Get or set a request body')
        [CompletionResult]::new('scripts', 'scripts', [CompletionResultType]::ParameterValue, 'Get or set pre- and post-request scripts')
        [CompletionResult]::new('send', 'send', [CompletionResultType]::ParameterValue, 'Send a request')
        [CompletionResult]::new('settings', 'settings', [CompletionResultType]::ParameterValue, 'Get or set a request setting')
        break
      }
      'atac;help;request;info' {
        break
      }
      'atac;help;request;new' {
        break
      }
      'atac;help;request;delete' {
        break
      }
      'atac;help;request;rename' {
        break
      }
      'atac;help;request;url' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request URL')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request URL')
        break
      }
      'atac;help;request;url;get' {
        break
      }
      'atac;help;request;url;set' {
        break
      }
      'atac;help;request;method' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        break
      }
      'atac;help;request;method;get' {
        break
      }
      'atac;help;request;method;set' {
        break
      }
      'atac;help;request;params' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;help;request;params;get' {
        break
      }
      'atac;help;request;params;set' {
        break
      }
      'atac;help;request;params;add' {
        break
      }
      'atac;help;request;params;delete' {
        break
      }
      'atac;help;request;params;rename' {
        break
      }
      'atac;help;request;params;toggle' {
        break
      }
      'atac;help;request;params;all' {
        break
      }
      'atac;help;request;auth' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request auth method')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request auth method')
        break
      }
      'atac;help;request;auth;get' {
        break
      }
      'atac;help;request;auth;set' {
        [CompletionResult]::new('no-auth', 'no-auth', [CompletionResultType]::ParameterValue, 'No auth method')
        [CompletionResult]::new('basic-auth', 'basic-auth', [CompletionResultType]::ParameterValue, 'Basic auth method')
        [CompletionResult]::new('bearer-token', 'bearer-token', [CompletionResultType]::ParameterValue, 'Bearer token auth method')
        break
      }
      'atac;help;request;auth;set;no-auth' {
        break
      }
      'atac;help;request;auth;set;basic-auth' {
        break
      }
      'atac;help;request;auth;set;bearer-token' {
        break
      }
      'atac;help;request;header' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;help;request;header;get' {
        break
      }
      'atac;help;request;header;set' {
        break
      }
      'atac;help;request;header;add' {
        break
      }
      'atac;help;request;header;delete' {
        break
      }
      'atac;help;request;header;rename' {
        break
      }
      'atac;help;request;header;toggle' {
        break
      }
      'atac;help;request;header;all' {
        break
      }
      'atac;help;request;body' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request body')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request body')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair (multipart & form body only)')
        break
      }
      'atac;help;request;body;get' {
        break
      }
      'atac;help;request;body;set' {
        [CompletionResult]::new('no-body', 'no-body', [CompletionResultType]::ParameterValue, 'no-body')
        [CompletionResult]::new('file', 'file', [CompletionResultType]::ParameterValue, 'file')
        [CompletionResult]::new('multipart', 'multipart', [CompletionResultType]::ParameterValue, 'multipart')
        [CompletionResult]::new('form', 'form', [CompletionResultType]::ParameterValue, 'form')
        [CompletionResult]::new('raw', 'raw', [CompletionResultType]::ParameterValue, 'raw')
        [CompletionResult]::new('json', 'json', [CompletionResultType]::ParameterValue, 'json')
        [CompletionResult]::new('xml', 'xml', [CompletionResultType]::ParameterValue, 'xml')
        [CompletionResult]::new('html', 'html', [CompletionResultType]::ParameterValue, 'html')
        [CompletionResult]::new('javascript', 'javascript', [CompletionResultType]::ParameterValue, 'javascript')
        break
      }
      'atac;help;request;body;set;no-body' {
        break
      }
      'atac;help;request;body;set;file' {
        break
      }
      'atac;help;request;body;set;multipart' {
        break
      }
      'atac;help;request;body;set;form' {
        break
      }
      'atac;help;request;body;set;raw' {
        break
      }
      'atac;help;request;body;set;json' {
        break
      }
      'atac;help;request;body;set;xml' {
        break
      }
      'atac;help;request;body;set;html' {
        break
      }
      'atac;help;request;body;set;javascript' {
        break
      }
      'atac;help;request;body;key' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a key value pair')
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the key value pairs')
        break
      }
      'atac;help;request;body;key;get' {
        break
      }
      'atac;help;request;body;key;set' {
        break
      }
      'atac;help;request;body;key;add' {
        break
      }
      'atac;help;request;body;key;delete' {
        break
      }
      'atac;help;request;body;key;rename' {
        break
      }
      'atac;help;request;body;key;toggle' {
        break
      }
      'atac;help;request;body;key;all' {
        break
      }
      'atac;help;request;scripts' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current pre- or post-request script')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set a pre- or post-request script')
        break
      }
      'atac;help;request;scripts;get' {
        break
      }
      'atac;help;request;scripts;set' {
        break
      }
      'atac;help;request;send' {
        break
      }
      'atac;help;request;settings' {
        [CompletionResult]::new('all', 'all', [CompletionResultType]::ParameterValue, 'Print all the request settings')
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Print the current request setting')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the request method')
        break
      }
      'atac;help;request;settings;all' {
        break
      }
      'atac;help;request;settings;get' {
        break
      }
      'atac;help;request;settings;set' {
        break
      }
      'atac;help;try' {
        break
      }
      'atac;help;env' {
        [CompletionResult]::new('info', 'info', [CompletionResultType]::ParameterValue, 'Describe an environment')
        [CompletionResult]::new('key', 'key', [CompletionResultType]::ParameterValue, 'Add, get or set a key/value pair')
        break
      }
      'atac;help;env;info' {
        break
      }
      'atac;help;env;key' {
        [CompletionResult]::new('get', 'get', [CompletionResultType]::ParameterValue, 'Get the value paired to a key')
        [CompletionResult]::new('set', 'set', [CompletionResultType]::ParameterValue, 'Set the value paired to a key')
        [CompletionResult]::new('add', 'add', [CompletionResultType]::ParameterValue, 'Add a key value pair')
        [CompletionResult]::new('delete', 'delete', [CompletionResultType]::ParameterValue, 'Delete a key')
        [CompletionResult]::new('rename', 'rename', [CompletionResultType]::ParameterValue, 'Rename a key')
        break
      }
      'atac;help;env;key;get' {
        break
      }
      'atac;help;env;key;set' {
        break
      }
      'atac;help;env;key;add' {
        break
      }
      'atac;help;env;key;delete' {
        break
      }
      'atac;help;env;key;rename' {
        break
      }
      'atac;help;import' {
        [CompletionResult]::new('postman', 'postman', [CompletionResultType]::ParameterValue, 'Import a Postman v2.1.0 file')
        [CompletionResult]::new('curl', 'curl', [CompletionResultType]::ParameterValue, 'Import a curl file')
        break
      }
      'atac;help;import;postman' {
        break
      }
      'atac;help;import;curl' {
        break
      }
      'atac;help;completions' {
        break
      }
      'atac;help;man' {
        break
      }
      'atac;help;help' {
        break
      }
    })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
    Sort-Object -Property ListItemText
}
