{{- define "pace-calculator.labels" }}
  app.kubernetes.io/name: {{ quote .Values.name }}
  app.kubernetes.io/instance: {{ .Release.Name }}
  app.kubernetes.io/managed-by: {{ .Release.Service }}
  helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{ end -}}
