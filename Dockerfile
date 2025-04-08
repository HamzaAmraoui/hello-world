# Usa una imagen base de Node.js
FROM node:14

# Crea y establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de la aplicación
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código
COPY . .

# Expón el puerto en el que la app escuchará
EXPOSE 3000

# Define el comando para iniciar la aplicación
CMD ["npm", "start"]
