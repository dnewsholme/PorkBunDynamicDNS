$ii = Get-ChildItem $PSScriptRoot\Functions\*.ps1
Foreach ($i in $ii){
    . $i.FullName
}