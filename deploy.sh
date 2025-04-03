#!/bin/bash
env=$1
DB_USER=$2
DB_PASS=$3
API_KEY=$4

if [ -z "$env" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$API_KEY" ]; then
  echo " Error: Faltan argumentos. Uso: ./deploy.sh [ENV] [DB_USER] [DB_PASS] [API_KEY]"
  exit 1
fi

hackaton deploy --$env
hackaton restart app --$env
