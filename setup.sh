#!/usr/bin/env bash

git clone https://github.com/event-engine/ts-iio-cody-tutorial.git exercises

cd exercises
cp .env.dist .env # Adjust UID if needed
docker-compose run --rm exercises npm install

cd ..

# Install Cody Server
git clone https://github.com/event-engine/nodejs-inspectio-cody.git cody-bot
cd cody-bot
cp .env.dist .env # Adjust UID if needed

sed -i '/app/a\      - ../exercises:/exercises' docker-compose.yml
sed -i "s#context: {}#context: {srcFolder: '/exercises/src'}#g" codyconfig.ts

docker-compose run --rm cody npm install
docker-compose up -d --no-recreate

docker-compose ps

echo ""
echo "Cody tutorial ready. Visit https://wiki.prooph-board.com/Node.js-Cody-Tutorial-Exercise-I"
