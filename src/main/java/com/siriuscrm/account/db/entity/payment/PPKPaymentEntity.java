package com.siriuscrm.account.db.entity.payment;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.dto.CustomDateSerializer;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;


@Data
@Entity
@Table(name = "ppk_payment")
public class PPKPaymentEntity {

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

    @Column(name = "create_date")
    @JsonSerialize(using = CustomDateSerializer.class)
    private Date createDate = new Date();

    private Integer amount;

    private String description;
}
