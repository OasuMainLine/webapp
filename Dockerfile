FROM node:lts AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY . /app
WORKDIR /app

FROM base AS build

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

FROM base AS runtime
COPY --from=build /app/dist /app/dist
WORKDIR /app
ENV HOST=0.0.0.0
ENV PORT=4321

ENV DEPLOYED_ENVIRONMENT="default"
ENV BOX_COLOR="blue"
EXPOSE ${PORT}
CMD ["node", "./dist/server/entry.mjs"]