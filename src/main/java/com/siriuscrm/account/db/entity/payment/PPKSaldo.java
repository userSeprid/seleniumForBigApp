package com.siriuscrm.account.db.entity.payment;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Data
@Entity(name = "ppk_saldo_fake")
public class PPKSaldo {

    @Id
    private Date minDate;

    private Date maxDate;

    private Date startPeriodDate;

    private Date endPeriodDate;

    private Integer startPeriodSaldo;

    private Integer endPeriodSaldo;

}
