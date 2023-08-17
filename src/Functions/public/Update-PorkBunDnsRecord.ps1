<#
.SYNOPSIS
Updates an existing porkbun dns record

.PARAMETER name
Name of the record

.PARAMETER domain
The domain the record resides on

.PARAMETER type
The type of record eg A

.PARAMETER content
Content to update such as an ip address or string if txt record

.PARAMETER ttl
time to live for the dns record minimum is 600

.EXAMPLE
Update-PorkBunDnsRecord -name support -domain example.com -type A -content 8.8.8.8 -ttl 600

#>
function Update-PorkBunDnsRecord {
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
            "content"      = $content
            "ttl"          = $ttl
        }
        Invoke-PorkBunApi -uri "api/json/v3/dns/editByNameType/$domain/$type/$name" -Body $body
    }
    end {

    }
}