#!/bin/bash
set -e
# configuration of the i2b2 project management cell

####################################################################################
######################### information about password hash ##########################
####################################################################################

### how to generate the hash (from shrine sources folder)
# cd "install/i2b2-1.7/i2b2"
# javac ./I2b2PasswordCryptor.java
# SHRINE_PW=$(java -classpath ./ I2b2PasswordCryptor <thepassword>)

### some encrypted versions:
# demouser=             9117d59a69dc49807671a51f10ab7f
# prigen2017=           f8eb764674b57b5710e3c1665464e29
# pFjy3EjDVwLfT2rB9xkK= 7cb1ac9deab165535494d60da1d3d7e
####################################################################################

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "$I2B2_DEMO_DB_NAME" <<-EOSQL

    -- cell parameters
    insert into i2b2pm.pm_cell_params (datatype_cd, cell_id, project_path, param_name_cd, value, changeby_char, status_cd) values
        ('T', 'FRC', '/', 'DestDir', '$I2B2_FR_FILES_DIR', 'i2b2', 'A');

    -- database lookups
    update i2b2hive.crc_db_lookup SET C_DOMAIN_ID = '$I2B2_DOMAIN_NAME' WHERE C_DOMAIN_ID = 'i2b2demo';
    UPDATE i2b2hive.im_db_lookup SET C_DOMAIN_ID = '$I2B2_DOMAIN_NAME' WHERE C_DOMAIN_ID = 'i2b2demo';
    UPDATE i2b2hive.ont_db_lookup SET C_DOMAIN_ID = '$I2B2_DOMAIN_NAME' WHERE C_DOMAIN_ID = 'i2b2demo';
    UPDATE i2b2hive.work_db_lookup SET C_DOMAIN_ID = '$I2B2_DOMAIN_NAME' WHERE C_DOMAIN_ID = 'i2b2demo';

    -- hive & users data
    UPDATE i2b2pm.pm_hive_data SET DOMAIN_ID = '$I2B2_DOMAIN_NAME', DOMAIN_NAME = '$I2B2_DOMAIN_NAME' WHERE DOMAIN_ID = 'i2b2';

    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://wildfly-server:8080/i2b2/services/QueryToolService/' WHERE CELL_ID = 'CRC';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://wildfly-server:8080/i2b2/services/FRService/' WHERE CELL_ID = 'FRC';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://wildfly-server:8080/i2b2/services/OntologyService/' WHERE CELL_ID = 'ONT';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://wildfly-server:8080/i2b2/services/WorkplaceService/' WHERE CELL_ID = 'WORK';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://wildfly-server:8080/i2b2/services/IMService/' WHERE CELL_ID = 'IM';

    UPDATE i2b2pm.PM_USER_DATA SET PASSWORD = '9117d59a69dc49807671a51f10ab7f' WHERE USER_ID = 'i2b2';
    UPDATE i2b2pm.PM_USER_DATA SET PASSWORD = '9117d59a69dc49807671a51f10ab7f' WHERE USER_ID = 'demo';
    UPDATE i2b2pm.PM_USER_DATA SET PASSWORD = '7cb1ac9deab165535494d60da1d3d7e' WHERE USER_ID = 'AGG_SERVICE_ACCOUNT';

    -- oidc user
    INSERT INTO pm_user_data VALUES ('test', 'test', NULL, 'test@test.com', NULL, NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_user_params VALUES (1, 'T', 'test', 'authentication_method', 'OIDC', NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_user_params VALUES (2, 'T', 'test', 'oidc_jwks_uri', 'http://keycloak:8080/auth/realms/master/protocol/openid-connect/certs', NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_user_params VALUES (3, 'T', 'test', 'oidc_client_id', 'i2b2-local', NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_user_params VALUES (4, 'T', 'test', 'oidc_user_field', 'preferred_username', NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_user_params VALUES (4, 'T', 'test', 'oidc_token_issuer', 'http://keycloak:8080/auth/realms/master', NOW(), NOW(), 'i2b2', 'A');

    INSERT INTO pm_project_user_roles VALUES ('Demo', 'test', 'MANAGER', NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_project_user_roles VALUES ('Demo', 'test', 'USER', NOW(), NOW(), 'i2b2', 'A');
    INSERT INTO pm_project_user_roles VALUES ('Demo', 'test', 'DATA_OBFSC', NOW(), NOW(), 'i2b2', 'A');
EOSQL
