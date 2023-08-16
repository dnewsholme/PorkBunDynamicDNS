<#
.SYNOPSIS
    Tests your api credentials against the pork bun api and returns your current external ip address.
.DESCRIPTION
    Tests your api credentials against the pork bun api and returns your current external ip address.
.EXAMPLE
   Test-Porkbunapi
#>
function Test-PorkBunApi {
    [CmdletBinding()]
    [OutputType([int])]
    param(
    )

    begin {
    }

    process {
        Invoke-PorkBunApi -uri 'api/json/v3/ping'
    }

    end {
    }
}
