# PSSessionize PowerShell Module
# This module provides functions to interact with the Sessionize API

# Get the path to the module directory
$ModuleRoot = $PSScriptRoot

# Import private functions
$PrivateFunctions = Get-ChildItem -Path (Join-Path $ModuleRoot 'Private') -Filter '*.ps1' -ErrorAction SilentlyContinue

foreach ($Function in $PrivateFunctions) {
    Write-Verbose "Importing private function: $($Function.BaseName)"
    . $Function.FullName
}

# Import public functions and export them
$PublicFunctions = Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter '*.ps1' -ErrorAction SilentlyContinue

foreach ($Function in $PublicFunctions) {
    Write-Verbose "Importing public function: $($Function.BaseName)"
    . $Function.FullName
    Export-ModuleMember -Function $Function.BaseName
}

# Export aliases if any
# Export-ModuleMember -Alias *
