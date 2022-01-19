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

If you get an error like:

```
/usr/bin/ssh-copy-id: ERROR: ssh: Could not resolve hostname pega1: Name or service not known
```

Then you need to configure your ssh accordingly for resolving pega1, pega2, pega3 and pegadb servers as stated above.

If you get an error like:

```
/usr/bin/ssh-copy-id: ERROR: Bad owner or permissions on /home/ec2-user/.ssh/config
```

The fix it:

```bash
chmod 600 ~/.ssh/config
```
