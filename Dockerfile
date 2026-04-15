FROM node:20-slim

RUN apt-get update && apt-get install -y \
    git curl ca-certificates python3 build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN npm install --legacy-peer-deps || npm install
RUN npm run build || true
RUN npm run build:ts || true

RUN cd v3/@claude-flow/shared && npm install --legacy-peer-deps && npm run build || true
RUN cd v3/@claude-flow/guidance && npm install --legacy-peer-deps && npm run build || true
RUN cd v3/@claude-flow/cli && npm install --legacy-peer-deps && npm run build || true

RUN npm install -g @anthropic-ai/claude-code
RUN npm link || true

CMD ["sh", "-c", "echo 'ruflo container ready' && tail -f /dev/null"]
