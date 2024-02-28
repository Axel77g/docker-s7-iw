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

> Pour mettre en ligne les images nous avons décider de faire en sorte quelles soient disponible sur les plateformes linux/amd64 et linux/arm64 qui permet une portabilité accrue.

Nous avons créer un fichier `builder.sh` qui permet de builder tous les dockerFile présent dans le projet avec leur contexte respectif.

Le push des images se fait automatiquement, l'utilisation de buildx permet de builder les images pour les plateformes linux/amd64 et linux/arm64 en même temps.

```sh
sh ./builder.sh
```
