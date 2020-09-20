# Installation

## Precondition
Docker and docker-compose must be installed before it is possible to use this project to setup Runalyze

The details of the installation might be variate from the used operation system, there should be plenty of instruction.

## Bugfix runalyze
There are two possible approaches to fix runalyze.

The first approach is to patch the [runalyze source code](#Patch-the-runalyze-code). It is just a minor change, but a bit time consuming. However, in the case of a re-installation it is possible to skip the bug-fixing part.

As an alternative to patch the source code, it is possible to add the missing column [after the installation](#Bugfix-after-installation) to the table.

The next two section will give guidance to both approaches.

### Patch the runalyze code
Download the latest version of runalyze:
```bash
cd web-app\version

wget -O runalyze_unfixed.tar.gz https://github.com/Runalyze/Runalyze/releases/download/v4.3.0/runalyze-v4.3.0.tar.gz
```

Open the file *structure.sql*
```bash
tar -xzvf runalyze_unfixed.tar.gz

vi runalyze/inc/install/structure.sql
```

After line 350 add the line:
```sql
`is_power_calculated` TINYINT(1) DEFAULT NULL,
```

Change the ownership of the folder *runalyze*
```bash
sudo chown www-data:www-data -R runalyze
```

Create tarball of the fixed version
```bash
tar -zcvf runalyze.tar.gz runalyze
```

The folder *runalyze* and the file *runalyze_unfixed.tar.gz* is no longer needed.
```bash
sudo rm -rf runalyze runalyze_unfixed.tar.gz
```

### Bugfix after installation
``` bash
docker exec -it runalyze-docker_db_1 /bin/bash

mysql -u runalyze -p runalyze

ALTER TABLE `runalyzetraining` ADD `is_power_calculated` TINYINT(1) DEFAULT NULL AFTER `power`;
```
