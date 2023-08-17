try {
    import-module "$PSScriptRoot\PorkBunDNS\PorkBunDns.psm1" -ErrorAction stop
}
Catch {
    import-module ".\PorkBunDns.psm1"
}
if ($env:FREQUENCY) {
    $frequency = $env:FREQUENCY
}
else { $frequency = 300 }

While ($loop -ne $false) {
    # Get List of Domains to update
    $porkbundynamicdnsdomains = $env:porkbundynamicdnsdomains.Split(" ")
    # Get External IP
    $ip = (Test-PorkBunApi -verbose).yourIP
    #$ip = "8.8.8.8"
    foreach ($domainname in $porkbundynamicdnsdomains) {
        Write-Host "[$(Get-Date -format G)] Processing $domainname"
        # Convert domain name into subdomain and domain.
        $subdomain, $domain = $domainname.split(".")
        if ($domain.count -gt 1) {
            $ndomain = $null
            # may be a multi part domain like .co.uk for example
            foreach ($i in $domain) {
                $ndomain += ".$i"
            }
            $domain = $ndomain.Substring(1)
        }
        # Check for an existing record before creating a new one.
        try {
            $result = Get-PorkBunDnsRecord -domain $domain -Subdomain $subdomain -Type A -verbose
        }
        Catch {
            if ($_.ErrorDetails.Message -like "*Invalid domain*") {
                # The split may have gone wrong due to being a record for the root of the domain so try again with only the domain name.
                $domain = $domainname
                $subdomain = $null
                $result = Get-PorkBunDnsRecord -domain $domainname -Type A -verbose
            }
        }
        if ($result.content -eq $ip) {
            Write-Host "[$(Get-Date -format G)] Record Already Matches IP $ip"
            continue
        }
        if ($null -eq $result) {
            Write-Host "[$(Get-Date -format G)] No Existing Record Creating a new one"
            # Create a new dns record
            New-PorkBunDnsRecord -name $subdomain -domain $domain -type A -ttl 600 -content $ip -verbose
        }
        Else {
            Write-Host "[$(Get-Date -format G)] IP Doesn't match Updating record"
            # Otherwise update the existing record
            Update-PorkBunDnsRecord -name $subdomain -domain $domain -type A -ttl 600 -content $ip -Verbose
        }
    }
    Start-Sleep -Seconds $frequency
}
