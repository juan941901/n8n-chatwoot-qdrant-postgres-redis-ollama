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
