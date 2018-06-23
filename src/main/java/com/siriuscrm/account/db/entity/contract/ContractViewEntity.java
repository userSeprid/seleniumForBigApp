package com.siriuscrm.account.db.entity.contract;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;


@Data
@Entity
@Table(name = "contract_view")
public class ContractViewEntity extends ContractSuperClass {

    @Column(name = "contract_number")
    private String contractNumber;

}
