$localprograms = choco list --localonly
if ($localprograms -like "*firefox*")
{
    choco upgrade firefox -y
}
Else
{
    choco install firefox -y
}