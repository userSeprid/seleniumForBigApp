package com.siriuscrm.account.db.entity.fee;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import java.io.Serializable;

@Data
@Entity
public class PPKFeeEntity {

    @Embeddable
    @Data
    public static class PK implements Serializable {

        @Column(name = "ppk_id")
        private Long ppkId;

        private Integer year;

        @Column(name = "month_number")
        private Integer monthNumber;
    }

    @EmbeddedId
    private PK pk;

    private Integer fee;

    private Integer payment;

    @Column(name = "month_title")
    private String monthTitle;

}
