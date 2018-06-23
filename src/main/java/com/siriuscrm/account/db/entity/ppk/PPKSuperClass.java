package com.siriuscrm.account.db.entity.ppk;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.db.entity.DictionaryItem;
import com.siriuscrm.account.db.entity.PersonEntity;
import com.siriuscrm.account.dto.CustomDateSerializer;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Data
@MappedSuperclass
public class PPKSuperClass {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @JsonSerialize(using = CustomDateSerializer.class)
    @Column(name = "create_date")
    private Date createDate;

    @Column(name = "location_region")
    private String locationRegion;

    @Column(name = "location_city")
    private String locationCity;

    @Column(name = "location_street")
    private String locationStreet;

    @Column(name = "location_house")
    private Integer locationHouse;

    @Column(name = "location_entrance")
    private Integer locationEntrance;

    @Column(name = "location_korpus")
    private Integer locationKorpus;

    @Column(name = "location_floor")
    private Integer locationFloor;

    @Column(name = "location_apartments")
    private Integer locationApartments;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dashboard_type_id")
    private DictionaryItem dashboardType;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dashboard_subtype_id")
    private DictionaryItem dashboardSubtype;

    @Column(name = "dashboard_number")
    private Integer dashboardNumber;

    @Column(name = "dashboard_cell")
    private String dashboardCell;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "region_id")
    private DictionaryItem region;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "company_id")
    private DictionaryItem company;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "object_type_id")
    private DictionaryItem objectType;

    private String description;

    @Column(name = "reaction_time")
    private Integer reactionTime;

    private String increase;

    private String history;
    @Column(name = "tech_history")
    private String techHistory;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "manager_id")
    private DictionaryItem manager;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "manager_company_id")
    private DictionaryItem managerCompany;

    private String note;

    private Float latitude;

    private Float longitude;

    @Column(name = "status_id")
    private Long statusId;

    @Column(name = "sim_card1")
    private String simCard1;

    @Column(name = "sim_card2")
    private String simCard2;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "came_from_id")
    private DictionaryItem cameFrom;

    @Column(name = "pay_till_day")
    private Integer payTillDay;

    @Column(name = "dashboard_property")
    private String dashboardProperty;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(
            name = "ppk_person",
            joinColumns = {@JoinColumn(name = "ppk_id")},
            inverseJoinColumns = {@JoinColumn(name = "person_id")}
    )
    private List<PersonEntity> persons = new LinkedList<>();

}
