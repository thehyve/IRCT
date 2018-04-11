package edu.harvard.hms.dbmi.bd2k.irct.cl.util;

import org.hibernate.boot.model.naming.Identifier;
import org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl;
import org.hibernate.engine.jdbc.env.spi.JdbcEnvironment;


/**
 * Physical naming strategy that adds a prefix to the tables.
 */
public class HibernatePrefixNamingStrategy extends PhysicalNamingStrategyStandardImpl {
  private static final String TABLE_PREFIX = "IRCT_";

	@Override
	public Identifier toPhysicalTableName(Identifier name, JdbcEnvironment jdbcEnvironment) {
		return jdbcEnvironment.getIdentifierHelper().toIdentifier(
      TABLE_PREFIX + name.getText(),
      name.isQuoted()
    );
	}
}
