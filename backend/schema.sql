CREATE TABLE clockit (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    radius_m INTEGER DEFAULT 100,
    secret_key TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()

);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    site INTEGER NOT NULL REFERENCES clockit(id),
    hourlyRate INTEGER NOT NULL,
    badge:VARCHAR(20),
    status BOOLEAN DEFAULT true,
    clockIn: BOOLEAN DEFAULT true,
    clockOut: BOOLEAN DEFAULT false,
    hoursToday: INTEGER NOT NULL,
    weekHours: INTEGER NOT NULL,
    overtimeHours: INTEGER NOT NULL,
    locationVerified:BOOLEAN DEFAULT true,
    initials: VARCHAR(10)
);

CREATE TABLE qr_tokens (
    id SERIAL PRIMARY KEY,
    location_id INTEGER NOT NULL REFERENCES clockit(id),
    token_date DATE NOT NULL,
    nonce TEXT NOT NULL,
    signature TEXT NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    revoked BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()



);

CREATE TABLE clock_events(
    id SERIAL PRIMARY KEY,
	employee_id INTEGER NOT NULL REFERENCES employees(id),
	location_id INTEGER NOT NULL REFERENCES clockit(id),
	token_id INTEGER NOT NULL REFERENCES qr_tokens(id),
	event_type VARCHAR(10) NOT NULL CHECK (event_type IN ('in', 'out')),
	event_time TIMESTAMPTZ DEFAULT now(),
	device_id TEXT,
	latitude DOUBLE PRECISION,
	longitude DOUBLE PRECISION
);

CREATE TABLE weeklyTrend(
    id SERIAL PRIMARY KEY,
    day VARCHAR(10) NOT NULL UNIQUE
);

INSERT INTO weeklyTrend (day) VALUES
('Monday'), ('Tuesday'), ('Wednesday'), ('Thursday'),
('Friday'), ('Saturday'), ('Sunday')

CREATE TABLE Account(
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    passwordHash TEXT NOT NULL,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL,
    site: DOUBLE PRECISION,
    hourlyRate: INTEGER NOT NULL,
    isManager: BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE Shift(
    id SERIAL PRIMARY KEY,
    personId VARCHAR(50) UNIQUE NOT NULL,
    date DATE UNIQUE NOT NULL,
    start VARCHAR(20) NOT NULL,
    end VARCHAR(20) NOT NULL,
    site DOUBLE PRECISION,
    note VARCHAR(20)

);