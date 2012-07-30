-- fabrik-drop.sql
--
-- @author Dekka Corp.
-- @ported from sql-ledger and combined with parts from OpenACS ecommerce package
-- @license GNU GENERAL PUBLIC LICENSE, Version 2, June 1991
-- @cvs-id


drop index qfab_jcitems_id_key on qfab_jcitems ();

drop index qfab_partsgroup_key on qfab_partsgroup ();
drop index qfab_partsgroup_id_key on qfab_partsgroup ();


drop index qfab_makemodel_model_key on qfab_makemodel ();
drop index qfab_makemodel_make_key on qfab_makemodel ();
drop index qfab_makemodel_parts_id_key on qfab_makemodel ();

drop index qfab_assembly_id_key on qfab_assembly ();

DROP TABLE qfab_jcitems;

DROP SEQUENCE qfab_jcitemsid;


DROP TABLE qfab_partsvendor;


DROP TABLE qfab_assembly;

DROP TABLE qfab_parts;
