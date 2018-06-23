package com.siriuscrm.dictinaries.textfield.configuration;

public enum TextFieldConfiguration {
    FIRST_CASE(2, "7897987079", 7897, 8797,
            20, "streetName", "buildingNumber", "buildingSubNumber",
            "flatNumber", 2000, 12, "no");

    TextFieldConfiguration(int consoleNumber, String simCard1, int latitude, int longitude,
                           int reactTime, String street, String building, String houseBlock,
                           String flatNumber, int startCapital, int deadline, String possibilityToIncreaseAp) {
        this.consoleNumber = consoleNumber;
        this.simCard1 = simCard1;
        this.latitude = latitude;
        this.longitude = longitude;
        this.reactTime = reactTime;
        this.street = street;
        this.building = building;
        this.houseBlock = houseBlock;
        this.flatNumber = flatNumber;
        this.startCapital = startCapital;
        this.deadline = deadline;
        this.possibilityToIncreaseAp = possibilityToIncreaseAp;
    }

    public int getConsoleNumber() {
        return consoleNumber;
    }

    public String getSimCard1() {
        return simCard1;
    }

    public int getLatitude() {
        return latitude;
    }

    public int getLongitude() {
        return longitude;
    }

    public int getReactTime() {
        return reactTime;
    }

    public String getStreet() {
        return street;
    }

    public String getBuilding() {
        return building;
    }

    public String getHouseBlock() {
        return houseBlock;
    }

    public String getFlatNumber() {
        return flatNumber;
    }

    public int getStartCapital() {
        return startCapital;
    }

    public int getDeadline() {
        return deadline;
    }

    public String getPossibilityToIncreaseAp() {
        return possibilityToIncreaseAp;
    }

    private int consoleNumber;
    private String simCard1;
    private int latitude;
    private int longitude;
    private int reactTime;
    private String street;
    private String building;
    private String houseBlock;
    private String flatNumber;
    private int startCapital;
    private int deadline;
    private String possibilityToIncreaseAp;
}
