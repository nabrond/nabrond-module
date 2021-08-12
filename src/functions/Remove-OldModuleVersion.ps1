[CmdletBinding(SupportsShouldProcess = $true)]
param (
    [Parameter()]
    [String[]]
    $Name,

    [Parameter()]
    [ValidateSet('CurrentUser','AllUsers')]
    [String]
    $Scope = 'CurrentUser'
)

Filter LimitModulesByPath {
    Write-Debug "Module: $($PSItem.Name); Path = '$($PSItem.ModuleBase)'"

    # By default, allow all paths through the gate
    $pathsToExclude = '*'

    if ($Scope -eq 'CurrentUser') {
        Write-Debug 'Evaluating: IsUserScoped'
        $pathFilter = "$env:UserProfile*"
    }

    if ($host.Name -eq 'Visual Studio Code Host') {
        Write-Debug 'Evaluating: IsVSCodeExtension'
        $pathFilter = "$env:UserProfile\.vscode\extensions\*"
    }

    if ($PSItem.ModuleBase -like $pathFilter) {
        Write-Debug 'Module matched pattern.'
        return $PSItem
    }
}

if ($Name.Count -eq 0) {
    Write-Verbose 'Detecting available modules.'
    # Get all modules
    $Name = Get-Module -ListAvailable |
        LimitModulesByPath |
        Select-Object -ExpandProperty Name
}

foreach ($moduleName in $Name) {
    Write-Verbose "Processing module '$moduleName'"
    
    if (Get-Module -Name $moduleName) {
        Write-Verbose 'Unloading module.'
        Remove-Module -Name $moduleName -Force
    }

    $moduleVersions = Get-Module -ListAvailable -Name $moduleName |
        LimitModulesByPath |
        Sort-Object -Property Version -Descending |
        Select-Object -Skip 1

    foreach ($moduleVersion in $moduleVersions) {
        $currentModuleString = "version '$($moduleVersion.Version)' of module '$($moduleVersion.Name)'"

        Write-Verbose "Unloading $currentModuleString"
        
        Get-Module -Name $moduleVersion.Name | 
            Where-Object -Property Version -eq $moduleVersion.Version |
            Remove-Module -Force        

        Write-Verbose "Removing $currentModuleString"

        if ($PSCmdlet.ShouldProcess($currentModuleString, 'Remove')) {
            Write-Debug "Removing path '$($moduleVersion.ModuleBase)'"
            (Get-Item -Path $moduleVersion.ModuleBase).Delete($true)
        }
    }
}
