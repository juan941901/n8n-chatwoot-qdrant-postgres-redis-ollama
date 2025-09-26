#!/bin/bash

echo "===== INICIANDO PROCESO ====="

echo "===== CREACION RED DOCKER ====="
docker network create mi_red_compartida

# Ingresando a configuración chatwoot
echo "===== Ingresando a configuración chatwoot ====="
cd chatwoot
docker-compose pull
docker compose run --rm rails bundle exec rails db:chatwoot_prepare
echo "===== INICIANDO CONTENEDORES CHATWOOD ====="
docker-compose up -d
cd ..

# Ingresando a configuración postgres n8n
echo "===== Ingresando a configuración postgres n8n ====="
cd postgres_n8n
docker-compose pull
echo "===== INICIANDO CONTENEDOR POSTGRES N8N ====="
docker-compose up -d
cd ..

# Ingresando a configuración n8n
echo "===== Ingresando a configuración n8n ====="
cd n8n
docker-compose pull
echo "===== INICIANDO CONTENEDOR N8N ====="
docker-compose up -d
cd ..

# Ingresando a configuración postgres qdrant
echo "===== Ingresando a configuración qdrant ====="
cd qdrant
docker-compose pull
echo "===== INICIANDO CONTENEDOR QDRANT ====="
docker-compose up -d
cd ..

# Ingresando a configuración ollama
echo "===== Ingresando a configuración ollama ====="
cd ollama
docker-compose pull
echo "===== INICIANDO CONTENEDOR OLLAMA ====="
docker-compose up -d
echo "===== DESCARGANDO IMAGEN ASISTENTE ====="
docker exec -it ollama ollama pull llama3.2:latest
echo "===== ESCARGANDO IMAGEN MODELO EMBEDDING ====="
docker exec -it ollama ollama pull embeddinggemma:latest
cd ..

echo "===== PROCESO FINALIZADO ====="
