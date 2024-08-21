
# Get the current script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Load credentials from creds.json in the same directory
$credsPath = Join-Path -Path $scriptDir -ChildPath "creds.json"
$creds = Get-Content -Raw -Path $credsPath | ConvertFrom-Json

$zoneID = $creds.zoneID
$email = $creds.email
$apiKey = $creds.apiKey

# Path to the last IP log file
$ipLogPath = Join-Path -Path $scriptDir -ChildPath "last_ip.json"

# Get current public IP address
$currentIP = Invoke-RestMethod -Uri "https://api.ipify.org?format=json" | Select-Object -ExpandProperty ip
Write-Host "Current IP Address: $currentIP"

# Load the last logged IP if it exists
if (Test-Path $ipLogPath) {
    $lastIP = Get-Content -Raw -Path $ipLogPath | ConvertFrom-Json
} else {
    $lastIP = ""
}

# Check if the current IP is different from the last logged IP
if ($currentIP -ne $lastIP) {
    Write-Host "IP address has changed. Updating Cloudflare whitelist."

    # Set up headers for Cloudflare API requests
    $headers = @{
        "X-Auth-Email" = $email
        "X-Auth-Key" = $apiKey
        "Content-Type" = "application/json"
    }

    # Remove the old IP from the Cloudflare whitelist if it exists
    if ($lastIP -ne "") {
        $getResponse = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zoneID/firewall/access_rules/rules?mode=whitelist&configuration_value=$lastIP" -Method Get -Headers $headers
        $oldRule = $getResponse.result | Where-Object { $_.configuration.value -eq $lastIP }

        if ($oldRule) {
            $ruleID = $oldRule.id
            try {
                Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zoneID/firewall/access_rules/rules/$ruleID" -Method Delete -Headers $headers
                Write-Host "Removed old IP $lastIP from Cloudflare whitelist."
            } catch {
                Write-Host "Failed to remove old IP $lastIP from Cloudflare whitelist. Error: $_"
            }
        }
    }

    # Add the new IP to the Cloudflare whitelist
    $body = @{
        mode         = "whitelist"
        configuration = @{
            target = "ip"
            value  = $currentIP
        }
        notes        = "Whitelisted via PowerShell script"
    } | ConvertTo-Json

    try {
        $addResponse = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zoneID/firewall/access_rules/rules" -Method Post -Headers $headers -Body $body

        if ($addResponse.success -eq $true) {
            Write-Host "IP $currentIP successfully whitelisted."
            # Log the current IP to the last_ip.json file
            $currentIP | ConvertTo-Json | Set-Content -Path $ipLogPath
        } else {
            Write-Host "Failed to whitelist IP. Error: $($addResponse.errors)"
        }
    } catch {
        Write-Host "Failed to whitelist IP. Error: $_"
    }
} else {
    Write-Host "IP address has not changed. No update necessary."
}
