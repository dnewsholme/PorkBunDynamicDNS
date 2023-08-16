
function Invoke-PorkBunApi {
    [CmdletBinding()]
    [OutputType([int])]
    param(
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false)]
        [string]
        $Apikey,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false)]
        [string]
        $ApiSecret,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $false)]
        $body,
        [Parameter(ValueFromPipelineByPropertyName, Mandatory = $true)]
        [string]
        $uri

    )

    begin {
        if (!$Apikey -and !$ApiSecret) {
            $apikey = $env:porkbunapikey
            $ApiSecret = $env:porkbunapisecret
        }
    }

    process {
        if (!$body) {
            $body = [PSCustomObject]@{
                apikey       = $Apikey
                secretapikey = $Apisecret
            }
        }
        if ($body.GetType().Name -eq 'String') {
            $body = $body | ConvertFrom-Json
        }
        if (!$body.apikey -and !$body.secretapikey) {
            Write-Verbose "Adding api keys"
            $body | Add-Member NoteProperty -Name apikey -Value $Apikey
            $body | Add-Member NoteProperty -Name secretapikey -Value $Apisecret
        }
        Write-Verbose "$($body | ConvertTo-Json)"
        Write-Verbose "https://porkbun.com/$uri"
        Invoke-RestMethod "https://porkbun.com/$uri" -Body ($body | ConvertTo-Json) -Method Post

    }

    end {
    }
}
