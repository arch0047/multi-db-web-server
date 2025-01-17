# Roll call application, KEA study project with a nodejs backend and mutliple database architecture

## How to start the mysql docker container for local development

Look for more documentation at the `docker-compose.yml`.

```
docker-compose up
```
The first time you run this command it will spin up an empty mysql DB and then it will run all the scripts in `./sql`

Shut down with ctrl+C . Any changes you make are persisted in the `sqldb` volume and will be available next time you run `docker-compose up`.

## How to restart from an empty database

```
docker-compose down -v
```

This will remove the containers and the `sqldb` volume, so all DB data are removed.
This is useful when you make changes to the schema and you want to rerun the DDL scripts on your local machine.

## How to connect to container db and run a sript

```
cat ./path-to-your-script-here.sql | mysql -h 127.0.0.1 -P 3306 -u root -pdatabases
```
## How to generate sequelize models from the dabase tables

[sequelize-auto documentation](https://www.npmjs.com/package/sequelize-auto)

We can use this library to auto-generate our javascript models.

We can run this command `sequelize-auto -h localhost -d rollcall_db -u root -x databases -p 3306  --dialect mysql -o ./models/ -v true`

We have made a shortcut for this command at out `package.json`, so one can just run `npm run generate-models`

Remember that the databse must be up and running when you run this command.