function Resolve-ShortcutFile {
    <#
    .Synopsis
        Resolves an Internet shortcut file to the web site the shortcut references
    .Description
        Parses an Internet shortcut file and returns a property bag containing the
        shortcut file and the URL it resolves to.
    .Parameter fileName
        The shortcut file name.  Aliased to FullName so that it works well with the output of Get-ChildItem.
    .Example
        # Resolves every shortcut in your favorites directory
        Get-ChildItem (Join-Path $env:UserProfile Favorites) -Recurse | Resolve-ShortcutFile
    .Link
        Get-Content
    .Link
        Get-Item
    .Link
        Select-Object
    .Link
        Where-Object
    #>
    param(
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        [Alias("FullName")]
        [string]
        $fileName
    )
    process {
        if ($fileName -like "*.url") {
            Get-Content $fileName | Where-Object {
                $_ -like "url=*"
            } |
            Select-Object @{
                Name       = 'ShortcutFile'
                Expression = { Get-Item $fileName }
            }, @{
                Name       = 'Url'
                Expression = { $_.Substring($_.IndexOf("=") + 1 ) }
            }
        }
    }
}
