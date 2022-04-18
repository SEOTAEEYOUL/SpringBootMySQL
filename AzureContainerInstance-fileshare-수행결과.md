# ACI File Share 수행 결과

### Azure 파일 공유 만들기
```powershell
PS D:\workspace\SpringBootMySQL> $groupName='rg-aci'
PS D:\workspace\SpringBootMySQL> $locationName='koreacentral'
PS D:\workspace\SpringBootMySQL> $serviceName='Homeeee'
PS D:\workspace\SpringBootMySQL> $acrName="acr$serviceName"
PS D:\workspace\SpringBootMySQL> 
PS D:\workspace\SpringBootMySQL> $repositoryName="springmysql"
PS D:\workspace\SpringBootMySQL> $tag='0.2.2'
PS D:\workspace\SpringBootMySQL> $clusterName='aks-cluster-Homeeee'
PS D:\workspace\SpringBootMySQL> 
PS D:\workspace\SpringBootMySQL> # export loginServer="acrhomepage.azurecr.io"
PS D:\workspace\SpringBootMySQL> $loginServer="${acrName}.azurecr.io"
PS D:\workspace\SpringBootMySQL> 
PS D:\workspace\SpringBootMySQL> $storagAccountName='skcc7devacidev01'
PS D:\workspace\SpringBootMySQL> $location='eastus'
PS D:\workspace\SpringBootMySQL> $shareName='acishare'
PS D:\workspace\SpringBootMySQL> az storage account create `
>>   --resource-group $groupName `
>>   --name $storagAccountName `
>>   --location $location `
>>   --sku Standard_LRS
{
  "accessTier": "Hot",
  "allowBlobPublicAccess": true,
  "allowCrossTenantReplication": null,
  "allowSharedKeyAccess": null,
  "allowedCopyScope": null,
  "azureFilesIdentityBasedAuthentication": null,
  "blobRestoreStatus": null,
  "creationTime": "2022-04-18T14:18:12.943502+00:00",
  "customDomain": null,
  "defaultToOAuthAuthentication": null,
  "enableHttpsTrafficOnly": true,
  "enableNfsV3": null,
  "encryption": {
    "encryptionIdentity": null,
    "keySource": "Microsoft.Storage",
    "keyVaultProperties": null,
    "requireInfrastructureEncryption": null,
    "services": {
      "blob": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "2022-04-18T14:18:13.068556+00:00"
      },
      "file": {
        "enabled": true,
        "keyType": "Account",
        "lastEnabledTime": "2022-04-18T14:18:13.068556+00:00"
      },
      "queue": null,
      "table": null
    }
  },
  "extendedLocation": null,
  "failoverInProgress": null,
  "geoReplicationStats": null,
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aci/providers/Microsoft.Storage/storageAccounts/skcc7devacidev01",
  "identity": null,
  "immutableStorageWithVersioning": null,
  "isHnsEnabled": null,
  "isLocalUserEnabled": null,
  "isSftpEnabled": null,
  "keyCreationTime": {
    "key1": "2022-04-18T14:18:13.068556+00:00",
    "key2": "2022-04-18T14:18:13.068556+00:00"
  },
  "keyPolicy": null,
  "kind": "StorageV2",
  "largeFileSharesState": null,
  "lastGeoFailoverTime": null,
  "location": "eastus",
  "minimumTlsVersion": "TLS1_0",
  "name": "skcc7devacidev01",
  "networkRuleSet": {
    "bypass": "AzureServices",
    "defaultAction": "Allow",
    "ipRules": [],
    "resourceAccessRules": null,
    "virtualNetworkRules": []
  },
  "primaryEndpoints": {
    "blob": "https://skcc7devacidev01.blob.core.windows.net/",
    "dfs": "https://skcc7devacidev01.dfs.core.windows.net/",
    "file": "https://skcc7devacidev01.file.core.windows.net/",
    "internetEndpoints": null,
    "microsoftEndpoints": null,
    "queue": "https://skcc7devacidev01.queue.core.windows.net/",
    "table": "https://skcc7devacidev01.table.core.windows.net/",
    "web": "https://skcc7devacidev01.z13.web.core.windows.net/"
  },
  "primaryLocation": "eastus",
  "privateEndpointConnections": [],
  "provisioningState": "Succeeded",
  "publicNetworkAccess": null,
  "resourceGroup": "rg-aci",
  "routingPreference": null,
  "sasPolicy": null,
  "secondaryEndpoints": null,
  "secondaryLocation": null,
  "sku": {
    "name": "Standard_LRS",
    "tier": "Standard"
  },
  "statusOfPrimary": "available",
  "statusOfSecondary": null,
  "tags": {},
  "type": "Microsoft.Storage/storageAccounts"
}

### Create the file share
PS D:\workspace\SpringBootMySQL> az storage share create `
>>   --name $shareName `
>>   --account-name $storagAccountName

There are no credentials provided in your command and environment, we will query for account key for your storage account.
It is recommended to provide --connection-string, --account-key or --sas-token in your command as credentials.

In addition, setting the corresponding environment variables can avoid inputting credentials in your command. Please use --help to get more information about environment variable usage.
{
  "created": true
}
PS D:\workspace\SpringBootMySQL> 
```

