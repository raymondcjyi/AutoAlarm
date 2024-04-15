#AutoAlarm powershell program 

function ContinuousBeep {
    while ($true) {
        [console]::Beep()
        Start-Sleep -Milliseconds 500
    }
}

$Alarm = $true
# Main loop
while ($true) {
    
    while ($Alarm)
    {
      	$beepJob = Start-Job -ScriptBlock ${function:ContinuousBeep}
        $intervalSeconds = Read-Host "Enter new time interval in seconds (or 'exit' to stop)"
        if ($null -eq $intervalSeconds) {
        	continue
      	}else
      	{
      		  Write-Host "Alarm stopped."
         		Stop-Job -Job $beepJob
          	Start-Sleep -Seconds $intervalSeconds
  		      continue
      	}
    }
}
