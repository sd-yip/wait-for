FROM node:14-alpine AS test-runner-base
RUN apk add --no-cache bash

WORKDIR /app
CMD npm test

COPY . /app
RUN npm ci

FROM test-runner-base AS test-runner
RUN npm test


FROM busybox:1.32.0-uclibc
WORKDIR /usr/bin
ENTRYPOINT ["wait-for"]

COPY --from=test-runner /app/wait-for .
