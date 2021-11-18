$global:DefaultUser = [System.Environment]::UserName
# Import-Module posh-git
Import-Module oh-my-posh
Import-Module -Name Terminal-Icons
Set-PoshPrompt -Theme paradox

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord "Ctrl+k" -Function ForwardChar
