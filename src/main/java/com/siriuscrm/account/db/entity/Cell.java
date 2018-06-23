package com.siriuscrm.account.db.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Data
public class Cell {

    @Id
    @Column(name = "cell_number")
    private String cellNumber;

    public Cell() {
    }

    public Cell(String cellNumber) {
        this.cellNumber = cellNumber;
    }

}
