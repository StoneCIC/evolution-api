FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install

# Copiar el archivo schema.prisma desde la subcarpeta real a la raíz de Prisma para garantizar que se detecte
RUN cp $(find . -name "schema.prisma" | head -n 1) ./schema.prisma

# Generar el cliente de Prisma desde la raíz
RUN npx prisma generate

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
