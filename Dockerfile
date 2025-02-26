# Use Node.js LTS version
FROM node:lts-buster

# Install dependencies: ffmpeg, imagemagick, webp
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  npm install -g pm2 && \
  rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install --legacy-peer-deps

# Copy all files to the container
COPY . .

# Expose port 5000 for the application
EXPOSE 5000

# Start the application using PM2
CMD ["pm2-runtime", "start", "index.js"]
