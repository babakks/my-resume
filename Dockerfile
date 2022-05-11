FROM texlive/texlive@sha256:4e514fb5596a8db3defd38f40fc0f7b119eb3fcc88a4bfe291cd36eb00551ddb
RUN mkdir /app
WORKDIR /app
ADD . .
