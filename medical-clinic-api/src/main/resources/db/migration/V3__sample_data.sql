INSERT INTO users (first_name, last_name, email, phone_number, password)
VALUES ('Adam', 'Adamski', 'adamadamski@email.com', '123456789', '$2b$12$HxTPxTSFW7yJyFpBH9EjDuf0FjMgH.gKE/NemhL4M4fqqEyvJepkG') --Admin123
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (first_name, last_name, email, phone_number, password)
VALUES ('Ewa', 'Nowak', 'ewanowak@email.com', '234567891', '$2b$12$kGVaLPrSlAaBR0YD1wdJvuYQ7aNyl4aA0qWOOigWaeBrQGehYZbHm') --Receptionist123
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (first_name, last_name, email, phone_number, password)
VALUES ('Piotr', 'Kowalski', 'piotrkowalski@email.com', '567891234', '$2b$12$j1fknSKagU9GXpeh9mgpOuFSeKQGRZimuXcxCXNGrH8Ai9tBEYrcy') --Doctor123
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (first_name, last_name, email, phone_number, password)
VALUES ('Agata', 'Adamczyk', 'agataadamczyk@email.com', '678912345', '$2b$12$Cz8CjNkt7/fny2czihLCPu8.SLDMgv/ly97JCWbzpGAZuR9vsZ6Km') --Doctor321
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (first_name, last_name, email, phone_number, password)
VALUES ('Ania', 'Nowak', 'anianowak@email.com', '345678912', '$2b$12$WrKWqQiLLjWAQPy83e5Qc.OapGYnVo/LS2.C2XGgcgL5mC9Bb11wm') --Patient123
ON CONFLICT (email) DO NOTHING;

INSERT INTO users (first_name, last_name, email, phone_number, password)
VALUES ('Bartosz', 'Bartoszewski', 'bartoszbartoszewski@email.com', '456789123', '$2b$12$le1NLQ75xP3559WKS9QaOezkgyVMhKJ.66vcVoVEbcMHd5AOQr4q6') --Patient321
ON CONFLICT (email) DO NOTHING;

INSERT INTO user_roles (user_id, role_id) VALUES
    ((SELECT id_user FROM users WHERE email = 'adamadamski@email.com'),1),
    ((SELECT id_user FROM users WHERE email = 'ewanowak@email.com'),2),
    ((SELECT id_user FROM users WHERE email = 'piotrkowalski@email.com'),3),
    ((SELECT id_user FROM users WHERE email = 'agataadamczyk@email.com'),3),
    ((SELECT id_user FROM users WHERE email = 'agataadamczyk@email.com'),4),
    ((SELECT id_user FROM users WHERE email = 'anianowak@email.com'),4),
    ((SELECT id_user FROM users WHERE email = 'bartoszbartoszewski@email.com'),4);

INSERT INTO patients (user_id, birth_date, pesel) VALUES
    ((SELECT id_user FROM users WHERE email = 'agataadamczyk@email.com'), '1980-05-15', '80051512345'),
    ((SELECT id_user FROM users WHERE email = 'anianowak@email.com'), '1992-10-10', '92101054322'),
    ((SELECT id_user FROM users WHERE email = 'bartoszbartoszewski@email.com'), '1999-01-01', '99010113321');

INSERT INTO doctors (user_id, specialization) VALUES
    ((SELECT id_user FROM users WHERE email = 'piotrkowalski@email.com'),'ortopeda'),
    ((SELECT id_user FROM users WHERE email = 'agataadamczyk@email.com'), 'neurolog');

INSERT INTO rooms (room_name, room_number) VALUES
    ('Gabinet Ortopedyczny', '2'),
    ('Gabinet Kardiologiczny', '3');

INSERT INTO equipment (room_id, equipment_name, internal_code, description) VALUES
    ((SELECT id_room FROM rooms WHERE room_number = '2'), 'Stół do badań', 'STB-001', 'Stan dobry'),
    ((SELECT id_room FROM rooms WHERE room_number = '3'), 'EKG', 'EKG-001', 'Model z 2020 roku.'),
    ((SELECT id_room FROM rooms WHERE room_number = '3'), 'Stetoskop Cyfrowy', 'STET-012', 'Wysoka czułość');

INSERT INTO doctor_schedules (doctor_id, room_id, day_of_week, start_time, end_time) VALUES
    (
         (SELECT id_doctor FROM doctors WHERE user_id = (SELECT id_user FROM users WHERE email = 'piotrkowalski@email.com')),
         (SELECT id_room FROM rooms WHERE room_number = '2'),
         1,'08:00:00', '14:00:00'
     ),
    (
         (SELECT id_doctor FROM doctors WHERE user_id = (SELECT id_user FROM users WHERE email = 'agataadamczyk@email.com')),
         (SELECT id_room FROM rooms WHERE room_number = '2'),
         2, '12:00:00', '18:00:00'
    );

INSERT INTO doctor_absences (doctor_id, start_date, end_date) VALUES
    (
        (SELECT id_doctor FROM doctors WHERE user_id = (SELECT id_user FROM users WHERE email = 'piotrkowalski@email.com')),
        '2028-03-01 00:00:00', '2028-03-07 23:59:59'
    );

INSERT INTO appointment_statuses (status_name)
VALUES ('ZAPLANOWANE'), ('ZAKOŃCZONE'), ('ANULOWANE')
ON CONFLICT (status_name) DO NOTHING;

INSERT INTO appointments (doctor_id, room_id, patient_id, status_id, start_date_time, end_date_time, note_medical) VALUES
    (
        (SELECT id_doctor FROM doctors WHERE user_id = (SELECT id_user FROM users WHERE email = 'piotrkowalski@email.com')),
        (SELECT id_room FROM rooms WHERE room_number = '2'),
        (SELECT id_patient FROM patients WHERE pesel='80051512345'),
        (SELECT id_status FROM appointment_statuses WHERE status_name = 'ZAPLANOWANE'),
        '2026-02-08 09:00:00', '2026-02-08 09:30:00', 'Konsultacja'
    ),
    (
         (SELECT id_doctor FROM doctors WHERE user_id = (SELECT id_user FROM users WHERE email = 'piotrkowalski@email.com')),
         (SELECT id_room FROM rooms WHERE room_number = '2'),
         (SELECT id_patient FROM patients WHERE pesel = '80051512345'),
         (SELECT id_status FROM appointment_statuses WHERE status_name = 'ZAKOŃCZONE'),
         '2027-02-08 09:00:00', '2027-02-08 09:30:00', 'Kontrola pooperacyjna'
    );