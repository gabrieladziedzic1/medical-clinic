package com.example.medicalclinicapi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "roles" )
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_role")
    private Integer idRole;

    @Column(name = "role_name", length = 20, unique = true, nullable = false)
    private String roleName;
}
