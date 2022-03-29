#!/bin/bash

$args.count

if ( $args.count -eq 0 ) {
Write-Host " 
docker-tags.ps1  --  list all tags for a Docker image on a remote registry.
EXAMPLE:
    - list all tags for ubuntu:
       dockertags ubuntu
    - list all php tags containing apache:
       dockertags php apache
"
exit 0
}

$image="$args"
$image
# tags=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`
$tags=(wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  |  %{$_ -replace('"', '')} | %{$_ -replace(' ', '')} | %{$_ -replace('}', "`n")} | awk -F: '{print $3}')
if ( $null -eq $tags )
{
    Write-Host "$image is null"
    exit
}

Write-Host $image
wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  |  %{$_ -replace('"', '')} | %{$_ -replace(' ', '')} | %{$_ -replace('}', "`n")} | awk -F: '{print $3}'