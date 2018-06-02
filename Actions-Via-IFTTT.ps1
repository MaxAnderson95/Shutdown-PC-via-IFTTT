#Declare Variables
$SearchDirectory = "C:\Users\cag22\Dropbox\IFTTT"
$SleepTime = 5


#Main Loop
Do {

#Removes the shutdown file from the directory, in case the file was not deleted. Sets the error action in case the file is not present.
Remove-Item -Path "$SearchDirectory\shutdown.txt" -Force -ErrorAction SilentlyContinue
$muteCheck = $False
$unmuteCheck =$False
$shutdownCheck = $False
$netflixCheck = $False

#Loop checking to see if the file has been created and once it has it continues on. Sleep in the look to prevent CPU pegging
    Do {
    Start-Sleep -Seconds $SleepTime
    $muteCheck = Test-Path -Path "$SearchDirectory\mute.txt"
    $unmuteCheck = Test-Path -Path "$SearchDirectory\unmute.txt"
    $shutdownCheck = Test-Path -Path "$SearchDirectory\shutdown.txt"
    $netflixCheck = Test-Path -Path "$SearchDirectory\netflix.txt"

       }
        Until (
        ($muteCheck -eq $True) -or 
        ($unmuteCheck -eq $True) -or
        ($shutdownCheck -eq $True) -or
        ($netflixCheck -eq $True)
        )

#if $muteCheck then mute computer & reset variable
    if ($muteCheck -eq $True) { 
    Remove-Item -Path "$SearchDirectory\mute.txt"
        nircmd mutesysvolume 1
            $muteCheck = $False
    }

#if $unmuteCheck then unmute computer & reset variable
    if ($unmuteCheck -eq $True) {
    Remove-Item -Path "$SearchDirectory\unmute.txt"
        nircmd mutesysvolume 0
            $unmuteCheck = $False
    }

#if $shutdownCheck then shutdown computer & reset variable
    if ($shutdownCheck -eq $True) {
    Remove-Item -Path "$SearchDirectory\shutdown.txt"
        nircmd initshutdown "" 15
            $shutdownCheck = $False
    }

#if $netflixCheck then open netflix & reset variable
    if ($netflixCheck -eq $True) {
    Remove-Item -Path "$SearchDirectory\netflix.txt"
        start chrome.exe netflix.com
            $netflixCheck = $False
    }

}
    Until (0)