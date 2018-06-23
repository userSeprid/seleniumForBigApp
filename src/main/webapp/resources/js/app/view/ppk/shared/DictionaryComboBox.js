Ext.define('App.view.ppk.shared.DictionaryComboBox', {
    extend: 'Ext.form.field.ComboBox',
    alias: 'widget.dictionary-combobox',

    displayField: 'title',
    valueField: 'id',
    queryMode: 'local',
    editable: false,
    forceSelection: false
});