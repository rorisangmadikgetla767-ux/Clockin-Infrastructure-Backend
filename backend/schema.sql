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
    location_id INTEGER NOT NULL REFERENCES clockit(id),
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now()
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