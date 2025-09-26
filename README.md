# n8n-chatwoot-qdrant-postgres-redis-ollama
---

En este proyecto encontramos la configuración de los respetivos archivos `docker-compose` para desplegar la infracestructura necesaria para los siguientes servicios:

- n8n
- chatwoot
- qdrant
- postgres
- redis
- ollama

## Descripción de servicios:

### n8n

n8n es la herramienta con la cual se realiza la automatización de procesos, entre ellas el chat bot para la atención al cliente, agendamiento de citas y manipulación de documentos, etc. 

### chatwoot

Chatwoot es la herramienta que se usara para la gestión de los chats que llegan al chatbot, como la conexión de la línea whatsapp a través de api cloud.

### qdrant

Qdrant es la base de datos vectorial que se usara para darle la capacidad a nuestro agente de IA de manejar información relacionado con el negocio o de atención al cliente.

### postgres

Postgres es la base de datos que se encargara de mantener el contexto de la conversión, para así el agente de IA genere unas mejores respuestas.

### redis

Redis es la base de datos en memoria, se usaria como alternativa para el contexto de la conversación, de querrer remplazar prostgres

### ollama

Ollama es el servicio de administración de modelos de inteligencia artificial, con el cual se instala el modelo llama3.2 de `META` para el asistente y embeddinggemma de `GOOGLE` para realizar el proceso de embedding de los datos para la base de conocimiento.

## Proceso de configuración

Para realizar el depliegue es necesario realizar los sigiuentes pasos:

1. Crear una red en docker, esta nos ayuda a la comunicación de los contenedores de manera interna, pasa su creación usaremos el comando:

``` bash
docker network create <nombre_para_la_red>
```

2. Configuración de chatwoot
    2.1 usamos `docker-compose pull`, para descargar las imagenes de cada uno de los contenedores, referenciados en el `docker-compose.yaml`
    2.2 Configuramos los valores para las variables de entorno de redis y postgres que se instala con el `docker-compose` de chatwood, las variables a configurar son `POSTGRES_PASSWORD`, `REDIS_PASSWORD`, `FRONTEND_URL` esta colocaremos `localhost` para poder usar local mente y luego poder mapear en el proxi inverso, `DEFAULT_LOCALE` para el idioma predeterminado y por ultimo `SECRET_KEY_BASE` que lo usa para la parte de seguidad, estas variables las modificaremos en el archivo `.env`.
    2.3 debemos usarl el comando `docker compose run --rm rails bundle exec rails db:chatwoot_prepare` para inicializar la base de datos que usara chatwoot.
    2.4 ejecutar `docker-compose up -d`