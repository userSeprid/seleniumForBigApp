package com.siriuscrm.testcases;

import com.siriuscrm.dictinaries.combobox.*;
import com.siriuscrm.dictinaries.textarea.configuration.TextAreaConfiguration;
import com.siriuscrm.dictinaries.textfield.configuration.TextFieldConfiguration;
import com.siriuscrm.utils.ui.core.AbstractUIElement;
import com.siriuscrm.utils.ui.elements.impl.combobox.*;
import com.siriuscrm.utils.ui.elements.impl.textarea.*;
import com.siriuscrm.utils.ui.elements.impl.textfield.*;
import com.siriuscrm.utils.ui.forms.CreatePPKForm;
import org.junit.Test;

import java.util.Arrays;
import java.util.LinkedList;

public class PPKCase {

    @Test
    public void createPPKCase() {
        //Page must be loaded before creation of web elements because each element wait for it rendering


        LinkedList<AbstractUIElement> config = new LinkedList<AbstractUIElement>() {{
            addAll(Arrays.asList(
                    new CameFromCB(CameFromDict.CAME_FROM),
                    new CompanyCB(CompanyNameDict.SIRIUS),
                    new ConsoleCB(ConsoleDict.MAKS),
                    new ManagerCompanyCB(ManagerCompanyDict.SIRIUS),
                    new ManagerNameCB(ManagerNameDict.SIRIUS_MANAGER_CASE),
                    new ObjectTypeCB(ObjectTypeDict.BUILDING),
                    new PpkCB(PpkDict.MAKS1_CASE),
                    new RegionCB(RegionDict.CHERNIGOV),
                    new BuildingTF(TextFieldConfiguration.FIRST_CASE),
                    new ConsoleNumberTF(TextFieldConfiguration.FIRST_CASE),
                    new DeadlineTF(TextFieldConfiguration.FIRST_CASE),
                    new FlatNumberTF(TextFieldConfiguration.FIRST_CASE),
                    new HouseBlockTF(TextFieldConfiguration.FIRST_CASE),
                    new LatitudeTF(TextFieldConfiguration.FIRST_CASE),
                    new LongitudeTF(TextFieldConfiguration.FIRST_CASE),
                    new PossibilityToIncreaseApTF(TextFieldConfiguration.FIRST_CASE),
                    new ReactTimeTF(TextFieldConfiguration.FIRST_CASE),
                    new SimCard1TF(TextFieldConfiguration.FIRST_CASE),
                    new StartCapitalTF(TextFieldConfiguration.FIRST_CASE),
                    new StreetTF(TextFieldConfiguration.FIRST_CASE),
                    new BalanceNotesTA(TextAreaConfiguration.SECOND_CASE),
                    new DescriptionTA(TextAreaConfiguration.SECOND_CASE),
                    new HistoryTA(TextAreaConfiguration.SECOND_CASE),
                    new NotesTA(TextAreaConfiguration.SECOND_CASE),
                    new TechHistoryTA(TextAreaConfiguration.SECOND_CASE)
            ));
        }};
        CreatePPKForm createPPK = new CreatePPKForm("http://localhost:8080/createPPK");
        createPPK.applyConfig(config);
        createPPK.submitForm();
        createPPK.verifyConfig(config);
    }
}
