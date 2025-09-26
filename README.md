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

## Puertos configurados para cada servicio

La siguiente información hace referencia a los puertos establecidos para cada uno de los servicios dentro del contenedor, estos los encontraran dentro de la etiqueta `ports` en el archivo `docker-compose.yaml` de cada servicio.

### Puertos

- n8n: 5678
- chatwoot: 3000
- qdrant: 6333
- postgres: 5432
- ollama: 11434
- redis: pendiente por configurar

## Proceso de configuración

Para realizar el depliegue es necesario realizar los sigiuentes pasos:

1. Crear una red en docker, esta nos ayuda a la comunicación de los contenedores de manera interna, pasa su creación usaremos el comando:

``` bash
docker network create <nombre_para_la_red>
```

2. Configuración de chatwoot:
    - 2.1 usamos `docker-compose pull`, para descargar las imagenes de cada uno de los contenedores, referenciados en el `docker-compose.yaml`.
    - 2.2 Configuramos los valores para las variables de entorno de redis y postgres que se instala con el `docker-compose` de chatwood, las variables a configurar son `POSTGRES_PASSWORD`, `REDIS_PASSWORD`, `FRONTEND_URL` esta colocaremos `localhost` para poder usar local mente y luego poder mapear en el proxi inverso, `DEFAULT_LOCALE` para el idioma predeterminado y por ultimo `SECRET_KEY_BASE` que lo usa para la parte de seguidad, estas variables las modificaremos en el archivo `.env`.
    - 2.3 debemos usarl el comando `docker compose run --rm rails bundle exec rails db:chatwoot_prepare` para inicializar la base de datos que usara chatwoot.
    - 2.4 ejecutar `docker-compose up -d`.
3. Configuración n8n:
    - 3.1 ejecutar `docker-compose pull`, para descargar las imagenes de cada uno de los contenedores, referenciados en el `docker-compose.yaml`.
    - 3.2 Se deben configurar las variables de entorno dentro del archivo `.env`.
    - 3.3 ejecutar `docker-compose up -d`.
4. Configuración de postgres:
    - 4.1 ejecutar `docker-compose pull`, para descargar las imagenes de cada uno de los contenedores, referenciados en el `docker-compose.yaml`.
    - 4.2 Se deben configurar las variables de entorno dentro del archivo `.env`.
    - 4.3 ejecutar `docker-compose up -d`.
5. Configuración de qdrant:
    - 5.1 ejecutar `docker-compose pull`, para descargar las imagenes de cada uno de los contenedores, referenciados en el `docker-compose.yaml`.
    - 5.2 Se deben configurar la variables de entorno `QDRANT__SERVICE__API_KEY` dentro del archivo `docker-compose.yaml` con una cadena de texto de un largo de treita y dos caracteres.
    - 5.3 ejecutar `docker-compose up -d`.
6. Configuración ollama
    - 6.1 ejecutar `docker-compose pull`, para descargar las imagenes de cada uno de los contenedores, referenciados en el `docker-compose.yaml`.
    - 6.2 ejecutar `docker-compose up -d`, para subir el contenedor.
    - 6.3 Descargar la imagen del modelo a utilizar, para este ejemplo usaremos `llama3.2` de META, para debemos ejecutar el comando `docker exec -it ollama ollama pull llama3.2:latest`, validar etiqueta del modelo en [Ollama](https://ollama.com/search) 