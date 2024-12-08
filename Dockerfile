# Use Node.js as the base image
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available) and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (if needed)
# RUN npm run build  # Uncomment if you have a build step

# Production image
FROM node:14 AS production

WORKDIR /app
COPY --from=build /app .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "src/app.js"]
