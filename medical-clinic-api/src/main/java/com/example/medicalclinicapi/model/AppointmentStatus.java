package com.example.medicalclinicapi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "appointment_statuses")
public class AppointmentStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_status")
    private Long idStatus;

    @Column(name = "status_name", length = 50, unique = true, nullable = false)
    private String statusName;
}