### 스토리지 자격 증명 가져오기
```
PS D:\workspace\SpringBootMySQL> echo $storagAccountName
skcc7devacidev01
PS D:\workspace\SpringBootMySQL> $storageKey=$(az storage account keys list --resource-group $groupName --account-name $storagAccountName --query "[0].value" --output tsv)
PS D:\workspace\SpringBootMySQL> echo $storageKey
nA7ME6E+R17SDZP3S1UKn5SnTEzCDzLXgn6hX6JrIHsH8GR/b/83VG4dJZ7NGymu3B2GSWcLuijC+AStJwRtRg==
PS D:\workspace\SpringBootMySQL> 
```

### 컨테이너 및 탑재 볼륨 배포 - CLI
```
PS D:\workspace\SpringBootMySQL> az container create `
>>   --resource-group $groupName `
>>   --name hellofiles `
>>   --image mcr.microsoft.com/azuredocs/aci-hellofiles `
>>   --dns-name-label aci-demo `
>>   --ports 80 `
>>   --azure-file-volume-account-name $storagAccountName `
>>   --azure-file-volume-account-key $storageKey `
>>   --azure-file-volume-share-name $shareName `
>>   --azure-file-volume-mount-path /aci/logs/
{
  "containers": [
    {
      "command": null,
      "environmentVariables": [],
      "image": "mcr.microsoft.com/azuredocs/aci-hellofiles",
      "instanceView": {
        "currentState": {
          "detailStatus": "",
          "exitCode": null,
          "finishTime": null,
          "startTime": "2022-04-18T14:30:44.139000+00:00",
          "state": "Running"
        },
        "events": [],
        "previousState": null,
        "restartCount": 0
      },
      "livenessProbe": null,
      "name": "hellofiles",
      "ports": [
        {
          "port": 80,
          "protocol": "TCP"
        }
      ],
      "readinessProbe": null,
      "resources": {
        "limits": null,
        "requests": {
          "cpu": 1.0,
          "gpu": null,
          "memoryInGb": 1.5
        }
      },
      "volumeMounts": [
        {
          "mountPath": "/aci/logs/",
          "name": "azurefile",
          "readOnly": null
        }
      ]
    }
  ],
  "diagnostics": null,
  "dnsConfig": null,
  "encryptionProperties": null,
  "id": "/subscriptions/9ebb0d63-8327-402a-bdd4-e222b01329a1/resourceGroups/rg-aci/providers/Microsoft.ContainerInstance/containerGroups/hellofiles",
  "identity": null,
  "imageRegistryCredentials": null,
  "initContainers": [],
  "instanceView": {
    "events": [
      {
        "count": 1,
        "firstTimestamp": "2022-04-18T14:30:43.584000+00:00",
        "lastTimestamp": "2022-04-18T14:30:43.584000+00:00",
        "message": "Successfully mounted Azure File Volume.",
        "name": "SuccessfulMountAzureFileVolume",
        "type": "Normal"
      }
    ],
    "state": "Running"
  },
  "ipAddress": {
    "autoGeneratedDomainNameLabelScope": "Unsecure",
    "dnsNameLabel": "aci-demo",
    "fqdn": "aci-demo.koreacentral.azurecontainer.io",
    "ip": "20.214.66.25",
    "ports": [
      {
        "port": 80,
        "protocol": "TCP"
      }
    ],
    "type": "Public"
  },
  "location": "koreacentral",
  "name": "hellofiles",
  "osType": "Linux",
  "provisioningState": "Succeeded",
  "resourceGroup": "rg-aci",
  "restartPolicy": "Always",
  "sku": "Standard",
  "subnetIds": null,
  "tags": {},
  "type": "Microsoft.ContainerInstance/containerGroups",
  "volumes": [
    {
      "azureFile": {
        "readOnly": null,
        "shareName": "acishare",
        "storageAccountKey": null,
        "storageAccountName": "skcc7devacidev01"
      },
      "emptyDir": null,
      "gitRepo": null,
      "name": "azurefile",
      "secret": null
    }
  ],
  "zones": null
}
PS D:\workspace\SpringBootMySQL> 
```

### 탑재된 볼륨의 파일 관리
```
PS D:\workspace\SpringBootMySQL> az container show --resource-group $groupName `
>>   --name hellofiles --query ipAddress.fqdn --output tsv
aci-demo.koreacentral.azurecontainer.io
PS D:\workspace\SpringBootMySQL> 
```
aci-demo.koreacentral.azurecontainer.io

### 컨테이너 및 탑재 볼륨 배포 - YAML
```
apiVersion: '2019-12-01'
location: eastus
name: file-share-demo
properties:
  containers:
  - name: hellofiles
    properties:
      environmentVariables: []
      image: mcr.microsoft.com/azuredocs/aci-hellofiles
      ports:
      - port: 80
      resources:
        requests:
          cpu: 1.0
          memoryInGB: 1.5
      volumeMounts:
      - mountPath: /aci/logs/
        name: filesharevolume
  osType: Linux
  restartPolicy: Always
  ipAddress:
    type: Public
    ports:
      - port: 80
    dnsNameLabel: aci-demo
  volumes:
  - name: filesharevolume
    azureFile:
      sharename: acishare
      storageAccountName: <Storage account name>
      storageAccountKey: <Storage account key>
tags: {}
type: Microsoft.ContainerInstance/containerGroups
```