package com.siriuscrm.account.db.entity;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "ppk_person_view")
@IdClass(PPKPersonViewEntity.PPKPersonEntityId.class)
public class PPKPersonViewEntity {

    @Data
    @Embeddable
    public static class PPKPersonEntityId implements Serializable {

        @Column(name = "ppk_id")
        private Long ppkId;

        @Column(name = "person_id")
        private Long personId;

        public PPKPersonEntityId() {
        }

        public PPKPersonEntityId(Long ppkId, Long personId) {
            this.ppkId = ppkId;
            this.personId = personId;
        }
    }

    @Id
    private Long ppkId;

    @Id
    private Long personId;

    private String name;

    @Column(name = "type_id")
    private Long typeId;

    private String type;

    private String phone;

    private String email;

    private String fax;

    private String skype;

    private String note;

    private Boolean owner;

    private Boolean payer;

    private Boolean alarm;

    private Boolean advisor;


}


