# Liste des commandes docker lancées

Chargement des variables d'environnement du fichier .env.postgres dans le terminal:
```
export $(grep -v '^#' .env.postgres | xargs -d '\n')
```

alternative:
```
set -o allexport
. ./.env.postgres
set +o allexport
```

Création du réseau:
```
docker network create intro_pyspark_dbt-network
```

Création du volume:
```
docker volume create intro_pyspark_dbt-data
```

Création et lancement du conteneur postgres:
```
docker run \
    -p ${LOCAL_DB_PORT}:${POSTGRES_PORT} \
    -v intro_pyspark_dbt-data:/var/lib/postgresql/data \
    --network intro_pyspark_dbt-network \
    --name intro_pyspark_dbt-db \
    --env-file ./.env.postgres \
    -d \
    postgres:17.5-alpine3.22
```

Note: Je n'arrive pas à me connecter à la base postgres en créant le conteneur ainsi,
même s'il est healthy en lui-même. Avec le docker compose, la connection s'établit pourtant...