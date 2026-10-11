CREATE TABLE IF NOT EXISTS devices (id TEXT PRIMARY KEY, endpoint TEXT NOT NULL, subscription TEXT NOT NULL, timezone TEXT NOT NULL, posted_day TEXT, enabled INTEGER NOT NULL DEFAULT 1, updated_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS deliveries (device_id TEXT NOT NULL, day TEXT NOT NULL, slot TEXT NOT NULL, PRIMARY KEY(device_id, day, slot));
