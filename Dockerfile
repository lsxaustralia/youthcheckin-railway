FROM mrcrunchybeans/youth-secure-checkin:latest

ENV PORT=5000

RUN mkdir -p /app/data /app/uploads

CMD gunicorn --bind 0.0.0.0:${PORT} --workers 3 --timeout 120 wsgi:app
