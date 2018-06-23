package com.siriuscrm.account.db.entity.contract;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import lombok.Data;

import javax.persistence.*;

/**
 * Created by asolod on 10/29/2017.
 */
@Data
@MappedSuperclass
public class ContractSuperClass {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "ppk_id")
    public PPKEntity ppk;

    @ManyToOne
    @JoinColumn(name = "type_id")
    private DictionaryItem type;

    private Boolean deposit;

    @Column(name = "social_project")
    private Boolean socialProject;

    @Column(name = "sms_guard_switch")
    private Boolean smsGuardSwitch;

    @Column(name = "sms_alarm")
    private Boolean smsAlarm;
}
