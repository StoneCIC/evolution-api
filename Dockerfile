FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Buscar el archivo schema.prisma en cualquier subcarpeta y ejecutar la generación con esa ruta exacta
RUN SCHEMA_PATH=$(find . -name "schema.prisma" -print -quit) && npx prisma generate --schema=$SCHEMA_PATH

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
