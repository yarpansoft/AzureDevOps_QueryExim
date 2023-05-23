$user = "John.Doe"
$token = "******************************"
$teamProject = "Project_A/"
$orgUrl = "https://xxxxx.visualstudio.com/"
$sourceQueryFolder = "My Queries"
$targetLocalFolder = "c:/temp/MyQueries"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))

$queriesUrl = "$orgUrl/$teamProject/_apis/wit/queries/$targetQueryFolder"+"?&api-version=5.0"

function InvokePostRequest ($PostUrl, $body)
{   
    return Invoke-RestMethod -Uri $PostUrl -Method Post -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}  -Body $body
}

$files = Get-ChildItem -File -Path $sourceLocalFolder

foreach($wiqlfile in $files)
{
    $wiqlBody = Get-Content $wiqlfile

    InvokePostRequest $queriesUrl $wiqlBody
}