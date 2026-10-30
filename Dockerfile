FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Buscar el archivo schema.prisma en todo el proyecto y pasárselo a prisma generate de forma dinámica
RUN npx prisma generate --schema=$(find . -name "schema.prisma" | head -n 1)

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
