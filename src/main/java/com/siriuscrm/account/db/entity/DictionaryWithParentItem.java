package com.siriuscrm.account.db.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "dictionaries")
public class DictionaryWithParentItem {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "parent_id")
    private Long parentId;
    @Column(name = "parent_title")
    private String parentTitle;
    private String code;
    private String title;

}
