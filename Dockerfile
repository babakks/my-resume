FROM texlive/texlive:latest
RUN mkdir /app
WORKDIR /app
ADD . .
