package com.siriuscrm.dictinaries.textarea.configuration;

public enum TextAreaConfiguration {
    SECOND_CASE(
            "fsf",
            "history",
            "tech history",
            "desc",
            "notes"
    );



    TextAreaConfiguration(String balanceNotes, String history, String techHistory, String description, String notes) {
        this.balanceNotes = balanceNotes;
        this.history = history;
        this.techHistory = techHistory;
        this.description = description;
        this.notes = notes;
    }

    public String getBalanceNotes() {
        return balanceNotes;
    }

    public String getHistory() {
        return history;
    }

    public String getTechHistory() {
        return techHistory;
    }

    public String getDescription() {
        return description;
    }

    public String getNotes() {
        return notes;
    }

    private String balanceNotes;
    private String history;
    private String techHistory;
    private String description;
    private String notes;
}
