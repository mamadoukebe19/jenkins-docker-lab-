# Image de base : Nginx léger
FROM nginx:alpine

# Copier le fichier HTML dans le serveur web
COPY index.html /usr/share/nginx/html/index.html

# Exposer le port 80
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]