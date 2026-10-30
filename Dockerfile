FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Buscar y generar el cliente Prisma encontrando el schema automáticamente en el proyecto
RUN find . -name "schema.prisma" -exec npx prisma generate --schema={} \;

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
