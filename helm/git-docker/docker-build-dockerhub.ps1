# -----------------------------------------------------------------------------

Write-Host "$ScriptName"
write-host "There are a total of $($args.count) arguments"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    write-host "Argument  $i is $($args[$i])"
} 

# test -n "$6" && echo CLUSTER is "$6" || "echo CLUSTER is not set && exit"
if ($($args[0]) -eq $null) {
    docker login

    Write-Host "Tags is not set"
    Write-Host "Usage ./${ScriptName} 1.0.0"
    Write-Host "      ./${ScriptName} 1.0.1"
    Write-Host "      ./${ScriptName} 1.1.0"  
    Write-Host "gitmysql tags"
    aws ecr describe-images --repository-name gitmysql | jq .imageDetails[].imageTags[] 
    return ;
}

docker login

$Tag=$($args[0])

Write-Host "Tags is "$Tag

Write-Host "docker build --tag taeeyoul/gitmysql:${Tag} ."
docker build --tag taeeyoul/gitmysql:${Tag} .

docker images

Write-Host "docker push taeeyoul/gitmysql:${Tag}"
docker push "taeeyoul/gitmysql:${Tag}"


# -----------------------------------------------------------------------------