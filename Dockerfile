# Етап 1: Збірка (Build)
# Використовуємо Node 14 (стабільний для Angular 10)
FROM node:14-alpine as build

WORKDIR /app

# Копіюємо конфіги
COPY package*.json ./

# Встановлюємо залежності
RUN npm install

# Копіюємо весь проект (src, angular.json тощо)
COPY . .

# Будуємо проект для продакшену
RUN npm run build -- --prod

# Етап 2: Запуск (Run)
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

# Копіюємо твій nginx.conf у контейнер
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]