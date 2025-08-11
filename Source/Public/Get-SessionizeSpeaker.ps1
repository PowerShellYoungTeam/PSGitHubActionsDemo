function Get-SessionizeSpeaker {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$EventId
    )

    Invoke-SessionizeAPI -EventId $EventId -Endpoint 'Speakers'
}