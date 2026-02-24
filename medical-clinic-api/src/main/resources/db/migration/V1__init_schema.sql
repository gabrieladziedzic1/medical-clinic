CREATE TABLE IF NOT EXISTS roles (
    id_role INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS users (
    id_user BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE, NOT NULL
);


CREATE TABLE IF NOT EXISTS user_roles (
    id_user_role BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    role_id INT NOT NULL,

    CONSTRAINT fk_user_role_u FOREIGN KEY (user_id) REFERENCES users(id_user),
    CONSTRAINT fk_user_role_r FOREIGN KEY (role_id) REFERENCES roles(id_role)
);


CREATE TABLE IF NOT EXISTS patients (
    id_patient BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    birth_date DATE NOT NULL,
    pesel VARCHAR(11) UNIQUE NOT NULL,

    CONSTRAINT fk_patient FOREIGN KEY (user_id) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS doctors (
    id_doctor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    specialization VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,

    CONSTRAINT fk_doctor FOREIGN KEY (user_id) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS rooms (
    id_room INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_name VARCHAR(50) NOT NULL,
    room_number VARCHAR(25) UNIQUE NOT NULL,
    is_available BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE IF NOT EXISTS equipment (
    id_equipment INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_id INT NOT NULL,
    equipment_name VARCHAR(50) NOT NULL,
    internal_code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    is_functional BOOLEAN DEFAULT TRUE NOT NULL,

    CONSTRAINT fk_equipment FOREIGN KEY (room_id) REFERENCES rooms(id_room)
);

CREATE TABLE IF NOT EXISTS doctor_schedules (
    id_doctor_schedule BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    doctor_id INT NOT NULL,
    room_id INT NOT NULL,
    day_of_week INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,

    CONSTRAINT fk_doctor_schedule_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(id_doctor),
    CONSTRAINT fk_doctor_schedule_room FOREIGN KEY (room_id) REFERENCES rooms(id_room),
    CONSTRAINT check_time_schedule CHECK (end_time > start_time),
    CONSTRAINT check_day_range CHECK (day_of_week BETWEEN 1 AND 7),
    CONSTRAINT doctor_time UNIQUE (doctor_id, day_of_week, start_time)
);

CREATE TABLE IF NOT EXISTS doctor_absences (
    id_doctor_absence BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    doctor_id INT NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,

    CONSTRAINT fk_doctor_absence FOREIGN KEY (doctor_id) REFERENCES doctors(id_doctor),
    CONSTRAINT check_dates_absence CHECK (end_date > start_date)
);

CREATE TABLE IF NOT EXISTS appointment_statuses (
    id_status INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS appointments (
    id_appointment BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    doctor_id INT NOT NULL,
    room_id INT NOT NULL,
    patient_id BIGINT NOT NULL,
    status_id INT NOT NULL,
    start_date_time TIMESTAMP NOT NULL,
    end_date_time TIMESTAMP NOT NULL,
    note_medical TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,

    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(id_doctor),
    CONSTRAINT fk_appointment_room FOREIGN KEY (room_id) REFERENCES rooms(id_room),
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients(id_patient),
    CONSTRAINT fk_appointment_status FOREIGN KEY (status_id) REFERENCES appointment_statuses(id_status),
    CONSTRAINT check_dates_appointment CHECK (end_date_time > start_date_time)
);