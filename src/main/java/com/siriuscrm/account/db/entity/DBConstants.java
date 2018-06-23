package com.siriuscrm.account.db.entity;

public class DBConstants {


    public static enum PaymentType {

        Z_PAYMENT(90L), PAYMENT(103L), DEPOSIT_MONTH(89L), WRONG_ALARM(104L);

        private Long typeId;

        PaymentType(Long typeId) {
            this.typeId = typeId;
        }

        public Long getTypeId() {
            return typeId;
        }
    }

    public static enum ContractState {

        ABSENT(91L), UNDER_GUARD(92L), DISABLED(93L);

        private Long typeId;

        ContractState(Long typeId) {
            this.typeId = typeId;
        }

        public Long getTypeId() {
            return typeId;
        }
    }

    public static enum PPKState {

        UNDER_GUARD(100L), PAUSED(101L), DISABLED(102L);

        private Long typeId;

        PPKState(Long typeId) {
            this.typeId = typeId;
        }

        public Long getTypeId() {
            return typeId;
        }

    }


    public enum TYPES {

        DASHBOARD_SUBTYPE(105L),

        PPK_REQUIRED_DOCUMENTS(133L);

        private Long typeId;

        TYPES(Long typeId) {
            this.typeId = typeId;
        }

        public Long getTypeId() {
            return typeId;
        }

    }

    public enum PPK_DASHBOARD_TYPES {

        WITHOUT_CONNECTION(47L);

        private Long typeId;

        PPK_DASHBOARD_TYPES(Long typeId) {
            this.typeId = typeId;
        }

        public Long getTypeId() {
            return typeId;
        }

    }

    public enum REQUIRED_DOCUMENT_STATUS {

        NOT_EXISTS(145L),
        EXISTS(146L),
        NOT_REQUIRED(147L),;

        private Long typeId;

        REQUIRED_DOCUMENT_STATUS(Long typeId) {
            this.typeId = typeId;
        }

        public Long getTypeId() {
            return typeId;
        }

    }

}
