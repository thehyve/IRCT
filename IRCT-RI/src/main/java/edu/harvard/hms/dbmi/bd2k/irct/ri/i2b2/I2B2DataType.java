package edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2;

import edu.harvard.hms.dbmi.bd2k.irct.model.ontology.DataType;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

public enum I2B2DataType implements DataType {
	CONCEPT {
		@Override
		public String getName() {
			return "concept";
		}

		@Override
		public String getDescription() {
			return "Concept";
		}
	},
	CONCEPT_NUMERIC {
		@Override
		public String getName() {
			return "concept_numeric";
		}

		@Override
		public String getDescription() {
			return "Concept Numeric Value";
		}
	},
	CONCEPT_ENUM {
		@Override
		public String getName() {
			return "concept_enum";
		}

		@Override
		public String getDescription() {
			return "Concept Enumerated Value";
		}
	},
	CONCEPT_STRING {
		@Override
		public String getName() {
			return "concept_string";
		}

		@Override
		public String getDescription() {
			return "Concept String Value";
		}
	};

	@Override
	public byte[] toBytes(Object value) {
		if (value == null) {
			return new byte[] { (byte) Character.MIN_VALUE };
		}

		String data = ((String) value).trim();
		return (data).getBytes(StandardCharsets.UTF_16);
	}

	@Override
	public Object fromBytes(byte[] bytes) {
		if ((bytes.length == 1)
				&& (bytes[0] == Character.reverseBytes(Character.MIN_VALUE))) {
			return null;
		}
		return new String(bytes, StandardCharsets.UTF_16).trim();
	}

	@Override
	public Pattern getPattern() {
		return Pattern.compile("^.*$", Pattern.CASE_INSENSITIVE);
	}

	@Override
	public DataType typeOf() {
		return this;
	}

	@Override
	public byte[] fromString(String value) {
		return value.getBytes();
	}

	@Override
	public String toString(byte[] bytes) {
		return new String(bytes);
	}

	@Override
	public boolean validate(String value) {
		return getPattern().matcher(value).matches();
	}

	@Override
	public JsonObject toJson() {
		JsonObjectBuilder build = Json.createObjectBuilder();
		build.add("name", getName());
		build.add("pattern", getPattern().toString());
		build.add("description", getDescription());
		if (typeOf() != null) {
			build.add("typeof", typeOf().getName());
		}
		return build.build();
	}
}
