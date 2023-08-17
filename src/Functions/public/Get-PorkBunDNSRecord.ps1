<#
.SYNOPSIS
   Gets a record from the porkbun dns api
.PARAMETER domain
    The domain to get the record from
.PARAMETER subdomain
    subdomain if you would like to filter the records. Leave blank to get all
.PARAMETER type
    Type of records to retrieve eg A. Leave blank to get all
.EXAMPLE
    Get-PorkBunDnsRecord -domain example.com
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
