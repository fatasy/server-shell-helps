#!/bin/bash

APP_DIR="$(pwd)"
APP_ENV="$APP_DIR/.env"
DEPLOY_DIR="$APP_DIR/deployed"
DB_MIGRATIONS="$DEPLOY_DIR/database/migrations"
GIT_DIR="$APP_DIR"
DEPLOY_BRANCH=master

yarn add pm2 -G

while read oldrev newrev ref
  do
    branch=`echo $ref | cut -d/ -f3`
    if [ "$DEPLOY_BRANCH" == "$branch" ]; then
      echo "Deploying branch $DEPLOY_BRANCH..."
      mkdir -p $DEPLOY_DIR
      GIT_WORK_TREE=$DEPLOY_DIR git checkout -f $DEPLOY_BRANCH
      cd $DEPLOY_DIR
      yarn install
      
      [[ -e "$APP_ENV" ]] && cp "$APP_ENV" "$DEPLOY_DIR" || echo "Arquivo ENV não encontrado"
      [[ -d "$DB_MIGRATIONS" ]] && node ace migration:run
      node ace build --production
      [[ -e "$APP_ENV" ]] && cp "$APP_ENV" "$DEPLOY_DIR" || echo "Arquivo ENV não encontrado"
      
      pm2 restart ecosystem.config.js
      echo "Deploy concluído."
  fi
done
