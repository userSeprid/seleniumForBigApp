package com.siriuscrm.dictinaries.combobox.configuration;

import com.siriuscrm.dictinaries.combobox.*;
import com.siriuscrm.dictinaries.combobox.managerhelper.SiriusManagersDict;

public enum ComboboxConfiguration {

    FIRST_CASE(CompanyNameDict.SIRIUS, ConsoleDict.MAKS, RegionDict.CHERNIGOV, PpkDict.MAKS1_CASE, ManagerCompanyDict.SIRIUS, ManagerNameDict.SIRIUS_MANAGER_CASE, CameFromDict.CAME_FROM, ObjectTypeDict.BUILDING);

    ComboboxConfiguration(Enum<CompanyNameDict> companyName, Enum<ConsoleDict> console, Enum<RegionDict> region, Enum<PpkDict> ppk,
                          Enum<ManagerCompanyDict> managerCompany, Enum<ManagerNameDict> managerName, Enum<CameFromDict> cameFrom, Enum<ObjectTypeDict> objectType) {
        this.companyName = companyName;
        this.console = console;
        this.region = region;
        this.ppk = ppk;
        this.managerCompany = managerCompany;
        this.managerName = managerName;
        this.cameFrom = cameFrom;
        this.objectType = objectType;
    }

    public Enum<CompanyNameDict> getCompanyName() {
        return companyName;
    }

    public Enum<ConsoleDict> getConsole() {
        return console;
    }

    public Enum<RegionDict> getRegion() {
        return region;
    }

    public Enum<?> getPpk() {
        return ppk;
    }

    public Enum<ManagerCompanyDict> getManagerCompany() {
        return managerCompany;
    }

    public Enum<?> getManagerName() {
        return managerName;
    }

    public Enum<CameFromDict> getCameFrom() {
        return cameFrom;
    }

    public Enum<ObjectTypeDict> getObjectType() {
        return objectType;
    }

    private Enum<CompanyNameDict> companyName;
    private Enum<ConsoleDict> console;
    private Enum<RegionDict> region;
    private Enum<PpkDict> ppk;
    private Enum<ManagerCompanyDict> managerCompany;
    private Enum<ManagerNameDict> managerName;
    private Enum<CameFromDict> cameFrom;
    private Enum<ObjectTypeDict> objectType;
}
