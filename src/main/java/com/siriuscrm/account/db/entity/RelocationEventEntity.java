package com.siriuscrm.account.db.entity;

import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@Table(name = "relocation_event")
public class RelocationEventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "android_account_id")
    private Long androidAccountId;

    private String lat;

    private String lng;

    @Column(name = "event_time")
    private Timestamp eventTime;
}
