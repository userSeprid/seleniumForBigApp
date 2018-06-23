package com.siriuscrm.account.db.entity.contract;

import com.siriuscrm.account.db.entity.ContractStateReportEntity;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.entity.PPKFiles;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "contract_state")
public class ContractStateEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "contract_id")
    private ContractEntity contract;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    @ManyToOne
    @JoinColumn(name = "state_id")
    private DictionaryItem state;

    private Integer payment;

    private Integer refund;

}
