function Test-IsElevated {
    [CmdletBinding()]
    param()

    # Get the principal object for the current identity
    $principal = [System.Security.Principal.WindowsIdentity]::GetCurrent() -as [System.Security.Principal.WindowsPrincipal]

    # Return whether the current user is in the Administrators group
    return $principal.IsInRole('Administrator')
}