#!/bin/bash

# Configuración
ZEPPELIN_HOST="localhost"  # Cambia si tu Zeppelin no está en localhost
ZEPPELIN_PORT="8080"       # Puerto del servidor Zeppelin
INTERPRETER_NAME="hive"    # Nombre del intérprete a comprobar/crear
GROUP="jdbc"               # Grupo del intérprete (en tu caso "jdbc")

# Esperar hasta que Zeppelin esté disponible en el puerto 8080
until curl -s http://zeppelin:8080/api/version > /dev/null; do
  echo "Esperando que Zeppelin esté listo..."
  sleep 5
done

# Aquí puedes llamar a la función de agregar intérprete
echo "Zeppelin está listo. Añadiendo el intérprete..."

# Comprobar si el intérprete ya existe
EXISTING=$(curl -s -X GET http://${ZEPPELIN_HOST}:${ZEPPELIN_PORT}/api/interpreter/setting | grep -o '"name": *"'"$INTERPRETER_NAME"'"' | awk -F': "' '{print $2}' | tr -d '"')

if [ "$EXISTING" == "$INTERPRETER_NAME" ]; then
  echo "El intérprete '${INTERPRETER_NAME}' ya existe. No se realizará ningún cambio."
  exit 0
fi

# Payload para añadir el intérprete
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://${ZEPPELIN_HOST}:${ZEPPELIN_PORT}/api/interpreter/setting \
-H "Content-Type: application/json" \
-d '{
  "id": "'"${INTERPRETER_NAME}"'",
  "name": "'"${INTERPRETER_NAME}"'",
  "group": "'"${GROUP}"'",
  "properties": {
    "default.url": {
      "name": "default.url",
      "value": "jdbc:hive2://hiveserver:10000/default",
      "type": "string",
      "description": "The URL for JDBC."
    },
    "default.user": {
      "name": "default.user",
      "value": "",
      "type": "string",
      "description": "The JDBC user name"
    },
    "default.password": {
      "name": "default.password",
      "value": "",
      "type": "password",
      "description": "The JDBC user password"
    },
    "default.driver": {
      "name": "default.driver",
      "value": "org.apache.hive.jdbc.HiveDriver",
      "type": "string",
      "description": "JDBC Driver Name"
    },
    "default.completer.ttlInSeconds": {
      "name": "default.completer.ttlInSeconds",
      "value": "120",
      "type": "number",
      "description": "Time to live sql completer in seconds (-1 to update everytime, 0 to disable update)"
    },
    "default.completer.schemaFilters": {
      "name": "default.completer.schemaFilters",
      "value": "",
      "type": "textarea",
      "description": "Comma separated schema filters to get metadata for completions."
    },
    "common.max_count": {
      "name": "common.max_count",
      "value": "1000",
      "type": "number",
      "description": "Max number of SQL result to display."
    },
    "zeppelin.jdbc.auth.type": {
      "name": "zeppelin.jdbc.auth.type",
      "value": "",
      "type": "string",
      "description": "If auth type is needed, Example: KERBEROS"
    },
    "zeppelin.jdbc.auth.kerberos.proxy.enable": {
      "name": "zeppelin.jdbc.auth.kerberos.proxy.enable",
      "value": true,
      "type": "checkbox",
      "description": "When auth type is Kerberos, enable/disable Kerberos proxy with the login user to get the connection."
    },
    "zeppelin.jdbc.concurrent.use": {
      "name": "zeppelin.jdbc.concurrent.use",
      "value": true,
      "type": "checkbox",
      "description": "Use parallel scheduler"
    },
    "zeppelin.jdbc.concurrent.max_connection": {
      "name": "zeppelin.jdbc.concurrent.max_connection",
      "value": "10",
      "type": "number",
      "description": "Number of concurrent execution"
    },
    "zeppelin.jdbc.keytab.location": {
      "name": "zeppelin.jdbc.keytab.location",
      "value": "",
      "type": "string",
      "description": "Kerberos keytab location"
    },
    "zeppelin.jdbc.principal": {
      "name": "zeppelin.jdbc.principal",
      "value": "",
      "type": "string",
      "description": "Kerberos principal"
    },
    "zeppelin.jdbc.interpolation": {
      "name": "zeppelin.jdbc.interpolation",
      "value": false,
      "type": "checkbox",
      "description": "Enable ZeppelinContext variable interpolation into paragraph text"
    },
    "zeppelin.jdbc.maxConnLifetime": {
      "name": "zeppelin.jdbc.maxConnLifetime",
      "value": "-1",
      "type": "number",
      "description": "Maximum of connection lifetime in milliseconds."
    },
    "zeppelin.jdbc.maxRows": {
      "name": "zeppelin.jdbc.maxRows",
      "value": "1000",
      "type": "number",
      "description": "Maximum number of rows fetched from the query."
    },
    "zeppelin.jdbc.hive.timeout.threshold": {
      "name": "zeppelin.jdbc.hive.timeout.threshold",
      "value": "60000",
      "type": "number",
      "description": "Timeout for hive job timeout"
    },
    "zeppelin.jdbc.hive.monitor.query_interval": {
      "name": "zeppelin.jdbc.hive.monitor.query_interval",
      "value": "1000",
      "type": "number",
      "description": "Query interval for hive statement"
    },
    "zeppelin.jdbc.hive.engines.tag.enable": {
      "name": "zeppelin.jdbc.hive.engines.tag.enable",
      "value": true,
      "type": "checkbox",
      "description": "Set application tag for applications started by hive engines"
    }
  },
  "dependencies": [
    { "groupArtifactVersion": "/zeppelin/jars/curator-client-5.7.1.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/hadoop-common-3.4.1.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/hive-common-3.1.3.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/hive-exec-3.1.3.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/hive-jdbc-3.1.3.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/hive-service-3.1.3.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/libthrift-0.20.0.jar", "local": true },
    { "groupArtifactVersion": "/zeppelin/jars/httpcore-4.4.16.jar", "local": true }
  ],
  "option": {
    "remote": true,
    "port": -1,
    "perNote": "shared",
    "perUser": "shared",
    "isExistingProcess": false,
    "setPermission": false,
    "owners": [],
    "isUserImpersonate": false
  }
}')

# Validar respuesta
if [ "$RESPONSE" -eq 201 ]; then
  echo "Intérprete '${INTERPRETER_NAME}' añadido con éxito."
else
  echo "Error al añadir el intérprete '${INTERPRETER_NAME}'. Código de respuesta: $RESPONSE"
fi
