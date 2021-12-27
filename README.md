# Procedura per installare PEGA 8.5

## Cosa serve?

Trasferire l'archivio zip di Pega `116967_Pega8.53.zip` nel server dove verrà installato il database.

## Caratteristiche

  - 3 macchine Oracle Linux Server release 8.5

    - 2 macchine con tomcat 9
    - 1 macchina con PostgreSQL 11

L'installazione può avvenire in 2 modalità:

  - Attraverso l'utilizzo di una macchina di servizio
  - Attraverso una delle 3 macchine target

In ogni caso è necessario disporre nelle macchine target
di un utente che sia `sudoers` e che possa eseguire
i comandi via sudo senza che venga richiesta la password.

Se ipotizziamo che l'utente sudoers si chiama `pegauser`
allora la configurazione ssh del client nella macchina di servizio
potrebbe essere la seguente:

### STEP 1: Configurazione ssh

```ssh-config
Host pega1
 User pegauser
 Hostname <ip del web server 1>
 Port 22

Host pega2
 User pegauser
 Hostname <ip del web server 2>
 Port 22

Host pega3
 User pegauser
 Hostname <ip del database>
 Port 22

Host pegadb
 User postgres
 Hostname <ip del database>
 Port 22
```

Nel nostro caso, dato che abbiamo le password di `root`
abbiamo predisposto uno script per creare le utenze `pegauser`.

ATTENZIONE: Dato che questi script eseguono delle chiamate ssh
è importante avere una coppia di chiavi SSL generate tramite il comando:

```bash
ssh-keygen
```

Dopodiché bisogna procedere a copiare la chiave pubblica nei
server target tramite i comandi seguenti:

Solo in questa fase verrà chiesta la password di root per ogni
server ma questo poi permetterà che la password non venga più chiesta
durante l'esecuzione degli script successivi.

```bash
ssh-copy-id root@pega1
ssh-copy-id root@pega2
ssh-copy-id root@pega3
```

```bash
./001-create-user-pegauser.sh pega1
./001-create-user-pegauser.sh pega2
./001-create-user-pegauser.sh pega3
```

A questo punto abbiamo l'utente `pegauser`,
in tutte le macchine target,
che appartiene al gruppo `sudoers`
e che può eseguire dei comandi amministrativi
senza dover inserire la password.

### STEP 2: Installazione di java via sdkman nei target server

```bash
./002-install-sdkman.sh pega1
./002-install-sdkman.sh pega2
./002-install-sdkman.sh pega3
```

### STEP 3: Installazione di postgres nel server pega3

```bash
./003-install-postgresql.sh pega3
```

Questo script, alla fine, richiederà di creare una password per l'utente
postgres. Bisogna scegliere una password e ricordarla perché
servirà per poter abilitare l'accesso ssh tramite chiave ssh e senza password
per l'utente postgres nello step successivo.

### STEP 4: Abilitazione utente postgres per l'accesso ssh senza password

```bash
./004-enable-ssh-for-postgres-user.sh pegadb
```

## Installation

```bash
./005-initdb.sh pegadb
./006-initdb.sh pegadb

./002-install-sdkman.sh pegadb

scp pega1:/home/Software/116967_Pega8.53/scripts/setupDatabase.properties .
scp pegadb:~/11/data/pg_hba.conf .
scp pegadb:~/11/data/postgresql.conf .

ssh pegadb cp .bashrc .pgsql_profile
ssh root@pega1 chown -R pegauser:pegauser /home/Software
ssh pega1
curl -O -L https://jdbc.postgresql.org/download/postgresql-42.3.1.jar
scp postgresql-42.3.1.jar pega1:~
ln -s .bashrc .bash_profile
. ~/bash_profile
cd /home/Software/116967_Pega8.53/scripts
# modify setupDatabase.properties
chmod +x *.sh
chmod +x bin/*
./install.sh
./skeleton.py -t config.properties
```
