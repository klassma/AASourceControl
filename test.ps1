$dev = $false

if ($dev) {
    $uri = 'https://mswsautomation.blob.core.windows.net/dev/students.zip?sp=r&st=2018-09-05T01:15:03Z&se=2019-09-05T09:15:03Z&spr=https&sv=2017-11-09&sig=gZUiYOi3tXWhjdlzvi7%2Fr4zsMO6MiCFGoHfi934VTFc%3D&sr=b'
}
else {
    $uri = 'https://mswsautomation.blob.core.windows.net/master/students.zip?sp=r&st=2018-09-05T01:17:18Z&se=2019-09-05T09:17:18Z&spr=https&sv=2017-11-09&sig=zjkcXf50%2BiFloeaitr8tqw6eWkAlDQ2miLR%2B5Tp8ocE%3D&sr=b'
}

if (!(Test-Path C:\Temp)) {
    New-Item C:\Temp -ItemType 'Directory' -Force
}

Invoke-WebRequest -Uri $uri -UseBasicParsing -OutFile C:\Temp\students.zip

Expand-Archive -Path C:\Temp\students.zip -DestinationPath C:\Temp\Students -Verbose

$sources = "C:\Temp\Students\Students\Labs", "C:\Temp\Students\Students\Slides"

foreach ($source in $sources) {
    $robocopyCmd = "$source $($source.Replace('\Temp\Students\Students','')) /E /XC /XO /XN"
    Write-Output $robocopyCmd
    Start-Process -FilePath robocopy -ArgumentList $robocopyCmd | Out-Null
}
