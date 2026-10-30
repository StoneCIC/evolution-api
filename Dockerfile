FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Copiar o buscar de forma robusta el schema ejecutando un volcado si es necesario
RUN find . -name "schema.prisma" -exec npx prisma generate --schema={} \;

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
