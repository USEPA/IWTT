import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

export function About() {
  return (
    <section className={clsx("tw-prose tw-max-w-none tw-p-4", "print:tw-p-0")}>
      <SectionHeading>About IWTT</SectionHeading>

      <div
        className={clsx(
          "box box--related-info",
          "tw-mt-3",
          "sm:tw-float-right sm:tw-mb-6 sm:tw-ml-6 sm:tw-w-[calc(50%-0.75rem)]",
        )}
      >
        <div className="box__title">Article Submission</div>
        <div className="box__content">
          <p>
            For information about providing an article for EPA’s consideration
            to be included in IWTT, see{" "}
            <Link to="/submit-article">Submit an Article to IWTT</Link>.
          </p>
        </div>
      </div>

      <p>
        The Industrial Wastewater Treatment Technology Database (IWTT) captures
        industrial wastewater treatment technology performance data identified
        from data sources, including peer-reviewed journals, conference
        proceedings, and government reports.
      </p>

      <p>EPA developed IWTT:</p>

      <ul>
        <li>
          to help inform its annual reviews of Industrial Effluent Guidelines;
          and
        </li>

        <li>
          to identify industrial categories or pollutants that warrant further
          review, particularly based on improvements in wastewater treatment.
        </li>
      </ul>

      <p>
        IWTT supports the Agency’s goal of meeting Clean Water Act (CWA)
        sections 304(b) and 304(m) guidelines to prioritize industrial
        categories for potential revision through detailed studies or
        rulemakings and to publish an Effluent Guidelines Program Plan on a
        biannual basis. In the Effluent Guidelines Planning Process, IWTT
        performance data is used as a comparison to current industrial
        discharges from the{" "}
        <a
          href="https://echo.epa.gov/trends/loading-tool/water-pollution-search"
          target="_blank"
          rel="noopener noreferrer"
        >
          Water Pollutant Loading Tool
        </a>
        , supporting EPA in a screening-level review of novel technologies or
        changes to existing technologies that are available and can reduce
        pollutants to lower concentrations or even eliminate discharges. IWTT is
        also used to compare current numeric limitations and technology bases in
        the{" "}
        <a
          href="https://owapps.epa.gov/elg/"
          target="_blank"
          rel="noopener noreferrer"
        >
          ELG Database
        </a>{" "}
        with more recent pilot studies and full-scale installations for a
        particular industry, technology, and/or pollutant.
      </p>

      <p>
        EPA makes this information more broadly available to the public to share
        research and promote industrial wastewater treatment technology
        innovation.
      </p>

      <ul>
        <li>
          <a href="#History">History</a>
        </li>

        <li>
          <a href="#Scope">Scope</a>
        </li>

        <li>
          <a href="#Quality">Quality</a>
        </li>
      </ul>

      <h3 id="History">History</h3>

      <p>
        The Clean Water Act (CWA) directs EPA to promulgate Effluent Guidelines
        that reflect pollutant reductions that specific industries can achieve
        in their point source discharges by implementing available treatment and
        pollution prevention technologies. When establishing Effluent
        Guidelines, EPA considers, among other things:
      </p>

      <ul>
        <li>
          the performance and availability of the pollution control technologies
          or pollution prevention practices for an industrial category or
          subcategory; and
        </li>

        <li>
          the economic achievability of those technologies, which can include
          how affordable it would be to reduce the pollutant discharge.
        </li>
      </ul>

      <p>
        In its Final 2012 and Preliminary 2014 Effluent Guidelines Program Plans
        (79 FR 55472), EPA announced that it had initiated a review of relevant
        literature to document the performance of new and improved industrial
        wastewater treatment technologies, with plans to capture these
        performance data in a searchable database. EPA began populating IWTT in
        2013 and continues to routinely screen and collect literature sources to
        add information to the database.
      </p>

      <p>EPA created IWTT, in part, to answer the following questions:</p>

      <ul>
        <li>
          What new technologies, or changes to existing technologies, are
          specific industries using to treat their wastestreams?
        </li>

        <li>
          Are there technologies that can reduce or eliminate wastewater
          pollutants not currently regulated by Effluent Guidelines, or remove
          pollutants to a greater degree than industries currently achieve?
        </li>
      </ul>

      <p>
        EPA converted its database to this web-based platform in 2017 to allow
        EPA and the public to search the cataloged industrial wastewater
        treatment technology performance data.
      </p>

      <h3 id="Scope">Scope</h3>

      <p>
        EPA routinely screens for available data on new or improved treatment
        technology performance related to industrial wastewater from the
        following types of technical sources:
      </p>

      <ul>
        <li>
          <strong>Conference proceedings.</strong> EPA reviews conference
          proceedings from key technical conferences on wastewater including the
          Water Environment Federation’s Technical Exhibition and Conference
          (WEFTEC), the International Water Conference® (IWC), and other more
          targeted conferences. EPA also reviews additional references and
          research from associated conference presenters.
        </li>

        <li>
          <strong>Peer-reviewed journals.</strong> EPA reviews peer-reviewed
          journal articles from water and engineering-related societies and
          other organizations publishing research on innovative industrial
          wastewater treatment technologies or optimization strategies.
        </li>

        <li>
          <strong>Industry publications.</strong> EPA reviews industrial
          wastewater treatment research compiled and published by industry trade
          organizations, such as the American Petroleum Institute and the
          American Chemical Society.
        </li>

        <li>
          <strong>Other government data.</strong> EPA reviews other available
          government databases and sources, including previously compiled data
          on treatment technology performance and technical data used for
          regulation development.
        </li>
      </ul>

      <p>
        In general, information included in IWTT must meet the following
        requirements:
      </p>

      <ul>
        <li>
          Published since 2000 (new article uploads typically include
          information published within the past 10 years);
        </li>

        <li>
          Describe pilot- or full-scale systems treating industrial wastewater;
          and
        </li>

        <li>Meet data quality criteria (discussed below).</li>
      </ul>

      <p>
        IWTT captures the following industrial wastewater treatment technology
        data and information:
      </p>

      <ul>
        <li>
          Treatment system details including individual units (i.e.,
          technologies or treatment trains) included within the treatment
          system, unit order, chemical additions, and system operating
          conditions and costs;
        </li>

        <li>
          Industries (or associated industrial wastewaters) implementing or
          testing the treatment systems and specific technologies;
        </li>

        <li>
          Pollutants removed, including influent and effluent quality, and
          percent removals achieved, if available; and
        </li>

        <li>
          Specific motivations for evaluating and employing new technologies.
        </li>
      </ul>

      <h3 id="Quality">Quality</h3>

      <h4>Data Quality Criteria</h4>

      <p>
        EPA obtains full text articles identified during literature searches and
        reviews the content to determine whether the article should be included
        in IWTT.
      </p>

      <p>
        EPA selects articles for entry into the database if the treatment
        technology performance data presented meet the following quality
        criteria:
      </p>

      <ul>
        <li>
          <strong>Relevance:</strong> The data source answers IWTT key questions
          and is relevant to the industry, operation, waste stream, or pollutant
          of interest (e.g., the SIC and NAICS codes provided in the data
          source, when available, match the industry; the CAS number matches the
          CAS number for the pollutant of interest).
        </li>

        <li>
          <strong>Accuracy:</strong> EPA considers the following factors when
          evaluating the accuracy of a data source: (1) data are consistent
          throughout the document (e.g., text, tables, and figures agree), (2)
          analytical methods, detection limits, and any associated data analysis
          are described with enough detail to understand how the data were
          collected and analyzed, and (3) data are comparable to other data that
          answer the same key questions. EPA considers data and information
          contained in state and federal reports and databases, peer-reviewed
          journal articles, industry publications, and relevant conference
          proceedings to be accurate. Although industry publications and
          conference proceedings are not peer-reviewed, these resources provide
          useful information for understanding industrial processes and/or
          wastewater generated by a specified industry. They also describe the
          types of treatment systems and technologies currently under
          investigation and provide a relative indication of the treatment
          performance.
        </li>

        <li>
          <strong>Reliability:</strong> EPA considers the following factors when
          evaluating reliability of a data source: (1) data that have been
          generated by EPA and/or other governmental agencies and subject to
          data review and assessment are considered to be the most reliable, (2)
          data generated by entities with established knowledge in the topic
          area (e.g., studies conducted by industry experts, primary data
          generated by an industrial facility) are also considered by EPA to be
          reliable, and (3) data that use unknown collection and data review
          procedures are considered by EPA as less reliable. EPA will also
          evaluate existing data for reliability based on the following factors:
          <ul>
            <li>The material has been critically or independently reviewed;</li>
            <li>
              If industry supplied data, industry certified that it was accurate
              to the best of their knowledge and/or reviewed the data for
              accuracy;
            </li>
            <li>
              Scientific work is clearly written such that all assumptions and
              methodologies can be identified;
            </li>
            <li>
              Waste streams, parameters, measurement units, and detection limits
              (when appropriate) are clearly and consistently characterized;
              and,
            </li>
            <li>
              Assumptions and methodologies are consistently applied throughout
              the analysis, as reported in the source.
            </li>
          </ul>
        </li>

        <li>
          <strong>Representativeness:</strong> EPA uses the following criteria
          to evaluate whether the data and information provide a national
          perspective and are relevant to and representative of the industry to
          which the data are applied:
          <ul>
            <li>
              The data can be applied broadly to provide a national perspective
              relative to the industry or pollutant of interest (e.g., the data
              are characteristic of the industry or pollutant as a whole). While
              EPA accepts data from other countries, it rejects data if the
              industrial processes or wastestreams are not characteristic of
              U.S. based operations or the pollutant concentrations are not
              consistent with U.S. based numerical values.
            </li>
            <li>
              EPA will prioritize data sources published in the last 10 years or
              later, as they reflect the most recent industry changes.
            </li>
          </ul>
        </li>
      </ul>

      <h4>Ancillary Data</h4>

      <p>
        In addition to standard fields such as treatment technology and unit
        order, when available, IWTT captures other ancillary information about
        treatment systems and wastewater parameters. While ancillary information
        is not available in every data source, it provides further context and
        information regarding the viability and broader application of the
        technology or treatment system. For example, EPA records capital costs
        and operational and maintenance costs, if provided in the source
        material. The IWTT{" "}
        <Link
          to="/article-report-help"
          target="_blank"
          rel="noopener noreferrer"
        >
          Article Report Help
        </Link>{" "}
        page provides further detail on common data gaps in IWTT.
      </p>

      <h4>IWTT Data Entry and Review Process</h4>

      <p>
        Engineers and scientists review each data source and enter relevant
        information into an underlying database used to populate IWTT.
      </p>

      <p>
        After data entry, a quality control (QC) review and a senior technical
        review are completed. The QC reviewer confirms that all the applicable
        reference information has been accurately characterized. The QC reviewer
        confirms that all the applicable treatment system information has been
        entered accurately, including the industry classification codes (
        <Link to="/glossary#SIC" target="_blank" rel="noopener noreferrer">
          SIC
        </Link>{" "}
        and{" "}
        <Link to="/glossary#NAICS" target="_blank" rel="noopener noreferrer">
          NAICS
        </Link>{" "}
        codes), scale (pilot or full), chemical addition, costs, and selection
        criteria. The QC reviewer confirms that all the applicable performance
        data have been entered accurately, including the parameter name,
        analytical methods, detection limits, and influent and effluent
        concentrations, and/or percent removal. The senior technical reviewer, a
        senior scientist/engineer with wastewater treatment expertise, confirms
        that the treatment system description and treatment technologies within
        the system have been accurately characterized.
      </p>

      <h4>Software Development and Testing Procedures</h4>

      <p>
        EPA uses several verification methods to assure the quality of IWTT’s
        user interface. Quality objectives include specific goals related to
        functionality, accuracy, and completeness. EPA performs the following
        types of software testing following changes to the programming code:
      </p>

      <ul>
        <li>Unit testing;</li>
        <li>Integration testing;</li>
        <li>System testing;</li>
        <li>Automated data quality testing; and</li>
        <li>User acceptance testing.</li>
      </ul>

      <p>
        Software developers conduct unit testing as they code individual
        functions or blocks of code. They also confirm the following before
        releasing materials for integration testing:
      </p>

      <ul>
        <li>Functional requirements are completely fulfilled;</li>
        <li>Functionality of new code is documented; and</li>
        <li>New code does not break any existing unit tests.</li>
      </ul>

      <p>
        Internal testers perform integration testing to confirm that functions
        or blocks of code developed by software developers produce the expected
        results when combined. Integration testing is performed to find issues
        that arise when data passes between pages or areas of the tool.
      </p>

      <p>
        Internal testers then perform system testing (end-to-end testing from a
        user’s perspective) using real life scenarios. This type of testing
        checks whether the tool meets functional and non-functional design
        requirements of the system.
      </p>

      <p>
        Automated data quality testing uses web service test cases to verify
        IWTT web services for data quality. Web service test cases compare IWTT
        web query results to database queries and check for issues identified
        during prior testing. EPA conducts web service test cases using
        automated testing software. Testers manually review the automated test
        case results and investigate any data quality errors. Automated test
        cases are maintained on GitHub, a centralized, web-based EPA code
        repository, to assure version control.
      </p>

      <p>
        EPA coordinates user acceptance testing with interested/affected
        parties, collects comments, and prioritizes comments to be addressed in
        future IWTT development cycles.
      </p>
    </section>
  );
}
