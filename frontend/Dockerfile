FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY mix.exs .
COPY mix.lock .
# RUN apk add --no-cache python3 py3-pip
RUN mkdir assets
RUN apk update && apk upgrade && \
    apk add --update --no-cache \
    build-base yarn nodejs-current \
    inotify-tools git python2
COPY assets/package.json assets
COPY assets/package-lock.json assets

CMD mix deps.get && cd assets && npm install && npm rebuild node-sass && cd .. && mix phx.server
