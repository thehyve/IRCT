CREATE OR REPLACE FUNCTION add_i2b2_resource(
  resourceName varchar,
  resourceURL varchar,
  transmartURL varchar,
  auth0ClientId varchar,
  auth0Domain varchar,
  pDomain varchar,
  userName varchar,
  password varchar,
  ignoreCertificate varchar,
  useJWT varchar,
  resourceImplementingInterface varchar,
  resourceOntology varchar
) RETURNS VOID AS $$

DECLARE
  -- Set the resource variables
  resourceId integer := (select COALESCE(max(id), 0) from IRCT_Resource) + 1;

  -- Set the resource predicates
  containsId integer := (select COALESCE(max(id), 0) from IRCT_PredicateType) + 1;
  constrainModifierId integer := containsId + 1;
  constrainValueId integer := containsId + 2;
  constrainDateId integer := containsId + 3;

  -- Set the Fields
  modifier_FieldId integer := (select COALESCE(max(id), 0) from IRCT_Field) + 1;

  operator_ConstrainValueId integer := modifier_FieldId + 1;
  constraint_ConstrainValueId integer := operator_ConstrainValueId + 1;
  unitOfMeasure_ConstrainValueId integer := constraint_ConstrainValueId + 1;

  fromInclusive_ConstrainDateId integer := unitOfMeasure_ConstrainValueId + 1;
  fromTime_ConstrainDateId integer := fromInclusive_ConstrainDateId + 1;
  fromDate_ConstrainDateId integer := fromTime_ConstrainDateId + 1;
  toInclusive_ConstrainDateId integer := fromDate_ConstrainDateId + 1;
  toTime_ConstrainDateId integer := toInclusive_ConstrainDateId + 1;
  toDate_ConstrainDateId integer := toTime_ConstrainDateId + 1;

