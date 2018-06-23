package com.siriuscrm.account.db.entity.contract;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.db.entity.ContractStateReportEntity;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.dto.CustomDateSerializer;
import com.sun.org.apache.xpath.internal.operations.Bool;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "contract_state_view")
public class ContractStateViewEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "contract_number")
    private String contractNumber;

    @Column(name = "contract_id")
    private Long contractId;

    @Column(name = "ppk_id")
    private Long ppkId;

    @JsonSerialize(using = CustomDateSerializer.class)
    @Column(name = "start_date")
    private Date startDate;

    @JsonSerialize(using = CustomDateSerializer.class)
    @Column(name = "end_date")
    private Date endDate;

    @ManyToOne
    @JoinColumn(name = "state_id")
    private DictionaryItem state;

    private Integer payment;

    private Integer refund;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "contractState")
    private List<ContractStateReportEntity> stateReports;

    @Column(name = "contract_type_id")
    private Long contractTypeId;

    private Boolean deposit;

    @Column(name = "social_project")
    private Boolean socialProject;

    @Column(name = "sms_guard_switch")
    private Boolean smsGuardSwitch;

    @Column(name = "sms_alarm")
    private Boolean smsAlarm;

}
