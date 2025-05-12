
# ------------------------------
# Dockerfile for Agg
# Save as: Dockerfile (in agg repo root)
# ------------------------------

FROM hexpm/elixir:1.15.4-erlang-26.1.2-alpine-3.18 AS build

RUN apk add --no-cache build-base git
WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get && mix deps.compile

COPY . .
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix release

FROM alpine:3.18 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs
WORKDIR /app

COPY --from=build /app/_build/prod/rel/agg .

ENV REPLACE_OS_VARS=true \
    MIX_ENV=prod

ENTRYPOINT ["/app/bin/agg", "start"]
