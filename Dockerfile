FROM node:lts-buster

# Install dependencies and pm2
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  npm install -g pm2 pm2-runtime && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json .
RUN npm install --legacy-peer-deps

COPY . .

EXPOSE 5000

CMD ["pm2-runtime", "start", "index.js"]
