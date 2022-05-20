# Octopus Helm Chart

This Helm chart deploys a HA Octopus cluster (or a standalone Octopus instance when the replica count is 1).

Kuberenetes v1.16 is required to deploy this chart.

SQL Server is not bundled, as I prefer an external deployment for that which supports HA - see our chart here: https://artifacthub.io/packages/helm/mssql-server-2019/mssql-linux

Generate a new master key with this command:

```
openssl rand 16 | base64
```

Deploy the chart with the command:

```
helm repo add octopus https://simcubeltd.github.io/simcube-helm-charts/
helm repo update
helm install octopus octopus/octopusdeploy --set octopus.username=admin --set octopus.password=Password01! --set octopus.licenseKeyBase64=<your Octopus license key base64 encoded> --set octopus.masterKey=YOUR_GENERATED_KEY
```

# Typical example of values

```
octopus:
  image: octopusdeploy/octopusdeploy:2022.1.2641
  username: admin
  password: Password01!
  licenseKeyBase64: base 64 encoded license file goes here
  masterKey: build me with 'openssl rand 16 | base64'
  acceptEula: !!str "Y"
  replicaCount: 3
  storageClassName: "longhorn"
  pollingTentacles:
    exposeServices: true
```

# Support

This repository is licensed under the MIT license and provided as-is with no support.
