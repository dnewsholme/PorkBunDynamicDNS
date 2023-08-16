<#
.SYNOPSIS
    Tests your api credentials against the pork bun api and returns your current external ip address.
.DESCRIPTION
    Tests your api credentials against the pork bun api and returns your current external ip address.
.EXAMPLE
   Test-Porkbunapi
.EXAMPLE
    Test-Porkbunapi -apikey xxxxxxxxxxxxxxxxxx -apisecret xxxxxxxxxxxxxxx
#>
function Get-PorkBunDnsRecord {
    [CmdletBinding()]
    [OutputType([int])]
    param(
        [Parameter(ValueFromPipelineByPropertyName,Mandatory=$true)]
        [string]
        $domain,
        [Parameter(ValueFromPipelineByPropertyName,Mandatory=$false)]
        [string]
        $Subdomain,
        [Parameter(ValueFromPipelineByPropertyName,Mandatory=$false)]
        [string]
        $Type
    )

    begin {
    }

    process {
        if (!$Subdomain -and !$Type){
            (Invoke-PorkBunApi -uri "api/json/v3/dns/retrieve/$domain").Records
        }
        elseif (!$SUBDOMAIN -and $type){
            (Invoke-PorkBunApi -uri "api/json/v3/dns/retrieveByNameType/$domain/$type").Records

        }
        Elseif ($Subdomain -and $type){
            (Invoke-PorkBunApi -uri "api/json/v3/dns/retrieveByNameType/$domain/$type/$subdomain").Records
        }
        
    }

    end {
    }
}
