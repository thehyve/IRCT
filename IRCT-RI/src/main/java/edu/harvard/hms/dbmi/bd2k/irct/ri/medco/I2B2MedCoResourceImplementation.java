package edu.harvard.hms.dbmi.bd2k.irct.ri.medco;

import edu.harvard.hms.dbmi.bd2k.irct.exception.ResourceInterfaceException;
import edu.harvard.hms.dbmi.bd2k.irct.model.ontology.Entity;
import edu.harvard.hms.dbmi.bd2k.irct.model.ontology.OntologyRelationship;
import edu.harvard.hms.dbmi.bd2k.irct.model.query.Query;
import edu.harvard.hms.dbmi.bd2k.irct.model.resource.PrimitiveDataType;
import edu.harvard.hms.dbmi.bd2k.irct.model.resource.implementation.PathResourceImplementationInterface;
import edu.harvard.hms.dbmi.bd2k.irct.model.resource.implementation.QueryResourceImplementationInterface;
import edu.harvard.hms.dbmi.bd2k.irct.model.result.Result;
import edu.harvard.hms.dbmi.bd2k.irct.model.result.ResultStatus;
import edu.harvard.hms.dbmi.bd2k.irct.model.result.exception.PersistableException;
import edu.harvard.hms.dbmi.bd2k.irct.model.result.exception.ResultSetException;
import edu.harvard.hms.dbmi.bd2k.irct.model.result.tabular.Column;
import edu.harvard.hms.dbmi.bd2k.irct.model.result.tabular.FileResultSet;
import edu.harvard.hms.dbmi.bd2k.irct.model.security.User;
import edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2DataType;
import edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2XMLResourceImplementation;
import edu.harvard.hms.dbmi.i2b2.api.crc.CRCCell;
import edu.harvard.hms.dbmi.i2b2.api.crc.xml.psm.*;
import edu.harvard.hms.dbmi.i2b2.api.ont.ONTCell;
import edu.harvard.hms.dbmi.i2b2.api.pm.PMCell;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.HttpClient;
import org.apache.log4j.Logger;

import javax.xml.bind.JAXBException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;


