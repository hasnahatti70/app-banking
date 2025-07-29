# Étape 1 : image de base avec Java 17
FROM eclipse-temurin:17-jdk-alpine

# Étape 2 : répertoire de travail dans le conteneur
WORKDIR /app

# Étape 3 : copier le fichier jar compilé
COPY target/eazybankapplication-0.0.1-SNAPSHOT.jar app.jar

# Étape 4 : exposer le port (modifie si ton app écoute ailleurs)
EXPOSE 8080

# Étape 5 : commande de démarrage
ENTRYPOINT ["java", "-jar", "app.jar"]
