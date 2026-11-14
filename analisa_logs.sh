#!/bin/bash
# analisa_logs.sh - resume erros e tentativas de login falhas de um log

LOG="$1"

if [ -z "$LOG" ] || [ ! -f "$LOG" ]; then
    echo "Uso: ./analisa_logs.sh <arquivo_de_log>"
    exit 1
fi

echo "=== Relatorio de $LOG ==="
echo "Total de linhas:  $(wc -l < "$LOG")"
echo "Linhas com ERROR: $(grep -c "ERROR" "$LOG")"
echo "Logins falhos:    $(grep -c "Failed password" "$LOG")"
echo "Logins aceitos:   $(grep -c "Accepted password" "$LOG")"
echo ""
echo "Top 5 IPs com tentativas falhas:"
grep "Failed password" "$LOG" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sort | uniq -c | sort -rn | head -5
