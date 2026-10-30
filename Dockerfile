FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Localizar recursivamente el archivo schema.prisma y generar el cliente de inmediato
RUN find . -name "schema.prisma" -type f -exec npx prisma generate --schema={} \;

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
