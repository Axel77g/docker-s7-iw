pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/logfile

#Check user exist
new_user=0
if psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$POSTGRES_USER'" | grep -qw 1; then
  echo "User $POSTGRES_USER already exist."
else
  echo "User $POSTGRES_USER does not exist."
  psql -c "CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';"
  new_user=1
fi

#Check database exist
new_db=0
if psql -tAc "SELECT 1 FROM pg_database WHERE datname='$POSTGRES_DB';" | grep -wq 1; then
  echo "Database $POSTGRES_DB exists."
else
  echo "Database $POSTGRES_DB does not exist."
  psql -c "CREATE DATABASE $POSTGRES_DB;"
  new_db=1
fi

#Grant privileges
if [ $new_user -eq 1 ] || [ $new_db -eq 1 ]; then
  echo "Granting privileges to user $POSTGRES_USER on database $POSTGRES_DB."
  psql -U postgres -d $POSTGRES_DB -c "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;"
  psql -U postgres -d $POSTGRES_DB -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $POSTGRES_USER;"
  psql -U postgres -d $POSTGRES_DB -c "GRANT CREATE ON SCHEMA public TO $POSTGRES_USER;"
fi

echo "Database $POSTGRES_DB and user $POSTGRES_USER are ready to use."
#display logs
tail -f /var/lib/postgresql/logfile
