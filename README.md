# Procedura per installare PEGA 8.5

## Cosa serve?

Trasferire l'archivio zip di Pega `116967_Pega8.53.zip` nel server dove verrà installato il database sotto `/tmp`.

## Pre-requisiti

1. 3 macchine Oracle Linux 8.5
2. Associare degli ip elastici ad ogni istanza
3. Configurare i host ssh pega1, pega2 e pega3 con la chiave ssh

## Installazione

Collegarsi via ssh al server pega3 (quello che ospiterà il db)

```bash
ssh pega3
curl https://raw.githubusercontent.com/ethiclab/pega-install/main/bootstrap.sh | bash
```
