# pull the latest official nginx image
FROM nginx:stable
# run docker service on HTTPS
EXPOSE 80
# copy the additional nginx configuration
# COPY ./nginx/privacy.conf /etc/nginx/conf.d/privacy.conf
# copy privacy-demo frontend (www)
COPY ./www/* /usr/share/nginx/html/
RUN chmod -R 755 /usr/share/nginx/html/
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]