# node

FROM node:alpine

WORKDIR /code

ADD package.json /code
RUN npm install 

ADD . /code

RUN npm run build

# 选择更小体积的基础镜像
FROM nginx:alpine
COPY --from=builder code/public/index.html code/public/favicon.ico /usr/share/nginx/html/
COPY --from=builder code/public/static /usr/share/nginx/html/static

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g","daemon off;"]  