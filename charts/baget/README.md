# HELM Chart for BaGet Nuget Package and Symbol Server

## Chart Components

* Creates a BaGet nuget and symbol server
* Creates a Kubernetes Service on specified port (default: 8080)
* Creates a Secret to hold API_KEY

### Api Key Retrieval

The api key is a randomized in the secret.yaml file.  To retrieve the api key, perform the following steps once you install the helm chart.

```console
$ printf $(kubectl get secret --namespace <namespace> baget-apikey-secret -o jsonpath="{.data.apiKey}" | base64 --decode);echo
...
```