package com.siriuscrm.account.db.entity.ppk;

import com.siriuscrm.account.db.entity.PPKFiles;
import lombok.Data;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "ppk")
public class
PPKEntity extends PPKSuperClass {

    @OneToOne(cascade = CascadeType.ALL, mappedBy = "ppk")
    private PPKFiles files;

}
