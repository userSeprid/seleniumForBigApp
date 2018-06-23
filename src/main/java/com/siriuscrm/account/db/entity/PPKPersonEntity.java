package com.siriuscrm.account.db.entity;

import com.sun.org.apache.xpath.internal.operations.Bool;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "ppk_person")
@IdClass(PPKPersonEntity.PPKPersonEntityId.class)
public class PPKPersonEntity {

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

    private Boolean owner;

    private Boolean payer;

    private Boolean alarm;

    private Boolean advisor;


}


