FROM elixir:1.18.3

RUN apt-get update && apt-get install -y \
    build-essential \
    inotify-tools \
    postgresql-client \
    nodejs \
    npm

WORKDIR /app

#COPY mix.exs mix.lock ./
#COPY config config
#RUN mix local.hex --force && mix deps.get
#COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

