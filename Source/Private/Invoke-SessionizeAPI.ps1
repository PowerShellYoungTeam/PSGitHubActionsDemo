function Invoke-SessionizeAPI {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$EventId,

        [Parameter(Mandatory)]
        [string]$Endpoint
    )

    $Url = "https://sessionize.com/api/v2/$EventId/view/$Endpoint"
    Invoke-RestMethod -Uri $Url
}