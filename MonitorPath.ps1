### PARAMS
Param (
    [string] $path = ""
)

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $path
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  
    
    Write-Host 
    Write-Host "Welcome to Monitor Path"
    Write-Host "Made by Leandro Carvalho - Dev @ exo"
    Write-Host "---"
    Write-Host "Suivez les Logs ici ou dans le fichier D:\Log\MonitorPath.txt"
    Write-Host 

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $action = { 
        $path = $Event.SourceEventArgs.FullPath
        $fileName = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $date = $(Get-Date)
        $logline = "$date, $changeType, $path"
        Add-content "D:\Log\MonitorPath.txt" -value $logline
        Write-Host "$date, $changeType, $fileName"
    }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -Action $action
    Register-ObjectEvent $watcher "Changed" -Action $action
    Register-ObjectEvent $watcher "Deleted" -Action $action
    Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {
        Start-Sleep 5
    }