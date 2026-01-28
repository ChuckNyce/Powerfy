function Get-PowerFyHeader {
    <#
    .SYNOPSIS
    Gets a Shopify Header
    .DESCRIPTION
    This Function will get a shopify Header
    .PARAMETER URI
    Shopify URI
    .PARAMETER apikey
    Shopify API key
    .PARAMETER token
    Shopify Token
    .EXAMPLE
    Get-PowerFyHeader -URI $BaseURI -apikey $apikey -token $password
    #>
    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True)]
        [string]$URI,
        [Parameter(Mandatory = $True)]
        [string]$apikey,
        [Parameter(Mandatory = $True)]
        [string]$token
    )

    Write-Verbose "Getting Header for Shopify"

    $headers = @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($apikey+":"+$password))}

    $headers
}