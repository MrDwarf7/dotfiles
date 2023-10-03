# export applications
scoop export | ForEach-Object  {
    $_ -match '([A-Za-z0-9\-\_]+)'
    if ($matches.Count -gt 1) {
        $matches[1]
    }
} > apps.txt

# export used buckets
$buckets = scoop export | ForEach-Object {
    $_ -match '\[([A-Za-z0-9\-\_]+)\]'
    if ($matches.Count -gt 1) {
        $matches[1]
    }
} | Select-Object -Unique

# Output the unique bucket names
$buckets

