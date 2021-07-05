<#
    .SYNOPSIS
        Raises and exception if current session is not eleveated
#>
function Assert-IsElevated {
    [CmdletBinding()]
    param()

    if ($false -eq (Test-IsElevated)) {
        throw ([System.InvalidOperationException]::new('Current session is not elevated.'))
    }
}