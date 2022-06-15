Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "geoserver.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- $fullname := default (printf "%s-%s" .Release.Name $name) .Values.fullnameOverride -}}
{{- printf "%s" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "geoserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Get the password secret.
*/}}
{{- define "geoserver.secretName" -}}
{{- if .Values.existingSecret -}}
    {{- printf "%s" (tpl .Values.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "geoserver.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the Image.
*/}}
{{- define "geoserver.image" -}}
{{- printf "%s/%s:%s" .Values.container.image.registry .Values.container.image.repository .Values.container.image.tag -}}
{{- end -}}


{{/*
Return GeoServer password
*/}}
{{- define "geoserver.password" -}}
{{- if .Values.geoserverPassword -}}
    {{- .Values.geoserverPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}


{{/*
Return GeoServer Data Dir storageClass declaration
*/}}
{{- define "geoserver.geoserverDataDir.storageClass" -}}
{{- if .Values.global -}}
	{{- if .Values.global.storageClass -}}
        {{- if (eq "-" .Values.global.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.global.storageClass -}}
        {{- end -}}
    {{- else -}}
        {{- if .Values.persistence.geoserverDataDir.storageClass -}}
              {{- if (eq "-" .Values.persistence.geoserverDataDir.storageClass) -}}
                  {{- printf "storageClassName: \"\"" -}}
              {{- else }}
                  {{- printf "storageClassName: %s" .Values.persistence.geoserverDataDir.storageClass -}}
              {{- end -}}
        {{- end -}}
    {{- end -}}
{{- else -}}
    {{- if .Values.persistence.geoserverDataDir.storageClass -}}
        {{- if (eq "-" .Values.persistence.geoserverDataDir.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.persistence.geoserverDataDir.storageClass -}}
        {{- end -}}
    {{- end -}}
{{- end -}}
{{- end -}}


{{/*
Return GeoServer Geo Web Cache storageClass declaration
*/}}
{{- define "geoserver.geowebcacheCacheDir.storageClass" -}}
{{- if .Values.global -}}
	{{- if .Values.global.storageClass -}}
        {{- if (eq "-" .Values.global.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.global.storageClass -}}
        {{- end -}}
    {{- else -}}
        {{- if .Values.persistence.geowebcacheCacheDir.storageClass -}}
              {{- if (eq "-" .Values.persistence.geowebcacheCacheDir.storageClass) -}}
                  {{- printf "storageClassName: \"\"" -}}
              {{- else }}
                  {{- printf "storageClassName: %s" .Values.persistence.geowebcacheCacheDir.storageClass -}}
              {{- end -}}
        {{- end -}}
    {{- end -}}
{{- else -}}
    {{- if .Values.persistence.geowebcacheCacheDir.storageClass -}}
        {{- if (eq "-" .Values.persistence.geowebcacheCacheDir.storageClass) -}}
            {{- printf "storageClassName: \"\"" -}}
        {{- else }}
            {{- printf "storageClassName: %s" .Values.persistence.geowebcacheCacheDir.storageClass -}}
        {{- end -}}
    {{- end -}}
{{- end -}}
{{- end -}}
