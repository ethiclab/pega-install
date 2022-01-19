# Procedura per installare PEGA 8.5

## Cosa serve?

Trasferire l'archivio zip di Pega `116967_Pega8.53.zip` nel server dove verrà installato il database sotto `/tmp`.

## Pre-requisiti

Esempio con AWS EC2

1. Lanciare 3 macchine Oracle Linux 8.5 (Su aws è disponibile solo una versione community 8.4)
2. Associare degli ip elastici ad ogni istanza
3. Configurare i host ssh pega1, pega2 e pega3 con la chiave ssh scelta per la connessione ai server ec2 per agevolare la connessione ssh
4. Noi creiamo anche l'host pegadb uguale a pega3 ma dobbiamo verificare se serve

## Installazione

Collegarsi via ssh al server pega1

```bash
ssh pega1
curl https://raw.githubusercontent.com/ethiclab/pega-install/main/bootstrap.sh | bash
```

If you get an error like:

```
IOError: [Errno 2] No such file or directory: '/home/ec2-user/.ssh/config'
/usr/bin/ssh-copy-id: ERROR: No identities found
```

Then create an ssh key pair:

```bash
ssh-keygen
```

and retry:

```bash
pega_install
```
