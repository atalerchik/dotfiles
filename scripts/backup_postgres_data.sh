#!/bin/bash

# Set PostgreSQL details
PGHOST="your_host"
PGPORT="your_port"
PGUSER="your_username"
PGDATABASE="your_database"
PGPASSWORD="your_password"

# Set the output file name with date
OUTPUT_FILE="backup_$(date +%Y%m%d%H%M%S).dump"

# Export password to avoid prompt
export PGPASSWORD=$PGPASSWORD

# Create a compressed dump
pg_dump -h $PGHOST \
	-p $PGPORT \
	-U $PGUSER \
	-F c -b -v -j 4 \
	--exclude-table='public.audit' \
	--exclude-table='public.audit_2020' \
	--exclude-table='public.audit_2021' \
	--exclude-table='public.audit_2022' \
	-f "$OUTPUT_FILE" $PGDATABASE

# Unset the password for security
unset PGPASSWORD

echo "Backup completed: $OUTPUT_FILE"

 # public | audit               | table | morda_prod
 # public | audit_2020          | table | morda_prod
 # public | audit_2021          | table | morda_prod
 # public | audit_2022					| table | morda_prod
