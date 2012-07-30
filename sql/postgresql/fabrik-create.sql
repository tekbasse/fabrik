-- fabrik-create.sql
--
-- @author Dekka Corp.
-- @ported from sql-ledger and combined with parts from OpenACS ecommerce package
-- @license GNU GENERAL PUBLIC LICENSE, Version 2, June 1991
-- @cvs-id

CREATE TABLE qfab_parts (
  id int DEFAULT nextval ( 'id' ),
  partnumber text,
  description text,
  unit varchar(5),
  listprice float,
  sellprice float,
  lastcost float,
  priceupdate date DEFAULT current_date,
  weight float4,
  onhand float4 DEFAULT 0,
  notes text,
  makemodel bool DEFAULT 'f',
  assembly bool DEFAULT 'f',
  alternate bool DEFAULT 'f',
  rop float4,
  inventory_accno_id int,
  income_accno_id int,
  expense_accno_id int,
  bin text,
  obsolete bool DEFAULT 'f',
  bom bool DEFAULT 'f',
  image text,
  drawing text,
  microfiche text,
  partsgroup_id int,
  project_id int,
  avgcost float
);

CREATE TABLE qfab_assembly (
  id int,
  parts_id int,
  qty float,
  bom bool,
  adj bool
);


CREATE TABLE qfab_partsvendor (
  vendor_id int,
  parts_id int,
  partnumber text,
  leadtime int2,
  lastcost float,
  curr char(3)
);


CREATE SEQUENCE qfab_jcitemsid;

CREATE TABLE qfab_jcitems (
  id int default nextval('jcitemsid'),
  project_id int,
  parts_id int,
  description text,
  qty float4,
  allocated float4,
  sellprice float8,
  fxsellprice float8,
  serialnumber text,
  checkedin timestamp with time zone,
  checkedout timestamp with time zone,
  employee_id int,
  notes text
);

create index qfab_assembly_id_key on qfab_assembly (id);




create index qfab_jcitems_id_key on qfab_jcitems (id);


-- following needs to be integrated into above

--  rules
--  provisions for requests to change bom or order through an approval workflow --before the change is accepted (ECO)
--  bom must be designed to handle the most demanding functions: planning
--  superbom includes labor/routing with bom, and requirements (think baking recipe etc)
--  multiple views of bom
--  bom references are unique
--  bom includes quantity (manufacturing might result in creation of more than 1 created per bom, for example 1 pipe cut in half creates 2 pipes...)
--  have provisions for handling perishible goods
--  bom refeerences are different than drawing references
--  bom includes all materials to be scheduled
--  bom editing UI is designed to minimize depth of dependencies
--  template boms (used during design process) --optionally use specification parameters (called modularizing) to minimize the number of templates. (a kind of parts number system by specs) --also a revision number
--  orders copy template to their own spec set. (handy for lot number controls, customization, substitutions etc), can create a serial number for each part.
--  addition of a table to handle customized fields (in the same manner as ecommerce package does)
--  
--  When to assign part numbers: every item represented in the system has at least an internal part number. Formal numbers are optional if not specified.
--  parts_master table (links to data in other tables)
--  part_number
--  other_table_name other_table_reference (make these external keys?)
--  (maybe this is an object folder with the CR)? No (or yes, but scary because) CR uses ad_conn for some code with causes problems with scheduled procs. Scheduled procs will be heavily relied on for forecasting and planning, as well as mainenance. CR is meant for more generalized uses, this is a specific datamodel with specific requirements.
--  
--  
--  bom table
--  internal_notes
--  bom_internal_key
--  part _number
--  model_series_number (not unique, for grouping purposes)
--  level (where 0 is lowest assembly level (ie. indivisible/raw material/aquired parts) value is 1 + max of the components in the bom
--  bom_sku (upc etc.)
--  sellable_p
--  service_item_p
--  assembly_p
--  stockable_p
--  phantom_item_p (exists on paper only)
--  manufactured_part_p (1 =requires specialty tools/labor)
--  perishible_item_p (uses quality date)
--  create_serial_number_p
--  last_issued_serial_number
--  shipping_notes (contains flags for hazardous shipping, special instructions)
--  lots_p (track production run, see lot_number)
--  lot_number
--  standards_met_p (track grade, standards compliance for part)
--  
--  make a separate table for tracking each of the _p attributes.
--  
--  
--  substitution_map
--  original_part_number
--  substitute_part_number
--  notes
--  
--  
--  part table
--  length
--  width
--  height
--  volume
--  weight
--  variable-dimension(s)
--  variable-dimension-units
--  manufactured_date
--  quality_date (expires, best used by, date made etc)
--  min_run varchar(5), /* min amount of parts to run to make a profit */
--  serial_number
--  
--  routing table
--  partnumber
--  labor-ref
--  location
--  
