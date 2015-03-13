# Pull base image.
FROM dockerfile/nodejs

WORKDIR /opt/code

# Install pm2, fetch code
RUN npm install -g pm2
RUN git clone https://github.com/pklicnik/HelloNode.git

EXPOSE 3000

CMD pm2 start /opt/code/HelloNode/app.js --name "HelloNode" --no-daemon