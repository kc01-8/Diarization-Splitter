param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

if (-not (Test-Path $InputFile)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

$content = Get-Content $InputFile -Raw
Write-Host "Total content length: $($content.Length) characters"

# Split content into blocks, treating two or more consecutive newlines as a separator
$blocks = $content -split "(?:\r?\n){2,}"
$speakerFiles = @{}

Write-Host "Total blocks found: $($blocks.Count)"

foreach ($block in $blocks) {
    Write-Host "Processing block:"
    Write-Host $block
    Write-Host "------------------------"

    $lines = $block -split "`r?`n"
    $speakerMatch = $null
    
    foreach ($line in $lines) {
        Write-Host "Checking line: $line"
        if ($line -match '^Speaker (\d+):') {
            $speakerMatch = $matches
            Write-Host "Found speaker match: $($speakerMatch[0])"
            break
        }
    }
    
    if ($speakerMatch) {
        $speakerNumber = $speakerMatch[1]
        $speaker = "Speaker_$speakerNumber"
        Write-Host "Matched speaker: $speaker"
        
        $modifiedLines = $lines | ForEach-Object {
            $_ -replace '^Speaker \d+:\s*', ''
        }
        
        $modifiedBlock = $modifiedLines -join "`n"
        
        if (-not $speakerFiles.ContainsKey($speaker)) {
            $speakerFiles[$speaker] = @()
            Write-Host "Created new array for $speaker"
        }
        $speakerFiles[$speaker] += $modifiedBlock
        Write-Host "Added block to $speaker"
    }
    else {
        Write-Host "No speaker match found in this block"
    }
    Write-Host "------------------------"
}

Write-Host "Speakers found: $($speakerFiles.Keys -join ', ')"

foreach ($speaker in $speakerFiles.Keys) {
    $filename = "$speaker.srt"
    $speakerFiles[$speaker] -join "`n`n" | Out-File -Encoding utf8 -FilePath $filename
    Write-Host "Created file: $filename with $($speakerFiles[$speaker].Count) blocks"
}

Write-Host "Splitting complete. The following files were created:"
$speakerFiles.Keys | ForEach-Object {
    Write-Host "- $_.srt"
}