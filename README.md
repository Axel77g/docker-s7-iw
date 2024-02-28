# TP Docker ESGI 4IW3 2023-2024

> Projet de MAIRE Nicolas, MU Yves, GODEFROY Axel

## Lancer le projet

```sh
docker-compose up
```

> Si le répertoire ne contient pas d'application Symfony (uniquement le `docker-compose.yml` et le dossier `docker`), une application Symfony sera générée.

Le lancement de l'application peut prendre quelques secondes. Le projet est accessible une fois l'installation des dépendances terminée à l'URL `http://localhost:8000`, et Adminer est disponible à l'adresse `http://localhost:8080/adminer.php`.

> :warning: **Attention** : Si vous interrompez l'exécution de `docker-compose up` pendant l'exécution du service `composer`, le fichier `docker-compose.yml` restera nommé `docker-compose.save.yml`.

## Créer la base de données

Lancer les migrations Doctrine sur votre base de données locale

```sh
docker-compose exec -it symfony php bin/console doctrine:migrations:migrate
```

Lancer la génération de données avec les fixtures Doctrine

```sh
docker-compose exec -it symfony php bin/console doctrine:fixtures:load
```

## Visualiser vos TODOs

Rendez-vous sur la route `http://localhost:8000/todo` pour visualiser les todos générés.

## Mise en ligne des images

> Pour mettre en ligne les images, nous avons décidé de les rendre disponibles sur les plateformes linux/amd64 et linux/arm64 afin d'assurer une portabilité accrue.

Nous avons créé un fichier `builder.sh` qui permet de construire tous les fichiers Docker présents dans le projet avec leur contexte respectif.

Le push des images se fait automatiquement ; l'utilisation de buildx permet de construire les images pour les plateformes linux/amd64 et linux/arm64 simultanément.

```sh
sh ./builder.sh
```
