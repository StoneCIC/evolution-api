FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Generar Prisma utilizando la ruta exacta del paquete fuente principal
RUN npx prisma generate --schema=./src/common/prisma/schema.prisma || npx prisma generate --schema=./prisma/schema.prisma

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
