package com.siriuscrm.account.db.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.siriuscrm.account.db.entity.ppk.PPKEntity;
import com.siriuscrm.account.dto.CustomDateSerializer;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Data
@Entity
@Table(name = "person")
public class PersonEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "type_id")
    private DictionaryItem type;

    private String name;
    private String phone;
    private String email;
    private String fax;
    private String skype;
    private String note;
    private String inn;
    @Column(name = "passport_number")
    private String passportNumber;
    @Column(name = "passport_institute")
    private String passportInstitute;
    private String registration;
    @Column(name = "fact_address")
    private String factAddress;
    private String edrpo;
    @Column(name = "registration_date")
    @JsonSerialize(using = CustomDateSerializer.class)
    private Date registrationDate;
    private String ipn;
    private String vat;
    private String account;
    private String bank;
    private String mfo;
    private String cto;

    @JsonIgnore
    @ManyToMany(mappedBy = "persons")
    public Set<PPKEntity> ppkEntities = new HashSet<>();

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        PersonEntity person = (PersonEntity) o;
        return Objects.equals(id, person.id);
    }

    @Override
    public int hashCode() {

        return Objects.hash(super.hashCode(), id);
    }
}


