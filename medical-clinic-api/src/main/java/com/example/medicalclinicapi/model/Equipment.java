package com.example.medicalclinicapi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "equipments" )
public class Equipment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_equipment")
    private Long idEquipment;

    @OneToOne
    @JoinColumn(name = "room_id", nullable = false)
    private Room room;

    @Column(name = "equipment_name", length = 50, nullable = false)
    private String equipmentName;

    @Column(name = "internal_code", unique = true, length = 50, nullable = false)
    private String internalCode;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "is_functional", nullable = false)
    private boolean isFunctional = true;
}
