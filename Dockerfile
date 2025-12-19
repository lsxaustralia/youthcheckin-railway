FROM mrcrunchybeans/youth-secure-checkin:latest

RUN mkdir -p /app/data /app/uploads

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
