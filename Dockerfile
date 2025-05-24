FROM java17:latest as stage

WORKDIR /usr/app

COPY . ..


FROM Java:latest as production

COPY  ./
