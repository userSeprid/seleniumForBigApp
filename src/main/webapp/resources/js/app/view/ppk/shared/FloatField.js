Ext.define('App.view.ppk.shared.FloatField', {
    extend: 'Ext.form.NumberField',
    alias: 'widget.float-field',

    setValue: function (v) {
        v = typeof v == 'number' ? v : String(v).replace(this.decimalSeparator, ".");
        v = isNaN(v) ? '' : String(v).replace(".", this.decimalSeparator);
        // v = v == 0 ? '' : v;
        return Ext.form.NumberField.superclass.setValue.call(this, v);
    },

    fixPrecision: function (value) {
        var nan = isNaN(value);
        if (!this.allowDecimals || this.decimalPrecision == -1 || nan || !value) {
            return nan ? '' : value;
        }
        return parseFloat(value).toFixed(this.decimalPrecision);
    },

});