if (-not (Get-Module -ListAvailable -Name ModuleBuilder)) {
    Write-Host "ModuleBuilder not found. Installing from PSGallery..."
    Install-Module -Name ModuleBuilder -Scope CurrentUser -Force
}
import-module ModuleBuilder
Build-Module $PSScriptRoot