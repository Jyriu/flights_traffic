CREATE TABLE IF NOT EXISTS airlines (
  carrier varchar NOT NULL PRIMARY KEY,
  name varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS "PRIMARY" ON airlines (carrier);

CREATE TABLE IF NOT EXISTS airports (
  faa varchar NOT NULL PRIMARY KEY,
  name varchar,
  lat decimal(10),
  lon decimal(10),
  alt decimal(10),
  tz int,
  dst varchar,
  tzone varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS "PRIMARY" ON airports (faa);

CREATE TABLE IF NOT EXISTS planes (
  tailnum varchar NOT NULL PRIMARY KEY,
  year int,
  type varchar,
  manufacturer varchar,
  engines varchar,
  seats varchar,
  model varchar,
  speed varchar,
  engine varchar
);

CREATE UNIQUE INDEX IF NOT EXISTS "PRIMARY" ON planes (tailnum);

CREATE TABLE IF NOT EXISTS weather (
  year int,
  month int,
  day int,
  hour int,
  temp decimal(10),
  dewp decimal(10),
  humid int,
  wind_dir decimal(10),
  wind_speed decimal(10),
  wind_gust decimal(10),
  precip decimal(10),
  pressure decimal(10),
  visib int,
  time_hour timestamp,
  origin varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS flights (
  year int,
  month int,
  day int,
  dep_time int,
  sched_dep_time int,
  dep_delay int,
  arr_time int,
  sched_arr_time int,
  arr_delay int,
  flight serial NOT NULL PRIMARY KEY,
  air_time int,
  distance int,
  hour int,
  minute int,
  time_hour timestamp,
  tailnum varchar NOT NULL,
  carrier varchar NOT NULL,
  origin varchar NOT NULL,
  dest varchar NOT NULL
);

CREATE INDEX IF NOT EXISTS fk_flights_airports1_idx ON flights (origin);
CREATE INDEX IF NOT EXISTS fk_flights_airports2_idx ON flights (dest);
CREATE INDEX IF NOT EXISTS fk_flights_carrier1_idx ON flights (carrier);
CREATE INDEX IF NOT EXISTS fk_flights_planes_idx ON flights (tailnum);
CREATE UNIQUE INDEX IF NOT EXISTS "PRIMARY" ON flights (flight);

ALTER TABLE flights ADD CONSTRAINT fk_flights_airports1 FOREIGN KEY (origin) REFERENCES airports (faa);
ALTER TABLE flights ADD CONSTRAINT fk_flights_airports2 FOREIGN KEY (dest) REFERENCES airports (faa);
ALTER TABLE flights ADD CONSTRAINT fk_flights_carrier1 FOREIGN KEY (carrier) REFERENCES airlines (carrier);
ALTER TABLE flights ADD CONSTRAINT fk_flights_planes FOREIGN KEY (tailnum) REFERENCES planes (tailnum);
ALTER TABLE weather ADD CONSTRAINT fk_weather_origin FOREIGN KEY (origin) REFERENCES airports (faa);