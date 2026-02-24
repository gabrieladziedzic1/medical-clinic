package com.example.medicalclinicapi.model;

import jakarta.persistence.*;

@Entity
@Table(name = "rooms" )
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_room")
    private Integer idRoom;

    @Column(name = "room_name", length = 50, nullable = false)
    private String roomName;

    @Column(name = "room_number", length = 25, unique = true, nullable = false)
    private String roomNumber;

    @Column(name = "is_available", nullable = false)
    private Boolean isAvailable = true;

}
