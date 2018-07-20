package edu.harvard.hms.dbmi.bd2k.irct.ri.medco;

import edu.harvard.hms.dbmi.bd2k.irct.exception.ResourceInterfaceException;
import edu.harvard.hms.dbmi.bd2k.irct.model.ontology.DataType;
import edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

public enum I2B2MedCoDataType implements DataType {
	ENC_CONCEPT {
		@Override
		public String getName() {
			return "enc_concept";
		}

		@Override
		public String getDescription() {
			return "Encrypted Concept";
		}
	},
	ENC_CONCEPT_NUMERIC {
		@Override
		public String getName() {
			return "enc_concept_numeric";
		}

		@Override
		public String getDescription() {
			return "Encrypted Concept Numeric Value";
		}
	},
	ENC_CONCEPT_ENUM {
		@Override
		public String getName() {
			return "enc_concept_enum";
		}

		@Override
		public String getDescription() {
			return "Encrypted Concept Enumerated Value";
		}
	},
	ENC_CONCEPT_STRING {
		@Override
		public String getName() {
			return "enc_concept_string";
		}

		@Override
		public String getDescription() {
			return "Encrypted Concept String Value";
		}
	};

	public static I2B2MedCoDataType fromI2B2DataType(I2B2DataType type) {
	    switch (type) {
            case CONCEPT:
                return ENC_CONCEPT;
            case CONCEPT_ENUM:
                return ENC_CONCEPT_ENUM;
            case CONCEPT_STRING:
                return ENC_CONCEPT_STRING;
            case CONCEPT_NUMERIC:
                return ENC_CONCEPT_NUMERIC;
            default:
                throw new ResourceInterfaceException("This should not happen.");
        }
    }

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
