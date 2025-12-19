#!/bin/sh
set -e

export DB_PATH="${DB_PATH:-/app/data/checkin.db}"

python - <<'PY'
import os, sqlite3
db = os.environ.get("DB_PATH", "/app/data/checkin.db")
os.makedirs(os.path.dirname(db), exist_ok=True)

conn = sqlite3.connect(db)
cur = conn.cursor()
cur.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='settings'")
exists = cur.fetchone()

if not exists:
    with open("/app/schema.sql", "r") as f:
        conn.executescript(f.read())
    conn.commit()

print("DB ready:", db)
conn.close()
PY

exec gunicorn --bind 0.0.0.0:${PORT:-8080} --workers 3 --timeout 120 wsgi:app
