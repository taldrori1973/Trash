package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

public class UserEntry {

    String username;


    PermissionEntry roleAndScope;


    public UserEntry(String username, PermissionEntry roleAndScope) {
        setUsername(username);
        setRoleAndScope(roleAndScope);

    }

    @Override
    public boolean equals(Object otherUserEntry) {
        if (otherUserEntry == null)
            return false;
        if (!(otherUserEntry instanceof UserEntry))
            return false;
        UserEntry userEntry = (UserEntry) otherUserEntry;
        if ((this.getUsername().equals(userEntry.getUsername())) &&
                (this.roleAndScope.getRole().equals(userEntry.roleAndScope.getRole()))
                && (this.roleAndScope.getScope().equals(userEntry.roleAndScope.getScope()))) {
            return true;
        } else
            return false;
    }

    @Override
    public String toString() {
        StringBuffer toString = new StringBuffer();
        toString.append("Username: ").append(getUsername()).append(", ").
                append("Role :").append(roleAndScope.getRole()).append(", ").
                append("Scope: ").append(roleAndScope.getScope()).append(", ");

        return toString.toString();
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public PermissionEntry getRoleAndScope() {
        return roleAndScope;
    }

    public void setRoleAndScope(PermissionEntry roleAndScope) {
        this.roleAndScope = roleAndScope;
    }


}
