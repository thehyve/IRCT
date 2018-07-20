CREATE FUNCTION add_i2b2_medco_resource(
  resourceName varchar,
  medcoCellsURLs varchar,
  domains varchar,
  userName varchar,
  password varchar,
  ignoreCertificate varchar,
  useJWT varchar,
  resourceImplementingInterface varchar,
  resourceOntology varchar
) RETURNS VOID AS $$

DECLARE
  resourceId integer;
  containsId integer;
  constrainModifierId integer;
  constrainValueId integer;
BEGIN

  perform add_i2b2_resource(resourceName, medcoCellsURLs, null, null, null, domains, userName, password, ignoreCertificate, useJWT, resourceImplementingInterface, resourceOntology);

  resourceId := (select id from IRCT_Resource where name = resourceName);
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_NUMERIC');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_ENUM');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_STRING');

  containsId := (select IRCT_PredicateType.id from IRCT_PredicateType, IRCT_Resource_PredicateType where
    IRCT_Resource_PredicateType.Resource_Id = resourceId and
    IRCT_Resource_PredicateType.supportedPredicates_id = IRCT_PredicateType.id and
    IRCT_PredicateType.name = 'CONTAINS');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_NUMERIC');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_ENUM');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_STRING');

  constrainModifierId := containsId + 1;
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_NUMERIC');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_ENUM');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoDataType:ENC_CONCEPT_STRING');

  constrainValueId := containsId + 2;
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_NUMERIC');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_ENUM');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_STRING');

END;
$$ LANGUAGE plpgsql;
