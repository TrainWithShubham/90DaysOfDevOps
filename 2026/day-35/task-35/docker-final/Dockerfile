#builder stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json .

RUN npm install --omit=dev

COPY . .

#production stage

FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app /app 

RUN adduser -D user_apurva && \
    chown -R user_apurva:user_apurva /app && \
    whoami
    
#The -D flag means:Create a user with default settings (no password, no prompts)

USER user_apurva

CMD [ "node", "app.js" ]











