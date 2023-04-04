#Aliases 
Set-Alias tt tree
Set-Alias ll ls
Set-Alias g git
Set-Alias vim nvim


oh-my-posh init pwsh | Invoke-Expression

Import-Module Terminal-Icons

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionViewStyle ListView 