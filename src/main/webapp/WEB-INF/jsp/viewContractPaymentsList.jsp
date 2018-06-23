<%--
<script src="/javascript/article_admin.js"></script>
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>

<jsp:include page="utils/contractUtils.jsp"/>

<script type="text/javascript">

    Ext.define('PaymentView', {
        extend: 'Ext.data.Model',
        success: true,
        width: 'fit',
        defaults: {
            style: 'padding: 5px 10px 10px 15px; width: 100%;'
        },
        fields: [
            {name: 'priceOfAllPeriod', type: 'int'},
            {name: 'payedOfAllPeriod', type: 'int'},
            {name: 'debt', type: 'string'},
            {
                name: 'total', type: 'int',
                convert: function (val, row) {
                    console.log(row.data)
                    return row.data.p1 + row.data.p2 + row.data.p3;
                }
            }
        ]
    });

    function createPaymentsTab() {
        return [
            {
                layout: {
                    type: 'table',
                    columns: 1
                },
                id: 'paymentView',
                autoHeight: true,
                bodyPadding: 10,
                store: paymentStore2,
                defaults: {
                    style: 'padding: 5px 10px 10px 15px; width: 100%;'
                },
                features: [{
                    ftype: 'summary'
                }],
                items: [
                    {
                        xtype: 'label',
                        forId: 'myFieldId',
                        html: 'Початковий баланс: <span style="font-weight: bold; color: green;">0</span> грн. Станом на:',
                    },
                    {
                        text: 'Нараховано на поточний перiод: 0 грн.',
                        xtype: 'label',
                        name: 'priceOfAllPeriod',
                        id: 'priceOfAllPeriod',
                    },
                    {
                        text: 'Сплачено на поточний перiод: 0 грн.',
                        xtype: 'label',
                        id: 'payedOfAllPeriod',
                        name: 'name',
                    },
                    {
                        text: 'Борг: 0 грн.',
                        xtype: 'label',
                        name: 'debt',
                        id: 'debt',
                    },
                ]
            },
            {
                layout: {
                    type: 'table',
                    columns: 2
                },
                bodyPadding: 10,
                items: [
                    {
                        xtype: 'fieldcontainer',
                        layout: 'hbox',
                        colspan: 2,
                        items: [
                            {
                                id: "createDate",
                                xtype: 'datefield',
                                fieldLabel: 'Дата',
                                name: 'createDate',
                                value: new Date(),
                                format: 'm d Y',
                                padding: '0 15 0 0',
                                altFormats: 'm,d,Y|m.d.Y',
                                colspan: 2,
                            },
                            {
                                id: "amount",
                                fieldLabel: 'Сума',
                                xtype: 'textfield',
                                padding: '0 15 0 0',
                            },
                            {
                                id: "addPaymentNote",
                                fieldLabel: 'Примiтка',
                                xtype: 'textfield',
                                padding: '0 15 0 0',
                            },
                        ]

                    },
                ]
            },
            {
                layout: {
                    type: 'column',
                },
                border: false,
                defaults: {
                    columnWidth: 0.5,
                },
                items: [
                    {
                        title: 'Нарахування',
                        xtype: 'grid',
                        store: paymentStore,
                        padding: '0 5 0 0',
                        plugins: {
                            ptype: 'cellediting',
                            clicksToEdit: 1
                        },
                        features: [{
                            ftype: 'summary'
                        }],
                        listeners: {
                            edit: function (editor, e) {
                                Ext.Ajax.request({
                                        url: '/api/payments/pay',
                                        headers: {'Content-Type': 'application/json'},
                                        jsonData: {
                                            contractID: e.record.data.contractID,
                                            periodNumber: e.record.data.periodNumber,
                                            periodPrice: e.record.data.periodPrice,
                                            price: e.record.data.price,
                                            payed: e.record.data.payed

                                        },
                                        success: function (transport) {
                                            // do something
                                        },
                                        failure: function (transport) {
                                        }
                                    }
                                );
                                e.record.commit();
                            },

                        },
                        columns: [
                            {
                                text: '<spring:message code="payments.period"/>',
                                dataIndex: 'endOfPeriod',
                                renderer: function (value, metaData, record, rowIndex, colIndex, store) {
                                    if (-1 == record.data.periodNumber) {
                                        return ("Останнiй мiсяць");
                                    }
                                    var asupDate = Ext.util.Format.date(value, 'F Y');
                                    return (asupDate);
                                    scope: this
                                },
                                summaryType: 'total',
                                summaryRenderer: function (value, summaryData, field) {
                                    return 'Всього:';
                                },
                                flex: 1,

                            },
                            {
                                text: 'Сигналiзацiя',
                                dataIndex: 'p1',
                                flex: 1,
                                summaryType: 'sum',
                                editor: {
                                    completeOnEnter: true,
                                    field: {
                                        xtype: 'textfield',
                                        allowBlank: false
                                    }
                                }
                            },
                            {
                                text: 'КТС',
                                dataIndex: 'p2',
                                flex: 1,
                                summaryType: 'sum',
                                editor: {
                                    completeOnEnter: true,
                                    field: {
                                        xtype: 'textfield',
                                        allowBlank: false
                                    }
                                }
                            },
                            {
                                text: 'Оренда',
                                dataIndex: 'p3',
                                flex: 1,
                                summaryType: 'sum',
                                editor: {
                                    completeOnEnter: true,
                                    field: {
                                        xtype: 'textfield',
                                        allowBlank: false
                                    }
                                }
                            },
                            {
                                text: 'Всього',
                                dataIndex: 'total',
                                summaryType: 'sum'
                            },
                            {
                                text: 'Сплачено',
                                dataIndex: 'payed',
                                summaryType: 'sum'
                            }
                        ]

                    },
                    {
                        title: 'Проплати',
                        xtype: 'grid',
                        store: storeHistory,
                        padding: '0 0 5 0',
                        plugins: {
                            ptype: 'cellediting',
                            clicksToEdit: 1
                        },
                        features: [{
                            ftype: 'summary'
                        }],
                        listeners: {
                            edit: function (editor, e) {
                                Ext.Ajax.request({
                                        url: '/api/payments/pay',
                                        headers: {'Content-Type': 'application/json'},
                                        jsonData: {
                                            contractID: e.record.data.contractID,
                                            periodNumber: e.record.data.periodNumber,
                                            periodPrice: e.record.data.periodPrice,
                                            price: e.record.data.price,
                                            payed: e.record.data.payed

                                        },
                                        success: function (transport) {
                                            // do something
                                        },
                                        failure: function (transport) {
//                                alert("Error: " - transport.responseText);
                                        }
                                    }
                                );
                                e.record.commit();
                            },

                        },
                        columns: [
                            {
                                text: '<spring:message code="contract.date"/>',
                                dataIndex: 'createDate',
                                type: 'date',
                                dateFormat: 'Y-m',
//                                editor: new Ext.form.DateField({
//                                    disabled: false,
//                                    format: 'd/m/Y'
//                                }),
                                flex: 1,
                                summaryType: 'total',
                                summaryRenderer: function (value, summaryData, dataIndex) {
                                    return 'Всього:';
                                }
                            },
                            {
                                text: '<spring:message code="payments.payed"/>',
                                dataIndex: 'amount',
                                flex: 1,
                                summaryType: 'sum',
                                editor: {
                                    completeOnEnter: true,

                                    field: {
                                        xtype: 'textfield',
                                        allowBlank: false
                                    }
                                }
                            },
                            {
                                text: '<spring:message code="contract.note"/>',
                                dataIndex: 'note',
                                flex: 1,
                                editor: {
                                    completeOnEnter: true,
                                    field: {
                                        xtype: 'textfield',
                                        allowBlank: false
                                    }
                                }
                            }
                        ]
                    }]
            },
            <%--{--%>
            <%--title: 'Таблиця нарахувань та сплат за кожним договором',--%>
            <%--xtype: 'grid',--%>
            <%--store: paymentDetailsStore,--%>
            <%--listeners: {--%>
            <%--cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {--%>
            <%--location.assign("/viewContract?id=" + record.id);--%>
            <%--}--%>
            <%--},--%>
            <%--columns: [--%>
            <%--{--%>
            <%--text: '<spring:message code="contract.number"/>',--%>
            <%--dataIndex: 'contractNumber',--%>
            <%--flex: 1,--%>
            <%--},--%>
            <%--{--%>
            <%--text: '<spring:message code="payments.price"/>',--%>
            <%--dataIndex: 'totalPrice',--%>
            <%--flex: 1,--%>
            <%--},--%>
            <%--{--%>
            <%--text: '<spring:message code="payments.payed"/>',--%>
            <%--dataIndex: 'totalPayed',--%>
            <%--flex: 1,--%>
            <%--}--%>
            <%--]--%>
            <%--}--%>
        ]
    };
</script>

