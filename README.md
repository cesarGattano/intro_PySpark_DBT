# Introduction PySpark et DBT

Auteur: César Gattano

## Contexte

Ceci est un travail introductif aux technologies **Spark/Pyspark** et **DBT**.

**Rappel du brief:** \
Comprendre comment utiliser **PySpark** pour transformer des données massives et **DBT** pour modéliser ces données dans un entrepôt.

Vous travaillez pour une société de ventes à distance.
Votre mission est de :
- Nettoyer et transformer des données avec **PySpark**.
- Charger ces données dans une base **PostgreSQL**.
- Construire un modèle en étoile simple avec **DBT**.
- Répondre à certaines questions métier via **DBT**.

**Dataset:** `./data/ventes.csv` \
Cet ensemble de données contient des informations sur les ventes réalisées par une entreprise, chaque ligne correspond à une vente.

## Installation

### Clonage du repository

```
git clone git@github.com:cesarGattano/intro_PySpark_DBT.git
cd intro_PySpark_DBT
```

### Création d'un environnement virtuel

```
python -m venv .venv
source .venv/bin/activate
```

### Installation des requirements

```
pip install -r requirements.txt
```

### Création du fichier `.env.postgres`

```
cp env.postgres.template .env.postgres
```
Choisir une valeur pour chaque variable d'environnement. Pour certaines une valeur par défaut est proposée.

### Initialisation de dbt

```
dbt init
dbt deps
```

### Configurer votre fichier `profiles.yml`

```YAML
intro_pyspark_dbt:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: <répéter la valeur de POSTGRES_USER dans .env.postgres>
      password: <répéter la valeur de POSTGRES_PASSWORD dans .env.postgres>
      port: <répéter la valeur de LOCAL_DB_PORT dans .env.postgres>
      dbname: <répéter la valeur de POSTGRES_DB dans .env.postgres> 
      schema: dbt_dev
      threads: 4
      keepalives_idle: 0
      connect_timeout: 10
      retries: 1
```

### Configurer votre fichier `dbt_project.yml`

Voici un exemple:
```YAML
name: "intro_pyspark_dbt"
profile: "intro_pyspark_dbt"
models:
  intro_pyspark_dbt:
    +materialized: view
    stagged:
      +materialized: view
      +schema: stagged
    marts:
      +materialized: view
      +schema: marts
    analytics:
      +materialized: view
      +schema: analytics
vars:
  "dbt_date:time_zone": "Europe/Paris"
```

Attention le profile dans correspondre à un profil présent dans `profiles.yml`


### Test la connexion via dbt

```
dbt debug
```

## 🍕 Arborescence du projet

```bash
├── docs # Documentation variée
├── models # Modèles DBT ...
│   ├── analytics # ... pour répondre à des questions métiers
│   │   ├── client
│   │   │   ├── *.sql
│   │   ├── croisee
│   │   │   ├── *.sql
│   │   ├── magasin
│   │   │   ├── *.sql
│   │   ├── produit
│   │   │   ├── *.sql
│   │   └── temporelle
│   │       └── *.sql
│   ├── marts # ... pour la réprésentation Kimball/étoile
│   │   ├── dim_*.sql # Tables de dimension
│   │   ├── dim_*.yml # Test et docs
│   │   ├── fct_*.sql # Table des faits
│   │   └── fct_*.yml # Test et docs
│   └── stagged # ... pour les données initiales
│       └── stg_*.sql
├── brief.ipynb # Rendu du brief
├── env.postgres.template
├── .gitignore
├── LICENSE
├── packages.yml
├── README.md
└── requirements.txt
└── LICENSE
```

## 🥤 Licence
Ce projet est sous licence MIT — voir le fichier [LICENSE](LICENSE) pour plus d'informations.
