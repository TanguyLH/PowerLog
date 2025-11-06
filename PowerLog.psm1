$global:LogSource = "Deploy"

function Write-LogLine {
    param(
        [string]$Source,
        [string]$Message,
        [string]$Type = "Info",
        [string]$Color
    )
    
    $timestamp = (Get-Date -Format 'dd/MM/yyyy HH:mm:ss') 
    $typePadded = $Type.ToUpper().PadRight(7)

    Write-Host "[" -NoNewline
    Write-Host $timestamp -NoNewline -ForegroundColor DarkGray
    Write-Host "] [" -NoNewline
    Write-Host $typePadded -NoNewline -ForegroundColor $Color
    Write-Host "] [" -NoNewline
    Write-Host $Source.ToUpper() -NoNewline -ForegroundColor $Color
    Write-Host "]" -NoNewline
    Write-Host $Message -NoNewline
    Write-Host 
}

function Set-LogSource {
    param(
        [string]$source
    )
    Set-Variable -Name "LogSource" -Value $source -Scope Global
}

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Type = "Info"
    )
    
    [string]$source = $global:LogSource
    switch ($Type) {
        "Success" { Write-Logline -Source $source -Type $Type -Message $Message -Color Green}
        "Error"   { Write-Logline -Source $source -Type $Type -Message $Message -Color Red }
        "Warning" { Write-Logline -Source $source -Type $Type -Message $Message -Color Yellow }
        "Debug"   { Write-Logline -Source $source -Type $Type -Message $Message -Color Orange }
        "Info"    { Write-Logline -Source $source -Type $Type -Message $Message -Color White }
        default   { Write-Logline -Source $source -Type "DEFAULT" -Message $Message -Color White }
    }
}