public class I2B2MedCoResourceImplementation extends I2B2XMLResourceImplementation
        implements QueryResourceImplementationInterface, PathResourceImplementationInterface {

    Logger logger = Logger.getLogger(this.getClass());

    /**
     * URLs of the MedCo cells are encoded as a list in the resourceURL parameter using the following separator.
     */
    public static final String SEPARATOR = ",";
    protected List<String> medcoCellsURL;
    protected List<String> domains;

    public static final String MEDCO_ENC_ONT = "ENC_ID";

    public static final int THREAD_TIMEOUT_MS = 30 * 60 * 1000;

    /**
     * I2b2 instance that should serve the ontology requests.
     */

    public I2B2MedCoResourceImplementation() {
        super();
        this.medcoCellsURL = new ArrayList<>();
        this.domains = new ArrayList<>();
    }

    @Override
    public void setup(Map<String, String> parameters) throws ResourceInterfaceException {
        super.setup(parameters);
        this.medcoCellsURL.addAll(Arrays.asList(this.resourceURL.split(SEPARATOR)));
        this.domains.addAll(Arrays.asList(this.domain.split(SEPARATOR)));
        for (int i = 0 ; i < this.medcoCellsURL.size() ; i++) {
            logger.info("MedCo cell " + i + " set: " + this.medcoCellsURL.get(i) + " (" + this.domains.get(i) + ")");
        }
        // first entry used for ontology querying
    }

    /**
     * Same as the i2b2 implementation, but uses a specific URL (ontologyURL) for the MedCo ontology.
     * Also embed in the response the encrypted ID if relevant, and set the appropriate data type.
     *
     * @param path
     *            Path
     * @param relationship
     *            Relationships
     * @param user
     * @return
     * @throws ResourceInterfaceException
     */
    @Override
    public List<Entity> getPathRelationship(Entity path, OntologyRelationship relationship, User user) throws ResourceInterfaceException {
        List<Entity> returnEntities = super.getPathRelationship(path, relationship, user);
        for (Entity entity: returnEntities) {
            if (entity.getOntology().equals(MEDCO_ENC_ONT)) {
                entity.setDataType(I2B2MedCoDataType.fromI2B2DataType((I2B2DataType) entity.getDataType()));
            }
        }
        return returnEntities;
    }

    @Override
    protected ONTCell createOntCell(String projectId, String userName, String jwt) throws JAXBException {
        if (this.useProxy) {
            ontCell.setupConnection(this.medcoCellsURL.get(0), this.domains.get(0), "", "", projectId, this.useProxy,
                    this.proxyURL + "/OntologyService");
        } else {
            ontCell.setupConnection(this.medcoCellsURL.get(0) + "OntologyService/", this.domains.get(0), this.useJWT ? userName : this.userName, this.useJWT ? jwt : this.password,
                    projectId, false, null);
        }
        return ontCell;
    }

    protected CRCCell createMedCoCell(int resourceURLIdx, String projectId, String userName, String jwt) {
        CRCCell crcCell = new CRCCell();
        if (this.useProxy) {
            crcCell.setupConnection(this.medcoCellsURL.get(resourceURLIdx), this.domains.get(resourceURLIdx), userName,
                    "", projectId, this.useProxy, this.proxyURL + "/MedCoQueryService");
        } else {
            crcCell.setupConnection(this.medcoCellsURL.get(resourceURLIdx) + "MedCoQueryService/", this.domains.get(resourceURLIdx),
                    this.useJWT ? userName : this.userName, this.useJWT ? jwt : this.password, projectId, false, null);
        }
        return crcCell;
    }

    protected PMCell createPMCell(String userName, String jwt) throws JAXBException {
        if (this.useProxy) {
            pmCell.setupConnection(this.medcoCellsURL.get(0), this.domains.get(0), "", "",
                    "", this.useProxy, this.proxyURL + "/PMService");
        } else {
            pmCell.setupConnection(this.medcoCellsURL.get(0) + "PMService/", this.domains.get(0),
                    this.useJWT ? userName : this.userName, this.useJWT ? jwt : this.password, "", false, null);
        }
        return pmCell;
    }

    /**
     * Run MedCo query by broadcasting the incoming query in threads.
     *
     * @param user
     * @param query
     * @param result Results
     * @return
     * @throws ResourceInterfaceException
     */
    @Override
    public Result runQuery(final User user, final Query query, final Result result) throws ResourceInterfaceException {

        // generate i2b2 query and get project id
        final ArrayList<PanelType> panels = new ArrayList<PanelType>();
        String projectId = "";

        try {
            projectId = generatePanelsAndExtractProjectId(panels, query);
        } catch (Exception e) {
            result.setResultStatus(ResultStatus.ERROR);
            result.setMessage("runQuery() Exception:"+e.getMessage());
            return result;
        }

        // hackish workaround: the encrypted value in base64 just got its '/' turned into '\' -> reverse that
        // todo: use base64URL in unlynx (server + loader + client js)
        for (PanelType panel: panels) {
            for (ItemType item: panel.getItem()) {
                String prefix = "\\\\ENCRYPTED_KEY\\";
                if (item.getItemKey().startsWith(prefix)) {
                    String encVal = item.getItemKey().substring(prefix.length());
                    item.setItemKey(prefix + encVal.replace('\\', '/'));
                }
            }
        }

        final ResultOutputOptionListType roolt = new ResultOutputOptionListType();
        ResultOutputOptionType root = new ResultOutputOptionType();
        root.setPriorityIndex(10);
        root.setName("PATIENT_COUNT_XML");
        roolt.getResultOutput().add(root);

        // set result metadata
        result.getMetaData().putAll(query.getMetaData());
        result.getMetaData().put("only_count", "");
        result.getMetaData().put("projectId", projectId);

        // prepare result data
        final FileResultSet frs = (FileResultSet) result.getData();
        try {
            for (int i = 0; i < this.medcoCellsURL.size(); i++) {
                frs.appendColumn(new Column("medco_results_" + i, PrimitiveDataType.STRING));
            }
            frs.appendRow();
        } catch (ResultSetException | PersistableException e) {
            result.setResultStatus(ResultStatus.ERROR);
            result.setMessage("runQuery() Exception:"+e.getMessage());
            return result;
        }

        // create query threads
        Thread[] queryThreads = new Thread[this.medcoCellsURL.size()];
        final CountDownLatch latch = new CountDownLatch(this.medcoCellsURL.size());
        final String[] resourceActionIds = new String[this.medcoCellsURL.size()];
        final HttpClient client = createClient(user);
        final String queryName = "IRCT_MedCo_query_" + result.getId() + "_" + System.currentTimeMillis();

        for (int i = 0; i < this.medcoCellsURL.size() ; i++) {
            final int fI = i;
            final String fProjectId = projectId;

            queryThreads[i] = new Thread() {
                @Override
                public void run() {

                    try {
                        // run the query
                        logger.debug("MedCo thread " + fI + ": creating cell client");
                        CRCCell crcCell = createMedCoCell(fI, fProjectId, user.getName(), user.getToken());
                        MasterInstanceResultResponseType mirrt = crcCell.runQueryInstanceFromQueryDefinition(client, null, null,
                                queryName, null, "ANY", 0, roolt, panels.toArray(new PanelType[0]));

                        // extract the results
                        String medcoJsonResult = mirrt.getQueryResultInstance().get(0).getDescription();
                        String resultId = mirrt.getQueryResultInstance().get(0).getResultInstanceId();
                        String queryId = mirrt.getQueryResultInstance().get(0).getQueryInstanceId();
                        resourceActionIds[fI] = fProjectId + "|" + queryId + "|" + resultId;

                        // todo: this should be done in a cleaner way
                        String encodedResults = Base64.encodeBase64String(medcoJsonResult.getBytes(StandardCharsets.US_ASCII));
                        frs.updateString("medco_results_" + fI, encodedResults);

                    } catch (Exception e) {
                        logger.error(getType()+".runQuery() "+e.getMessage()+" "+e);
                        result.setResultStatus(ResultStatus.ERROR);
                        result.setMessage(getType()+".runQuery() Exception: "+e.getMessage());
                    }

                    latch.countDown();
                }
            };
        }
        result.setResultStatus(ResultStatus.CREATED);

        // run them
        for (Thread queryThread : queryThreads) {
            queryThread.start();
        }
        result.setResultStatus(ResultStatus.RUNNING);

        // wait for completion
        try {
            if (!latch.await(THREAD_TIMEOUT_MS, TimeUnit.MILLISECONDS)) {
                throw new TimeoutException("Timeout while waiting result completion.");
            }
        } catch (InterruptedException | TimeoutException e) {
            result.setResultStatus(ResultStatus.ERROR);
            result.setMessage("runQuery() Exception:"+e.getMessage());
            return result;
        }

        // extract results if no error happened
        if (!result.getResultStatus().equals(ResultStatus.ERROR)) {
            result.setResourceActionId(StringUtils.join(resourceActionIds, SEPARATOR));
            result.setResultStatus(ResultStatus.COMPLETE);
            result.setMessage("MedCo query finished.");
        }

        return result;
    }

    @Override
    public Result getResults(final User user, final Result result) throws ResourceInterfaceException {
        return result;
    }

    @Override
    public String getType() {
        return "i2b2MedCoXML";
    }
}
