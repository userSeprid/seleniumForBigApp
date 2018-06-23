<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

    function createAttachedAgreementsTab() {
        return [
            {
                xtype: 'textfield',
                name: 'search',
                value: '${param.search}',
                width: '100%',
                emptyText: 'Пошук'
            },
            {
                title: ' ',
                xtype: 'grid',
                iconCls: 'x-fa fa-users',
                selType: 'checkboxmodel',
                selModel: {
                    allowDeselect: true,
                    listeners: {
                        select: function (model, record, index) {
                            text = record.get('id');
//                                alert(text);
                            Ext.Ajax.request({
                                url: 'api/contract/link?parentId=' + ${param.id} +'&type=1&id=' + text,

                                success: function (response, opts) {
//                                    var obj = Ext.decode(response.responseText);
//                                    console.dir(obj);
                                    alert('OK');
                                },

                                failure: function (response, opts) {
                                    console.log('server-side failure with status code ' + response.status);
                                    alert('NOOK');
                                }
                            });
                        },
                        deselect: function (model, record, index) {
//                                text = record.get('id');
//                                alert(text);
//                                Ext.Ajax.request({
//                                    url: 'api/contract/nextCell?dashboard=' + Ext.getCmp(dashboardType).getValue() + "&dashboardNum=" + Ext.getCmp(dashboardNumber).getValue(),
//
//                                    success: function (response, opts) {
//                                        var obj = Ext.decode(response.responseText);
//                                        console.dir(obj);
//                                    },
//
//                                    failure: function (response, opts) {
//                                        console.log('server-side failure with status code ' + response.status);
//                                    }
//                                });
                        }
                    }
                },

                columns: [
                    {
                        text: '<spring:message code="contract.client"/>',
                        dataIndex: 'client',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.address"/>',
                        dataIndex: 'address',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.payment"/>',
                        dataIndex: 'payment',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.date"/>',
                        dataIndex: 'date',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.manager"/>',
                        dataIndex: 'manager',
                    }
                ]
            },
            {
                xtype: 'label',
                text: 'Договори',
            },
            {
                title: ' ',
                xtype: 'grid',
                iconCls: 'x-fa fa-users',
                collapsible: true,
                listeners: {
                    selectionchange: function (view, selections, options) {
                        alert(selections);
                    }
                },

                selModel: {
                    selType: 'checkboxmodel'
                },
                columns: [
                    {
                        text: '<spring:message code="contract.client"/>',
                        dataIndex: 'client',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.address"/>',
                        dataIndex: 'address',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.payment"/>',
                        dataIndex: 'payment',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.date"/>',
                        dataIndex: 'date',
                        flex: 1
                    },
                    {
                        text: '<spring:message code="contract.manager"/>',
                        dataIndex: 'manager',
                    }
                ]
            }
        ]
    };
</script>