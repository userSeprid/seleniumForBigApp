package com.siriuscrm.account.db.entity.contract;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import java.io.Serializable;

@Data
@Entity(name = "contract_fee_by_months")
public class ContractFeeViewEntity {

    @Embeddable
    @Data
    public static class PK implements Serializable {
        private Long contractId;
        private Integer year;
        private Integer month;
    }

    @EmbeddedId
    private PK pk;

    @Column(name = "ppk_id")
    private Long ppkId;

    @Column(name = "ppk_number")
    private Long ppkNumber;

    @Column(name = "contract_number")
    private String contractNumber;

    private Integer fee;


}
