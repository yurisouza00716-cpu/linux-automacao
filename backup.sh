#!/bin/bash
# backup.sh - compacta uma pasta com data no nome e apaga backups antigos

ORIGEM="$1"
DESTINO="${2:-$HOME/backups}"
DIAS=7

if [ -z "$ORIGEM" ] || [ ! -d "$ORIGEM" ]; then
    echo "Uso: ./backup.sh <pasta_origem> [pasta_destino]"
    exit 1
fi

mkdir -p "$DESTINO"

NOME="backup_$(basename "$ORIGEM")_$(date +%Y-%m-%d_%H%M%S).tar.gz"
tar -czf "$DESTINO/$NOME" -C "$(dirname "$ORIGEM")" "$(basename "$ORIGEM")"
echo "Backup criado: $DESTINO/$NOME"

find "$DESTINO" -name "backup_*.tar.gz" -mtime +$DIAS -delete
echo "Backups com mais de $DIAS dias foram removidos."
