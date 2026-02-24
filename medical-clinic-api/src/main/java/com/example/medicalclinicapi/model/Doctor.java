package com.example.medicalclinicapi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "doctors" )
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_doctor")
    private Integer idDoctor;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "specialization", nullable = false)
    private String specialization;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;

}
