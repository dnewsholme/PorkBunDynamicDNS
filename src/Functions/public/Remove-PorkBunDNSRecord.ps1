<#
.SYNOPSIS
Removes a Record from porkbun dns

.PARAMETER ID
ID of Record to be removed (optional)

.PARAMETER domain
Domain the record resides on

.PARAMETER Subdomain
The domain record to be removed

.PARAMETER Type
Type of record eg A

.EXAMPLE
Remove-PorkBunDnsRecord -domain example.com -subdomain support -type A

.NOTES
General notes
#>
function Remove-PorkBunDnsRecord {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false,ParameterSetName="ID")]
        [string]
        $ID,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false)]
        [string]
        $domain,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false,ParameterSetName="subdomain")]
        [string]
        $Subdomain,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false,parametersetname="subdomain")]
        [string]
        $Type

    )

    begin {
    }

    process {
        if ($ID){
            Invoke-PorkBunApi -uri "api/json/v3/dns/delete/$domain/$ID"
        }
        if (!$SUBDOMAIN -and $type) {
            Invoke-PorkBunApi -uri "api/json/v3/dns/deleteByNameType/$domain/$type"
        }
        Elseif ($Subdomain -and $type) {
            Invoke-PorkBunApi -uri "api/json/v3/dns/deleteByNameType/$domain/$type/$subdomain"
        }
    }
    end {
    }
}
