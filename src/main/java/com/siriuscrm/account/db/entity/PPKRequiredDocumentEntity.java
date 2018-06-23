package com.siriuscrm.account.db.entity;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.dto.CustomDateSerializer;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "ppk_required_documents")
public class PPKRequiredDocumentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "ppk_id")
    private Long ppkId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "status_id")
    private DictionaryItem status;

    private String title;

    @Column(name = "valid_till")
    @JsonSerialize(using = CustomDateSerializer.class)
    private Date validTill;

    private String notes;

}
