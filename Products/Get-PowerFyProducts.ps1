function Get-PowerFyProducts {
    <#
    .SYNOPSIS
    Gets a Shopify Products
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
        [string]$token,

        [Parameter(ParameterSetName = 'Path')]
        [Parameter(ParameterSetName = 'Type')]
        [ValidateSet('active', 'Archived', 'Inactive')]
        [string]$status,

        [Parameter(ParameterSetName = 'Path')]
        [Parameter(ParameterSetName = 'Type')]
        [ValidateSet('T-shirt', 'Hoodie', 'Hats', 'Long-Sleeve', 'Mug', 'Tank Top', 'Paper products', 'Home Decor')]
        [string]$Type
    )

    Write-Verbose "Retriving list of Shopify Products"
    $Headers = Get-PowerFyHeader -URI $URI -apikey $apikey -token $token
    $ProductUri = "{0}/admin/products.json" -f $URI

    $Products = $null
    $Products = (Invoke-WebRequest -Uri $ProductUri -contentType  "application/json" -Method   Get -Headers $headers -UseBasicParsing | ConvertFrom-Json).products

    If ($PSCmdlet.ParameterSetName -eq 'Filter') {
        Write-Verbose "Checking for products with a status of $Status"
        $Products = $Products | Where-Object {$_.status -eq $status}
    }

    If ($PSCmdlet.ParameterSetName -eq 'Type') {
        Write-Verbose "Checking for products with a status of $Type"
        $Products = $Products | Where-Object {$_.status -eq $Type}
    }

    $Products
}