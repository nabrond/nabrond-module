# Define the paths to use for importing
$publicPath = Join-Path -Path $PSScriptRoot -ChildPath 'functions'
$internalPath = Join-Path -Path $PSScriptRoot -ChildPath 'internal'

# Import internal functions
foreach ($function in (Get-ChildItem -Path $internalPath, $publicPath -Filter '*.ps1' -Recurse -ErrorAction Ignore)) {
    Write-Debug -Message "Importing function: $($function.FullName)"
    . (Resolve-Path -Path $function.FullName)
}
