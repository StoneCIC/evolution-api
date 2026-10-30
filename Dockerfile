FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

# Clonar el repositorio si usas clonado directo en el Dockerfile
RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

# Instalar dependencias
RUN npm install

# --- AQUÍ ESTÁ LA CLAVE: Generar el cliente de Prisma antes de compilar ---
RUN npx prisma generate

# Compilar la aplicación
RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]

