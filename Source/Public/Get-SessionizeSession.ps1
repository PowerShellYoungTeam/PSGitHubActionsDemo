function Get-SessionizeSession {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$EventId,

        [Parameter()]
        [ValidateSet('Sessions','GridSmart','All')]
        [string]$View = 'Sessions'
    )

    Invoke-SessionizeAPI -EventId $EventId -Endpoint $View
}