# Add necessary .NET assembly for Windows Forms (for Pop up alert)
Add-Type -AssemblyName System.Windows.Forms

function ContinuousBeep {
    while ($true) {
        [console]::Beep()
        Start-Sleep -Milliseconds 500
    }
}

$Alarm = $true

while ($true) {
    
    while ($Alarm) {
  	$beepJob = Start-Job -ScriptBlock ${function:ContinuousBeep}
	[System.Windows.Forms.MessageBox]::Show("Alarm pop-up alert!", "Alarm")
        $intervalSeconds = Read-Host "Enter new time interval in seconds (or 'exit' to stop)"
        if ($null -eq $intervalSeconds) {
        	continue
    	}elseif ($intervalSeconds -eq "exit") {
		Stop-Job -Job $beepJob
    		Write-Host "Alarm stopped and exiting program"
		exit
    	}else {
       		Stop-Job -Job $beepJob
 		Write-Host "Alarm stopped and triggering in the next $intervalSeconds seconds"
        	Start-Sleep -Seconds $intervalSeconds
		continue
	}
    }
}
