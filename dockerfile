# node

FROM node:alpine AS build-stage

WORKDIR /code

ADD package.json /code

# 设置淘宝npm镜像
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

RUN cnpm install 

ADD . /code

RUN npm run build

# 前端项目运行命令
#CMD ["npm","run","start"]


FROM nginx:1.15.3 

COPY  --from=build-stage /code/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g","daemon off;"]  