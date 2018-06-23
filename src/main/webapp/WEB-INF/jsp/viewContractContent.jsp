<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="utils/contractUtils.jsp"/>

<script type="text/javascript">

    <%--AIzaSyA0I2Dd69WZNRxy5-COG3-ML4J7_iCIGt0--%>
    var frm = Ext.create('Ext.form.Panel', {
        autoHeight: true,
//        defaults: {
//            style: 'padding: 5px 10px 10px 15px; width: 100%;'
//        },
        border: false,
        items: [
            createImagePreview(scheme),
            createFilePicker(scheme, "<spring:message code="contract.scheme"/>"),
            createImagePreview(mapImg),
            createFilePicker(mapImg, "<spring:message code="contract.map"/>"),
            createImagePreview(mapDetails),
            createFilePicker(mapDetails, "<spring:message code="contract.map"/>"),

            {
                xtype: 'button',
                text: 'Оновити',
                scope: this,
                handler: function (button) {
                    var me = this;
                    var form = button.parent;

                    Ext.Msg.show({
                        title: 'Зберeгти',
                        msg: 'Оновити файли?',
                        buttons: Ext.Msg.OKCANCEL,
                        fn: function (btn, text, opt) {

                            frm.submit({
                                clientValidation: true,
                                url: '/saveImage?id=<c:out value="${param.id}" />',
                                success: function (form, action) {
                                    alert('success');
                                },
                                failure: function (form, action) {
                                    alert('Failure');

                                }
                            });
                        },
                        icon: Ext.MessageBox.QUESTION,
                        config: {
                            form: form,
                            //me: me
                        }
                    });
                }
            }, {
                xtype: 'button',
                text: 'Скасувати',
                listeners: {
                    scope: this,
                    click: function () {
                        this.destroy();
                    }
                }
            }],
    });



    function createContractContentTab() {
        return [
//            {
//                xtype: 'map',
//                useCurrentLocation: true,
//                mapOptions: {
//                    zoom: 12,
//                    zoomControl: true,
//                    // center: new google.maps.LatLng(1, 1),
//                    disableDefaultUI: true
//                }
//            },
            {
                xtype: 'textfield',
                id: contractId,
                name: contractId,
                itemCls: 'bc-tenant',
                disabled: false,
                cellCls: 'highlight',
                readOnly: true,
                hidden: true,
                cls: 'field-margin',
            },
            {
                xtype: 'textfield',
                id: 'contractId',
                name: 'contractId',
                fieldLabel: '<spring:message code="contract.contract"/>',
                itemCls: 'bc-tenant',
                disabled: false,
                cellCls: 'highlight',
                readOnly: true,
                colspan: 1,
                fieldStyle: 'background-color: #cdd;font-weight: bold;',
                cls: 'field-margin'
            },

            {
                xtype: 'fieldcontainer',
                layout: 'hbox',
                colspan: 2,
                items: [
                    {
                        xtype: 'textfield',
                        fieldLabel: 'Баланс',
                        itemCls: 'bc-tenant',
                        disabled: false,
                        cellCls: 'highlight',
                        readOnly: true,
                        colspan: 1,
                        fieldStyle: 'background-color: green;font-weight: bold;',
                        cls: 'field-margin'
                    },
                    {
                        xtype: 'tbtext',
                        text: '&nbsp;'
                    },
                    {
                        xtype: 'textfield',
                        fieldLabel: '<spring:message code="contract.state"/>',
                        itemCls: 'bc-tenant',
                        disabled: false,
                        cellCls: 'highlight',
                        readOnly: true,
                        colspan: 1,
                        fieldStyle: 'background-color: green;font-weight: bold;',
                        cls: 'field-margin'
                    },
                ]

            },
//            {
//                xtype: 'label',
//                html: '&nbsp;',
//                colspan: 2
//            },

            createDictionaryCombo(companyRef, "<spring:message code="contract.company"/>", 3),
            createDictionaryCombo(dashboardTypeRef, "<spring:message code="contract.control"/>", 4),

            {
                xtype: 'fieldcontainer',
                fieldLabel: '<spring:message code="contract.manager"/>',
                layout: 'hbox',
                items: [
                    createManagerCombo(manager, "<spring:message code="contract.region"/>", 65),
                    {
                        xtype: 'tbtext',
                        text: '&nbsp;'
                    },
                    createManagerCombo(regionRef, "<spring:message code="contract.region"/>", 66),

                ]

            },


            <%--createDictionaryCombo(contractTypeRef, "<spring:message code="contract.type"/>", 1, true),--%>
            <%--createDictionaryCombo(contractTypeExtraRef, "<spring:message code="contract.type.ext"/>", 7),--%>
//            createDatePicker(date),

            createDictionaryCombo(regionRef, "<spring:message code="contract.region"/>", 2),
            createNumberField(dashboardNumber, "<spring:message code="contract.control.num"/>", 1),
            createDictionaryCombo(stateRef, "<spring:message code="contract.state"/>", 6, true),

            createDictionaryCombo(objectTypeRef, "<spring:message code="contract.object"/>", 5),

            <%--createNumberField(payment, "<spring:message code="contract.payment"/>", 1000),--%>

            <%--createNumberField(responsibility, "<spring:message code="contract.payment.responsibility"/>", 5000),--%>

            {
                xtype: 'label',
                html: '&nbsp;',
            },

            createNumberField(objectDashboardNumber, "<spring:message code="contract.control.obj"/>", 1),

            createNumberField(reactionTime, "<spring:message code="contract.reaction.time"/>", 1),



//            createNumberField(balance, "Баланс", 1),
//            {
//                xtype: 'label',
//                html: '&nbsp;',
//            },
            {
                title: 'Договори',
                header: false,
                id: 'docsGrid',
                xtype: 'grid',
                colspan: 3,
                plugins: [
                    Ext.create('Ext.grid.plugin.CellEditing', {
                        clicksToEdit: 1
                    })
                ],
                listeners: {
//                    cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
//                        location.assign("/viewContract?id=" + record.id);
//                    }
                },
                store: {
                   // model: 'ContractItem',
                    proxy: {
                        type: 'ajax',
                        url: '/api/contractList/linked?parentID=${param.id}&type=1',
                        reader: {
                            type: 'json',
                            rootProperty: 'ppkViewList'
                        }
                    },
                    autoLoad: true
                },
                columns: [
                    {
                        text: 'Договiр',
                        dataIndex: 'contractNumber',
                        flex: 1
                    },
                    {
                        text: 'Договiр з',
                        dataIndex: 'since',
                        format: 'm d Y',
                        flex: 1,
                        renderer: Ext.util.Format.dateRenderer('Y-m-d'),
                        editor: {
                            xtype: 'datefield',
                            dateFormat: 'Y-m-d',
                            format: 'm d Y',
                            minValue: '01/01/1900',
                            maxValue: new Date()
                        }
                    },
                    {
                        text: 'Договiр по',
                        dataIndex: 'endOfContract',
                        format: 'm d Y',
                        flex: 1,
                        renderer: Ext.util.Format.dateRenderer('Y-m-d'),
                        editor: {
                            xtype: 'datefield',
                            dateFormat: 'Y-m-d',
                            format: 'm d Y',
                            minValue: '01/01/1900',
                            maxValue: new Date()
                        }
                    },
                    {
                        text: 'Вiдповiдальнiсть',
                        dataIndex: 'responsibility',
                        flex: 1,
                        editor: {
                            xtype: 'textfield',
                            allowBlank: false
                        }
                    },
                    {
                        text: 'Абонплата',
                        dataIndex: 'payment',
                        flex: 1,
                        editor: {
                            xtype: 'textfield',
                            allowBlank: false
                        }
                    },
                    {
                        text: 'Форма оплати',
                        dataIndex: 'paymentType',
                        flex: 1,
                        editor: {
                            xtype: 'textfield',
                            allowBlank: false
                        }
                    },
                    {
                        text: 'Стан',
                        dataIndex: 'stateId',
                        valueField: 'id',
                        flex: 1,
                        editor: {
                            xtype: 'combobox',
                            displayField: 'title',
                            valueField: 'id',
                            store: createDictionaryStore(6)
                        },
                        renderer: function (value, metaData, record, rowIndex, colIndex, store, view) {
                            var combo = this.columns[colIndex].getEditor();
                            var combostore = combo.getStore();
                            var dataIndex = combostore.findExact('id', value);
                            if (dataIndex == -1) dataIndex = 0
                            var recordCombo = combostore.getAt(dataIndex);
                            return recordCombo.get('title');
                        },
                    },
                    {
                        text: 'Договiр',
                        xtype: 'actioncolumn',
                        flex: 1,
                        items: [
                            {
                                icon: 'http://baseball-mag.net/sp/images/pencil.png',
                                tooltip: 'print',
                                handler: function (grid, rowIndex, colIndex) {
                                    var rec = grid.getStore().getAt(rowIndex);
                                    alert("print " + rec.get('id'));
                                }
                            }]
                    }
                ]
            },

            createEditText(docs, "Наявнiсть документiв"),
            {
                xtype: 'label',
                html: '&nbsp;',
                colspan: 3,
            },
            createTextArea(client, "<spring:message code="contract.client"/>"),
            createTextArea(address, "<spring:message code="contract.address"/>"),
            createTextArea(contacts, "<spring:message code="contract.contacts"/>"),
            createTextArea(description, "<spring:message code="contract.description"/>"),
            createTextArea(requisites, "<spring:message code="contract.requisites"/>"),
            createTextArea(mail, "<spring:message code="contract.mail"/>"),
            createEditText(increase, "<spring:message code="contract.payment.increase.note"/>"),
            {
                xtype: 'label',
                html: '&nbsp;',
            },
//            map,
            createTextArea(paymentNote, "<spring:message code="contract.payment.note"/>"),
            createTextArea(histori, "<spring:message code="contract.payment.history"/>"),
            createTextArea(techHistory, "<spring:message code="contract.payment.tech.history"/>"),
            createTextArea(note, "<spring:message code="contract.note"/>"),
            createTextArea(instrument, "<spring:message code="contract.instrument"/>"),
            frm
        ]
    };
</script>