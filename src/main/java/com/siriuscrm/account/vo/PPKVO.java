package com.siriuscrm.account.vo;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.siriuscrm.account.db.entity.PersonEntity;
import com.siriuscrm.account.dto.CustomJsonDateDeserializerFromString;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * Created by asolod on 8/21/2017.
 */
@Data
public class PPKVO {

    private Long id;

    @JsonDeserialize(using = CustomJsonDateDeserializerFromString.class)
    private Date createDate;
    private String locationRegion;
    private String locationCity;
    private String locationStreet;
    private Integer locationHouse;
    private Integer locationKorpus;
    private Integer locationApartments;
    private Integer locationEntrance;
    private Integer locationFloor;
    private Long dashboardTypeId;
    private Long dashboardSubtypeId;
    private Integer dashboardNumber;
    private String dashboardCell;
    private Long regionId;
    private Long companyId;
    private Long objectTypeId;
    private String description;
    private Integer reactionTime;
    private Integer paymentTillDay;
    private String increase;
    private String history;
    private String techHistory;
    private Long managerId;
    private String documents;
    private String instrument;
    private Long managerCompanyId;
    private String note;
    private Float latitude;
    private Float longitude;
    private List<PersonEntity> persons;
    private PPKFileVO files;
    private Integer balance;
    private String balanceDescription;
    private String simCard1;
    private String simCard2;
    private Long cameFromId;
    private Integer payTillDay;
    private String dashboardProperty;
}
