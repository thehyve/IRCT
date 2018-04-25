#!/bin/bash
set -e

cat > "$I2B2_SRC_DIR/edu.harvard.i2b2.pm/etc/jboss/pm-ds.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<datasources xmlns="http://www.jboss.org/ironjacamar/schema">
    <datasource jta="false" jndi-name="java:/PMBootStrapDS"
            pool-name="PMBootStrapDS" enabled="true" use-ccm="false">
                <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
                <driver-class>org.postgresql.Driver</driver-class>
                <driver>postgresql-9.4.1209.jar</driver>
                <security>
                        <user-name>i2b2pm</user-name>
                        <password>$I2B2_DB_PASSWORD</password>
                </security>
                <validation>
                        <validate-on-match>false</validate-on-match>
                        <background-validation>false</background-validation>
                </validation>
                <statement>
                        <share-prepared-statements>false</share-prepared-statements>
                </statement>
        </datasource>
</datasources>
EOL

cat > "$I2B2_SRC_DIR/edu.harvard.i2b2.ontology/etc/jboss/ont-ds.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<datasources xmlns="http://www.jboss.org/ironjacamar/schema">
    <datasource jta="false" jndi-name="java:/OntologyBootStrapDS"
                pool-name="OntologyBootStrapDS" enabled="true" use-ccm="false">
        <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
        <driver-class>org.postgresql.Driver</driver-class>
        <driver>postgresql-9.4.1209.jar</driver>
        <security>
            <user-name>i2b2hive</user-name>
            <password>$I2B2_DB_PASSWORD</password>
        </security>
        <validation>
            <validate-on-match>false</validate-on-match>
            <background-validation>false</background-validation>
        </validation>
        <statement>
            <share-prepared-statements>false</share-prepared-statements>
        </statement>
    </datasource>

    <datasource jta="false" jndi-name="java:/OntologyDemoDS"
                pool-name="OntologyDemoDS" enabled="true" use-ccm="false">
        <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
        <driver-class>org.postgresql.Driver</driver-class>
        <driver>postgresql-9.4.1209.jar</driver>
        <security>
            <user-name>i2b2metadata_i2b2</user-name>
            <password>$I2B2_DB_PASSWORD</password>
        </security>
        <validation>
            <validate-on-match>false</validate-on-match>
            <background-validation>false</background-validation>
        </validation>
        <statement>
            <share-prepared-statements>false</share-prepared-statements>
        </statement>
    </datasource>
</datasources>

EOL

cat > "$I2B2_SRC_DIR/edu.harvard.i2b2.crc/etc/jboss/crc-ds.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<datasources xmlns="http://www.jboss.org/ironjacamar/schema">
        <datasource jta="false" jndi-name="java:/CRCBootStrapDS"
                pool-name="CRCBootStrapDS" enabled="true" use-ccm="false">
                <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
                <driver-class>org.postgresql.Driver</driver-class>
                <driver>postgresql-9.4.1209.jar</driver>
                <security>
                        <user-name>i2b2hive</user-name>
                        <password>$I2B2_DB_PASSWORD</password>
                </security>
                <validation>
                        <validate-on-match>false</validate-on-match>
                        <background-validation>false</background-validation>
                </validation>
                <statement>
                        <share-prepared-statements>false</share-prepared-statements>
                </statement>
        </datasource>

        <datasource jta="false" jndi-name="java:/QueryToolDemoDS"
                pool-name="QueryToolDemoDS" enabled="true" use-ccm="false">
                <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
                <driver-class>org.postgresql.Driver</driver-class>
                <driver>postgresql-9.4.1209.jar</driver>
                <security>
                        <user-name>i2b2demodata_i2b2</user-name>
                        <password>$I2B2_DB_PASSWORD</password>
                </security>
                <validation>
                        <validate-on-match>false</validate-on-match>
                        <background-validation>false</background-validation>
                </validation>
                <statement>
                        <share-prepared-statements>false</share-prepared-statements>
                </statement>
        </datasource>
</datasources>
EOL

