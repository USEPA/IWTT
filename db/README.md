## Prerequisites:

* Oracle Database, 19c or above, any edition.
* Oracle REST Data Services 23.x or above middleware server.
* Oracle REST Data Services configured and authenticated to Database. 
* Database schemas named IWTT and IWTT_REST.
* USEPA IWTT database loaded into the IWTT schema.
* Activation of Oracle REST Data Services for the IWTT_REST schema.

## Logic Installation:

1) Deploy all provided code into the relevant schemas.
2) As the IWTT_REST user, execute the **IWTT_ORDS.ORDS_ALL()** stored procedure.

In addition to deploying ORDS services, three configuration tables will be created in the schema:

* **REF_ORIGINS** - add one or more rows matching services to one or more comma-delimited lists of specific origins.  ORDS does not itself support open wildcard access and must be provided with known origins or shunted through a reverse proxy or API gateway that inserts a wildcard header.  To match all services to a single list of orgins, use an asterick.

* **REF_HEADER_CHECK** - optionally add one or more rows defining header keys that must match to allow access to IWTT services.  Used to restrict access to controlled API gateways.

* **REF_ENV** - optionally add a row to define the database name and mark the ORDS installation as staging or production.  When populated can return debugging information in staging and other non-production environments. 

## Additional Resources:

* [Oracle Database](https://docs.oracle.com/en/database/oracle/oracle-database/19/ntdbi/index.html)
* [Oracle REST Data Services](https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/23.2/ordig/installing-REST-data-services.html)
* [Oracle PLSQL](https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/index.html)
