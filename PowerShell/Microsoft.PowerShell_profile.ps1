$global:DefaultUser = "Betim"
oh-my-posh init pwsh --config "$(scoop prefix oh-my-posh)\themes\custom.omp.json" | Invoke-Expression 

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord "Ctrl+j" -Function NextHistory
Set-PSReadLineKeyHandler -Chord "Ctrl+k" -Function PreviousHistory
Set-PSReadLineOption -PredictionViewStyle ListView

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias np C:\Windows\notepad.exe
Set-Alias g git

function gitStatus { git status}
Set-Alias -Name gst -Value gitStatus

function gitPull { git pull }
Set-Alias -Name gpl -Value gitPull
