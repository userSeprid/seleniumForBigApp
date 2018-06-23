<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

    Ext.Date.monthNames = ['<spring:message code="month.name.january"/>',
        '<spring:message code="month.name.february"/>',
        '<spring:message code="month.name.march"/>',
        '<spring:message code="month.name.april"/>',
        '<spring:message code="month.name.may"/>',
        '<spring:message code="month.name.june"/>',
        '<spring:message code="month.name.july"/>',
        '<spring:message code="month.name.august"/>',
        '<spring:message code="month.name.september"/>',
        '<spring:message code="month.name.october"/>',
        '<spring:message code="month.name.november"/>',
        '<spring:message code="month.name.december"/>'];


    function createDictionaryStore(dictionaryId) {
        var store = Ext.create('Ext.data.Store', {
                model: 'SDictionaryItem',
                proxy: {
                    type: 'ajax',
                    url: '/api/dictionary/findByIdWithNullItem?id=' + dictionaryId,
                    reader: {
                        type: 'json',
                        rootProperty: 'dictionaryItems'
                    }
                },
                autoLoad: true,
            emptyText: 'не вибрано'
            }
        );
        registerStore(store);
        return store;
    }

    function findEmptyCell(dashboard, dashboardNum) {
        Ext.Ajax.request({
            url: 'api/contract/nextCell?dashboard=' + Ext.getCmp(dashboardTypeRef).getValue() + "&dashboardNum=" + Ext.getCmp(dashboardNumber).getValue(),

            success: function (response, opts) {
                var obj = Ext.decode(response.responseText);
                console.dir(obj);
                //   Ext.getCmp(objectDashboardNumber).setValue(obj.data.cell)
            },

            failure: function (response, opts) {
                console.log('server-side failure with status code ' + response.status);
            }
        });
    }

    Ext.define('ContractItem', {
        extend: 'Ext.data.Model',
        success: true,
        fields: [
            {name: 'id', type: 'string'},
            {name: 'title', type: 'string'},
            {name: 'client', type: 'string'},
            {name: 'manager', type: 'string'},
            {
                name: 'stateId',
                type: 'string',
                mapping: 'stateRef.id'
            }
        ]
    });

    function createContractStore(contractId) {
        var store = Ext.create('Ext.data.Store', {
            model: 'ContractItem',
            proxy: {
                type: 'ajax',
                url: '/api/contract?id=' + contractId,
                reader: {
                    type: 'json',
                    rootProperty: 'contractItem'
                }
            },
            autoLoad: true
        });
        registerStore(store);
        return store;
    }

    function createEditText(id, title) {
        return {
            xtype: 'textfield',
            fieldLabel: title,
            id: id,
            name: id,
            itemId: id,
            columnWidth: 0.33,
            valueField: id,
            listeners: {
                'change': function () {
                    buildContractID();
                }
            }
        }
    }

    function createNumberField(id, title, step) {
        return {
            xtype: 'numberfield',
            fieldLabel: title,
            allowNegative: false,
            minValue: 0,
            allowBlank: true,
            id: id,
            name: id,
            step: step,
            handleMouseEvents: true,
            listeners: {
                'change': function (field, value) {
                    buildContractID();

                    if (dashboardNumber === id && value) {
                        findEmptyCell();
                    }
                },
                render: function () {
                    this.getEl().on('mousedown', function (e, t, eOpts) {
//                        alert("TEXT")
                    });
                }
            }
        }
    }

    function createTextArea(id, title) {
        return {
            xtype: 'textareafield',
            fieldLabel: title,
            id: id,
            name: id,
            colspan: 3,
//            validator: function (val) {
//                return (val.trim().length > 0) ? true : "This field may not be empty";
//            }
        }
    }

    function createDictionaryCombo(id, dictionaryTitle, dictionaryId, hidden) {
        return {
            id: id,
            name: id,
            xtype: 'combobox',
            fieldLabel: dictionaryTitle,
            labelAlign: 'left',
            store: createDictionaryStore(dictionaryId),
//            queryMode: 'local',
            displayField: 'title',
            valueField: 'id',
            anchor: '100%',
            labelPad: 5,
            hidden: hidden,
            editable: false,
            forceSelection: false,
            emptyText: '',
            allowBlank: true,
            msgTarget: 'under',
            blankText: 'Not empty',
            listeners: {
                select: function (combo, records) {
                    buildContractID(this.name, records.data['code']);
                },
                change: function () {
                    if (this.getValue() === null) {
                        this.reset();
                    }
                }
            }
        };
    }

    function createManagerCombo(id, dictionaryTitle, dictionaryId, hidden) {
        return {
//            id: id,її
//            name: id,
            xtype: 'combobox',
            labelAlign: 'left',
            store: createDictionaryStore(dictionaryId),
//            queryMode: 'local',
            displayField: 'title',
            valueField: 'id',
            anchor: '100%',
            labelPad: 5,
            hidden: hidden,
            editable: false,
            forceSelection: false,
            emptyText: '',
            allowBlank: true,
            msgTarget: 'under',
            blankText: 'Not empty',
            listeners: {
                select: function (combo, records) {
                    buildContractID(this.name, records.data['code']);
                },
                change: function () {
                    if (this.getValue() === null) {
                        this.reset();
                    }
                }
            }
        };
    }

    function getValueById(id, nullValueReplace, prefix) {
        var comboBox = Ext.getCmp(id);
        return comboBox.store.findRecord('title', comboBox.getRawValue()) ?
            prefix + comboBox.store.findRecord('title', comboBox.getRawValue()).data['code'] : nullValueReplace;
    }

    function getValue(id, nullValueReplace) {
        var cmp = Ext.getCmp(id);
        return cmp.getValue() ? cmp.getValue() : nullValueReplace;
    }

    function getFieldOrNul(object, field) {
        if (object) {
            return object[field];
        } else {
            return '';
        }
    }
    function buildContractID() {
        var pattern = getValueById(companyRef, 'xxx', '');
        pattern += '-<spring:message code="contract.p"/>';
//        pattern += getValueById(contractTypeRef, 'xxx', '-');
        pattern += getValueById(regionRef, 'xx', '-');
        pattern += getValueById(dashboardTypeRef, 'xx', '-');
        pattern += getValue(dashboardNumber, 'xx');
        pattern += padDigits(getValue(objectDashboardNumber, 'xxx'), 3);
//        pattern += getValueById(contractTypeExtraRef, '', '-');
        Ext.getCmp('contractId').setValue(pattern);
    }

    function padDigits(number, digits) {
        return Array(Math.max(digits - String(number).length + 1, 0)).join(0) + number;
    }

    function createDatePicker(id) {
        return {
            id: id,
            xtype: 'datefield',
            anchor: '100%',
            fieldLabel: "<spring:message code='contract.date'/>",
            name: 'date',
            // The value does not match the format, but does match an altFormat; will be parsed
            // using the altFormat and displayed using the format.
            format: 'm d Y',
            altFormats: 'm,d,Y|m.d.Y',
            columnWidth: 0.33
        }
    }

    function createButton(title, id, listener) {
        return {
            id: id,
            xtype: 'button',
            text: title,
            valueField: id,
            columnWidth: 0.33,
            handler: listener
        }
    }

    function createFilePicker(id, name) {
        var fpId = 'fp' + id;
        return {
            xtype: 'fileuploadfield',
            name: id,
            fieldLabel: name,
            msgTarget: 'side',
            buttonText: '<spring:message code="contract.select"/>',
            listeners: {
                'change': function (widget, value, eOpts) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById(id).src = e.target.result;
                    };
                    reader.readAsDataURL(event.target.files[0]);
                }
            }
        }
    }

    function paymentTypeGroup() {
        return {
            xtype: 'radiogroup',
            fieldLabel: '<spring:message code="contract.payment.type.cache"/>/<spring:message code="contract.payment.type.nocache"/>',
            columnWidth: 0.33,
            vertical: false,
            items: [
                {
                    boxLabel: '<spring:message code="contract.payment.type.cache"/>',
                    name: payment,
                    inputValue: '0',
                    checked: true
                },
                {
                    boxLabel: '<spring:message code="contract.payment.type.nocache"/>',
                    name: payment,
                    inputValue: '1'
                }
            ]
        }
    }

    function createImagePreview(id) {
        return {
            xtype: 'container',
            region: 'south',
            width: 300,
            height: 500,
            autoScroll: true,
            items: [{
                xtype: 'image',
                id: id,
                mode: 'image',
                flex: 2,
                name: id,
                height: '500px',
                colspan: 3,
            }]
        };
    }

    Ext.define('SDictionaryItem', {
        extend: 'Ext.data.Model',
        fields: [
            {name: 'id', type: 'string'},
            {name: 'parentId', type: 'int'},
            {name: 'code', type: 'string'},
            {name: 'title', type: 'string'}
        ]
    });

    var contractId = 'id';
    var contractTypeRef = 'contractTypeRef';
    var contractTypeExtraRef = 'contractTypeExtraRef';
    var region = 'regionRef';
    var company = 'companyRef';
    var objectType = 'objectTypeRef';
    var stateRef = 'stateRef';
    var dashboardType = 'dashboardTypeRef';

    var manager = 'manager';
    var client = 'client';
    var dashboardNumber = 'dashboardNumber';
    var balance = 'balance';
    var objectDashboardNumber = 'objectDashboardNumber';
    var date = 'date';
    var address = 'address';
    var requisites = 'requisites';
    var contacts = 'persons';
    var description = 'description';
    var dashboardType = 'dashboardTypeRef';
    var mail = 'mail';
    var payment = 'payment';
    var responsibility = 'responsibility';
    var reactionTime = 'reactionTime';
    var paymentNote = 'paymentNote';
    var increase = 'increase';
    var docs = 'docs';
    var histori = 'history';
    var techHistory = 'techHistory';
    var note = 'note';
    var scheme = 'scheme';
    var mapImg = 'map';
    var instrument = 'instrument';
    var mapDetails = 'mapDetails';
    var contracts = 'cotracts';

    var fields = [
        contractId,
//        contractTypeRef,
//        contractTypeExtraRef,
        regionRef,
        companyRef,
        objectTypeRef,
//        stateRef,
        dashboardTypeRef,
//        manager,
        client,
        dashboardNumber,
        objectDashboardNumber,
//        date,
        address,
        requisites,
        contacts,
        description,
        dashboardTypeRef,
        mail,
//        payment,
//        responsibility,
        reactionTime,
        paymentNote,
        increase,
        histori,
        techHistory
    ];

</script>