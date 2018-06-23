package com.siriuscrm.account.db.entity.contract;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "contract")
public class ContractEntity extends ContractSuperClass {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "contract")
    private List<ContractStateEntity> contractStates;

}
