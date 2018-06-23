package com.siriuscrm.account.db.entity.ppk;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.siriuscrm.account.db.entity.DictionaryItem;
import lombok.Data;

import javax.persistence.*;


@Data
@Entity
@Table(name = "ppk_view")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class PPKView extends PPKSuperClass {

    @Column(name = "ppk_number")
    private String ppkNumber;

    private Integer balance;

    private Integer debit;

    private Integer credit;

    @Column(name = "max_refund")
    private Integer maxRefund;

    @Column(name = "balance_description")
    private String balanceDescription;

    @Column(name = "documents_completed")
    private Boolean documentsCompleted;

    @Transient
    private String scheme;

    @Transient
    private String map;

    @Transient
    private String mapDetails;

    @Transient
    private Integer saldo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "state_id")
    private DictionaryItem state;


    @PostLoad
    public void generateFileURLs() {
        saldo = credit + balance - debit;
        scheme = "/api/ppkFiles/files/" + this.getId() + "/scheme";
        map = "/api/ppkFiles/files/" + this.getId() + "/map";
        mapDetails = "/api/ppkFiles/files/" + this.getId() + "/map_details";
    }
}
