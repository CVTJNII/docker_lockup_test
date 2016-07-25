FROM debian:jessie

RUN apt-get clean && apt-get update && apt-get install -y netcat-traditional fortune-mod fortunes-min
RUN useradd notroot

EXPOSE 4444
USER notroot
CMD while true; do nc -l -p 4444 -c /usr/games/fortune; done
