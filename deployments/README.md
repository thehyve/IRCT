# Deployment

```bash
docker-compose up
```

When the `postgresql-server` container is being created, the database will be initialized with its default data.
It might take some time, wait for its completion before starting to build a WAR.

# Build the WARs
While WildFly is running, execute this command to trigger the build of a component:

```bash
docker exec -it deployments_wildfly-server_1 build-war.sh COMPONENT
```

With `COMPONENT` being one of the following:
* `i2b2`: full i2b2 stack (Axis2 & all the cells)
* `irct`: IRCT (implementation of PIC-SURE API)
* `transmart-17.1`: tranSMART 17.1


# Web Interfaces

## lighttpd services
* phpPgAdmin: `http://localhost/phppgadmin`, credentials: `postgres`/`postgres`
* i2b2 webclient: `http://localhost/i2b2-client`, credentials: `demo`/`demouser`
* i2b2 admin tool:`http://localhost/i2b2-admin`, credentials: `i2b2`/`demouser`

## WildFly deployed services
* tranSMARTApp: `http://localhost:8080/tranSMART-17.1`
* WildFly Admin: `http://localhost:9990`, credentials: `admin`/`admin`
* Axis2 Admin: `http://localhost:8080/i2b2`, credentials: `admin`/`axis2`

todo: credentials of db users: postgres / postgres ; keycloak / keycloak
todo: about keycloak and its configuration
