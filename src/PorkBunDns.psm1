$ii = Get-ChildItem $PSScriptRoot\Functions\*.ps1 -recurse
Foreach ($i in $ii){
    . $i.FullName
}
