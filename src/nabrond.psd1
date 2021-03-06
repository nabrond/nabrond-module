@{
    GUID              = 'bf8c9148-e328-421f-99e4-c2eecd8a1dba'
    RootModule        = 'nabrond.psm1'
    ModuleVersion     = '0.1'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    Author            = 'nabrond'
    CompanyName       = 'nabrond'
    Copyright         = '(c) nabrond. All rights reserved.'
    
    Description       = 'Collection of functions I use for various purposes.'
    PowerShellVersion = '5.0.0'

    FunctionsToExport = @(
        'Assert-IsElevated',
        'Test-IsElevated'
    )

    # CmdletsToExport   = '*'
    # VariablesToExport = '*'
    # AliasesToExport   = '*'

    <# 
    Private data to pass to the module specified in RootModule/ModuleToProcess. 
    This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    #>
    PrivateData       = @{
        PSData = @{
            Tags       = @('Helper', 'Personal')
            ProjectUri = 'https://github.com/nabrond/nabrond-module'
        }
    }
}
