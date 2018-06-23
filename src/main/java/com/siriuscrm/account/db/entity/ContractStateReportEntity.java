package com.siriuscrm.account.db.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.siriuscrm.account.db.entity.contract.ContractStateEntity;
import com.siriuscrm.account.db.entity.contract.ContractStateViewEntity;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "contract_state_report")
public class ContractStateReportEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "contract_state_id")
    @JsonIgnore
    private ContractStateViewEntity contractState;

    private String title;
    private String template;

    @JsonIgnore
    private byte[] files;
}
