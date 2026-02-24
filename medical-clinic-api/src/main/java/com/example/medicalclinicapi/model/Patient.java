package com.example.medicalclinicapi.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "patients" )
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_patient")
    private Long idPatient;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "birth_date", nullable = false)
    private LocalDate birthDate;

    @Column(name = "pesel", unique = true, nullable = false)
    private String pesel;
}