cat > "$I2B2_SRC_DIR/edu.harvard.i2b2.workplace/etc/jboss/work-ds.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<datasources xmlns="http://www.jboss.org/ironjacamar/schema">
    <datasource jta="false" jndi-name="java:/WorkplaceBootStrapDS"
            pool-name="WorkplaceBootStrapDS" enabled="true" use-ccm="false">
            <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
            <driver-class>org.postgresql.Driver</driver-class>
            <driver>postgresql-9.4.1209.jar</driver>
            <security>
                    <user-name>i2b2hive</user-name>
                    <password>$I2B2_DB_PASSWORD</password>
            </security>
            <validation>
                    <validate-on-match>false</validate-on-match>
                    <background-validation>false</background-validation>
            </validation>
            <statement>
                    <share-prepared-statements>false</share-prepared-statements>
            </statement>
    </datasource>

    <datasource jta="false" jndi-name="java:/WorkplaceDemoDS"
            pool-name="WorkplaceDemoDS" enabled="true" use-ccm="false">
            <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
            <driver-class>org.postgresql.Driver</driver-class>
            <driver>postgresql-9.4.1209.jar</driver>
            <security>
                    <user-name>i2b2workdata</user-name>
                    <password>$I2B2_DB_PASSWORD</password>
            </security>
            <validation>
                    <validate-on-match>false</validate-on-match>
                    <background-validation>false</background-validation>
            </validation>
            <statement>
                    <share-prepared-statements>false</share-prepared-statements>
            </statement>
    </datasource>
</datasources>
EOL

cat > "$I2B2_SRC_DIR/edu.harvard.i2b2.im/etc/jboss/im-ds.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<datasources xmlns="http://www.jboss.org/ironjacamar/schema">
        <datasource jta="false" jndi-name="java:/IMBootStrapDS"
                pool-name="IMBootStrapDS" enabled="true" use-ccm="false">
                <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
                <driver-class>org.postgresql.Driver</driver-class>
                <driver>postgresql-9.4.1209.jar</driver>
                <security>
                        <user-name>i2b2hive</user-name>
                        <password>$I2B2_DB_PASSWORD</password>
                </security>
                <validation>
                        <validate-on-match>false</validate-on-match>
                        <background-validation>false</background-validation>
                </validation>
                <statement>
                        <share-prepared-statements>false</share-prepared-statements>
                </statement>
        </datasource>

        <datasource jta="false" jndi-name="java:/IMDemoDS"
                pool-name="IMDemoDS" enabled="true" use-ccm="false">
                <connection-url>jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME</connection-url>
                <driver-class>org.postgresql.Driver</driver-class>
                <driver>postgresql-9.4.1209.jar</driver>
                <security>
                        <user-name>i2b2imdata</user-name>
                        <password>$I2B2_DB_PASSWORD</password>
                </security>
                <validation>
                        <validate-on-match>false</validate-on-match>
                        <background-validation>false</background-validation>
                </validation>
                <statement>
                        <share-prepared-statements>false</share-prepared-statements>
                </statement>
        </datasource>
</datasources>
EOL

cat > "$I2B2_SRC_DIR/edu.harvard.i2b2.crc/etc/spring/CRCLoaderApplicationContext.xml" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">
<beans>
	<bean id="jaxbPackage"
		class="org.springframework.beans.factory.config.ListFactoryBean">
		<property name="sourceList">
			<list>
				<value>edu.harvard.i2b2.crc.loader.datavo.loader.query</value>
				<value>edu.harvard.i2b2.crc.datavo.pdo</value>
				<value>edu.harvard.i2b2.crc.datavo.i2b2message</value>
				<value>edu.harvard.i2b2.crc.datavo.pm</value>
				<value>edu.harvard.i2b2.crc.loader.datavo.fr</value>
			</list>
		</property>
	</bean>

	<bean id="appType" class="edu.harvard.i2b2.crc.datavo.i2b2message.ApplicationType">
		<property name="applicationName" value="CRC Cell" />
		<property name="applicationVersion" value="1.7" />
	</bean>



	<bean id="message_header"
		class="edu.harvard.i2b2.crc.datavo.i2b2message.MessageHeaderType">
		<property name="sendingApplication" ref="appType" />
	</bean>

	<bean id="CRCBootstrapDS" class="org.apache.commons.dbcp.BasicDataSource"
		destroy-method="close">
		<property name="driverClassName" value="org.postgresql.Driver" />
		<property name="url" value="jdbc:postgresql://postgresql-server:5432/$I2B2_DEMO_DB_NAME" />
		<property name="username" value="i2b2hive" />
		<property name="password" value="$I2B2_DB_PASSWORD" />
	</bean>
</beans>
EOL