BEGIN
  -- INSERT THE RESOURCE
  insert into IRCT_Resource(id, implementingInterface, name, ontologyType) values(resourceId, resourceImplementingInterface, resourceName, resourceOntology);

  -- INSERT THE RESOURCE PARAMERTERS
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'resourceName', resourceName);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'resourceURL', resourceURL);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'transmartURL', transmartURL);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'domain', pDomain);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'username', userName);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'password', password);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'ignoreCertificate', ignoreCertificate);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'clientId', auth0ClientId);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'namespace', auth0Domain);
  insert into IRCT_resource_parameters(id, name, value) values(resourceId, 'useJWT', useJWT);

  -- INSERT RESOURCE DATATYEPS
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_NUMERIC');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_ENUM');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_STRING');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:DATETIME');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:DATE');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:INTEGER');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:STRING');
  insert into IRCT_Resource_dataTypes(Resource_id, datatypes) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:FLOAT');

  -- INSERT RESOURCE RELATIONSHIPS
  insert into IRCT_Resource_relationships(Resource_id, relationships) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:PARENT');
  insert into IRCT_Resource_relationships(Resource_id, relationships) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:CHILD');
  insert into IRCT_Resource_relationships(Resource_id, relationships) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:SIBLING');
  insert into IRCT_Resource_relationships(Resource_id, relationships) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:MODIFIER');
  insert into IRCT_Resource_relationships(Resource_id, relationships) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:TERM');
  insert into IRCT_Resource_relationships(Resource_id, relationships) values(resourceId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:AGGREGATE');

  -- INSERT RESOURCE LogicalOperators
  insert into IRCT_Resource_LogicalOperator(id, logicalOperator) values(resourceId, 'AND');
  insert into IRCT_Resource_LogicalOperator(id, logicalOperator) values(resourceId, 'OR');
  insert into IRCT_Resource_LogicalOperator(id, logicalOperator) values(resourceId, 'NOT');

  -- CONTAINS PREDICATE
  insert into IRCT_PredicateType(id, defaultPredicate, description, displayName, name) values(containsId, true, 'Contains value', 'Contains', 'CONTAINS');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_NUMERIC');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_ENUM');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_STRING');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:STRING');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:INTEGER');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(containsId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:FLOAT');

  insert into IRCT_Resource_PredicateType(Resource_Id, supportedPredicates_id) values(resourceId, containsId);

  -- CONSTRAIN BY MODIFER
  insert into IRCT_PredicateType(id, defaultPredicate, description, displayName, name) values(constrainModifierId, false, 'Constrain by Modifier', 'Constrain by Modifier', 'CONSTRAIN_MODIFIER');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:STRING');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:INTEGER');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:FLOAT');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_NUMERIC');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_ENUM');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainModifierId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_STRING');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(modifier_FieldId, 'Constrain by a modifier of this entity', 'Modifier', 'MODIFIER_KEY', 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2OntologyRelationship:MODIFIER', true);

  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainModifierId, modifier_FieldId);

  insert into IRCT_Resource_PredicateType(Resource_Id, supportedPredicates_id) values(resourceId, constrainModifierId);

  -- CONSTRAIN BY VALUE
  insert into IRCT_PredicateType(id, defaultPredicate, description, displayName, name) values(constrainValueId, false, 'Constrains by Value', 'Constrain by Value', 'CONSTRAIN_VALUE');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:STRING');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:INTEGER');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:FLOAT');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_NUMERIC');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_ENUM');
  insert into IRCT_PredicateType_dataTypes(PredicateType_id, dataTypes) values(constrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType:CONCEPT_STRING');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(operator_ConstrainValueId, 'Operator', 'Operator', 'OPERATOR', null, true);
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'EQ');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'NE');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'GT');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'GE');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'LT');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'LE');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'BETWEEN');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'LIKE[exact]');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'LIKE[begin]');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'LIKE[end]');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(operator_ConstrainValueId, 'LIKE[contains]');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(constraint_ConstrainValueId, 'Constraint', 'Constraint', 'CONSTRAINT', null, true);
  insert into IRCT_Field_dataTypes(Field_id, dataTypes) values(constraint_ConstrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:STRING');
  insert into IRCT_Field_dataTypes(Field_id, dataTypes) values(constraint_ConstrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:INTEGER');
  insert into IRCT_Field_dataTypes(Field_id, dataTypes) values(constraint_ConstrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:FLOAT');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(unitOfMeasure_ConstrainValueId, 'Unit of Measure', 'Unit of Measure', 'UNIT_OF_MEASURE', null, false);
  insert into IRCT_Field_dataTypes(Field_id, dataTypes) values(unitOfMeasure_ConstrainValueId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:STRING');

  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainValueId, operator_ConstrainValueId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainValueId, constraint_ConstrainValueId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainValueId, unitOfMeasure_ConstrainValueId);


  insert into IRCT_Resource_PredicateType(Resource_Id, supportedPredicates_id) values(resourceId, constrainValueId);
  -- CONSTRAIN BY DATE
  insert into IRCT_PredicateType(id, defaultPredicate, description, displayName, name) values(constrainDateId, false, 'Constrains by Date', 'Constrain by Date', 'CONSTRAIN_DATE');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(fromInclusive_ConstrainDateId, 'Inclusive From Date', 'From Inclusive', 'FROM_INCLUSIVE', null, true);
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(fromInclusive_ConstrainDateId, 'YES');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(fromInclusive_ConstrainDateId, 'NO');


  insert into IRCT_Field(id, description, name, path, relationship, required) values(fromTime_ConstrainDateId, 'From Date Start or End', 'From Time', 'FROM_TIME', null, true);
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(fromTime_ConstrainDateId, 'START_DATE');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(fromTime_ConstrainDateId, 'END_DATE');


  insert into IRCT_Field(id, description, name, path, relationship, required) values(fromDate_ConstrainDateId, 'From Date', 'From Date', 'FROM_DATE', null, true);
  insert into IRCT_Field_dataTypes(Field_id, dataTypes) values(fromDate_ConstrainDateId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:DATE');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(toInclusive_ConstrainDateId, 'Inclusive To Date', 'To Inclusive', 'TO_INCLUSIVE', null, true);
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(toInclusive_ConstrainDateId, 'YES');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(toInclusive_ConstrainDateId, 'NO');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(toTime_ConstrainDateId, 'To Date Start or End', 'To Time', 'TO_TIME', null, true);
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(toTime_ConstrainDateId, 'START_DATE');
  insert into IRCT_Field_permittedValues(Field_Id, permittedValues) values(toTime_ConstrainDateId, 'END_DATE');

  insert into IRCT_Field(id, description, name, path, relationship, required) values(toDate_ConstrainDateId, 'To Date', 'To Date', 'TO_DATE', null, true);
  insert into IRCT_Field_dataTypes(Field_id, dataTypes) values(toDate_ConstrainDateId, 'edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType:DATE');

  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainDateId, fromInclusive_ConstrainDateId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainDateId, fromTime_ConstrainDateId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainDateId, fromDate_ConstrainDateId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainDateId, toInclusive_ConstrainDateId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainDateId, toTime_ConstrainDateId);
  insert into IRCT_PredicateType_Field(PredicateType_id, fields_id) values(constrainDateId, toDate_ConstrainDateId);

  insert into IRCT_Resource_PredicateType(Resource_Id, supportedPredicates_id) values(resourceId, constrainDateId);
END;
$$ LANGUAGE plpgsql;
