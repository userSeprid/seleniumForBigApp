DROP SCHEMA siriuscrm CASCADE;
CREATE SCHEMA public;

DELETE from ppk_person;
DELETE from person;
DELETE from contract_state_report;
DELETE from contract_state;
DELETE from contract;
DELETE from ppk_payment;
DELETE from ppk_required_documents;
DELETE from ppk_reminder;
DELETE from ppk;
--DELETE FROM dictionaries WHERE parent_id = 120;


select * from dictionaries WHERE id =120