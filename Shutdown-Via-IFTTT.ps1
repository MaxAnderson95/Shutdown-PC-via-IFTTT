#Declare Variables
$SearchDirectory = "C:\Users\Max\Dropbox\IFTTT"
$SleepTime = 5

#Removes the file from the directory, in case the file was not deleted. Sets the error action in case the file is not present.
Remove-Item -Path "$SearchDirectory\shutdown.txt" -Force -ErrorAction SilentlyContinue

#Loop checking to see if the file has been created and once it has it continues on. Sleep in the look to prevent CPU pegging
Do {
Start-Sleep -Seconds $SleepTime
$FileCheck = Test-Path -Path "$SearchDirectory\shutdown.txt"
}
Until ($FileCheck -eq $True)

#Removes the shutdown file to prevent an imediate shutdown when the computer starts back up
Remove-Item -Path "$SearchDirectory\shutdown.txt"

#Shuts the computer down forcefully but gracefully
Stop-Computer -Force
