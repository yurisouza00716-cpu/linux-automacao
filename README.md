# Linux Automação

Projeto de automação com shell script feito no Ubuntu (WSL) para praticar Bash, manipulação de arquivos e agendamento de tarefas. Criei dois scripts úteis para o dia a dia de TI e segurança: um para backup e outro para análise de logs.

## Scripts

### backup.sh

Compacta uma pasta em `.tar.gz`, com data e hora no nome, e apaga backups com mais de 7 dias.

    ./backup.sh <pasta_origem> [pasta_destino]

Se a pasta de destino não for informada, usa `~/backups`.

### analisa_logs.sh

Lê um arquivo de log e mostra um resumo: total de linhas, quantidade de erros, logins falhos e aceitos, e os 5 IPs com mais tentativas falhas. Esse padrão ajuda a identificar tentativas de força bruta no SSH.

    ./analisa_logs.sh exemplo_auth.log

O arquivo `exemplo_auth.log` tem dados inventados, no formato do `auth.log` do Linux, só para testar.

## Agendamento com cron

Para rodar o backup todo dia às 18h, adicionei esta linha ao `crontab -e`:

    0 18 * * * /home/usuario/linux-automacao/backup.sh /home/usuario/pasta >> /home/usuario/cron_backup.log 2>&1

O `>> ... 2>&1` guarda a saída e os erros em um arquivo de log.

## O que pratiquei

- Argumentos de script (`$1`, `$2`) e valor padrão (`${2:-...}`)
- Validação de entrada com `if`, `-d`, `-f` e `exit 1`
- `tar`, `find -mtime -delete` e `date` para backup com retenção
- `grep`, `wc`, `sort`, `uniq` e `head` combinados com pipes
- Permissões com `chmod +x`
- Agendamento com `cron`

## Limitação

No WSL, o cron só roda enquanto o Ubuntu está aberto. Em um servidor Linux de verdade ele roda o tempo todo.

## Próximos passos

Quero fazer o script de log ler o `/var/log/auth.log` real e mandar um alerta quando um IP passar de certo número de falhas.
