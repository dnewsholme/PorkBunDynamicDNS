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