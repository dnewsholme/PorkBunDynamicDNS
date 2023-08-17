<#
.SYNOPSIS
Creates a DNS record using porkbun api

.PARAMETER name
subdomain name

.PARAMETER domain
domain name to update

.PARAMETER type
type of record eg A

.PARAMETER content
Content to add such as an ip address

.PARAMETER ttl
Time to live

.EXAMPLE
An example

.NOTES
General notes
#>
function New-PorkBunDnsRecord {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false)][String]$name,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false)][String]$domain,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $true)][String]$type,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $true)][String]$content,
        [Parameter(ValueFromPipelineByPropertyName)][String]$ttl
    )

    begin {
    }


    process {
        $body = [PSCustomObject]@{
            "name"         = $name
            "type"         = $type
            "content"      = $content
            "ttl"          = $ttl
        }
        Invoke-PorkBunApi -uri "api/json/v3/dns/create/$domain" -Body $body
    }
    end {

    }
}