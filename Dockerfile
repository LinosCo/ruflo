FROM node:20-slim

RUN apt-get update && apt-get install -y \
    git curl ca-certificates python3 build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps || npm install

COPY . .
RUN npm run build || true

RUN npm install -g @anthropic-ai/claude-code || true
RUN npm link || true

EXPOSE 8080

CMD ["sh", "-c", "echo 'ruflo container ready. Use railway shell to exec.' && tail -f /dev/null"]
