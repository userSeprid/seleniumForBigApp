package com.siriuscrm.account.db.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "ppk_files")
public class PPKFiles {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne
    @JoinColumn(name = "ppk_id")
    @JsonIgnore
    public PPKEntity ppk;

    private byte[] scheme;

    private byte[] map;

    @Column(name = "map_details")
    private byte[] mapDetails;
}
