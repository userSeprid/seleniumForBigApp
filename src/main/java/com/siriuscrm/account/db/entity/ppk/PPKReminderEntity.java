package com.siriuscrm.account.db.entity.ppk;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.dto.CustomDateSerializer;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "ppk_reminder")
public class PPKReminderEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "ppk_id")
    private Long ppkId;

    @JsonSerialize(using = CustomDateSerializer.class)
    @Column(name = "action_date")
    private Date actionDate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "type_id")
    private DictionaryItem type;

    private String description;

}
