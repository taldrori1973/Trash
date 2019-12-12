package com.radware.vision.infra.base.pages.topologytree.dynamicview;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdownStandard;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.testhandlers.topologytree.enums.DynamicViewFilters;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 12/28/2014.
 */
public class DynamicView {
    public static void setDynamicViewFilter(DynamicViewFilters dynamicViewFilter, String filterValue) {
        ComponentLocator locator;
        String filterId;
        if (filterValue != null && !filterValue.isEmpty()) {
            filterId = WebUIStringsVision.getDynamicViewFilter(dynamicViewFilter.getFilter());
            locator = new ComponentLocator(How.ID, filterId);

            if (dynamicViewFilter == DynamicViewFilters.FILTER_BY_STATUS || dynamicViewFilter == DynamicViewFilters.FILTER_BY_TYPE) {
                WebUIDropdownStandard dropdownStandart = new WebUIDropdownStandard();
                dropdownStandart.setWebElement(new WebUIComponent(locator).getWebElement());
                dropdownStandart.selectOptionByValue(filterValue);
            } else if ((dynamicViewFilter == DynamicViewFilters.FILTER_BY_IP || dynamicViewFilter == DynamicViewFilters.FILTER_BY_NAME)) {
                WebUITextField textField = new WebUITextField(locator);
                textField.setWebElement(new WebUIComponent(locator).getWebElement());
                textField.type(filterValue);
            }
        }

    }

    public static void searchButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDynamicViewSearchButton());
        (new WebUIComponent(locator)).click();
    }
}
