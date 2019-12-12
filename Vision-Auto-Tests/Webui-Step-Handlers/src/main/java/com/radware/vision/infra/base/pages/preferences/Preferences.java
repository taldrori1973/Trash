package com.radware.vision.infra.base.pages.preferences;

import com.radware.vision.infra.base.pages.preferences.userPreferences.UserPreferences;

/**
 * Created by stanislava on 1/11/2015.
 */
public class Preferences {
    public UserPreferences userPreferencesMenu() {
        return (UserPreferences) new UserPreferences().openPage();
    }
}
