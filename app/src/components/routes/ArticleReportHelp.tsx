import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

export function ArticleReportHelp() {
  return (
    <section
      className={clsx(
        "tw-prose tw-max-w-none tw-p-4",
        "print:tw-p-0",
        "[&_dd_p:first-of-type]:tw-mt-0 [&_dd_p]:tw-mb-0",
      )}
    >
      <SectionHeading>Article Summary Report Help</SectionHeading>

      <p>
        Access the Article Summary Report by conducting a Guided Technology
        Search or Article Search and clicking on the hyperlinked article Title.
        The Article Summary Report provides comprehensive information captured
        in IWTT for each article. It provides additional detail and context for
        the information presented in the Guided Technology Search and Article
        Search. For complete information, EPA recommends referring to the
        primary data source.
      </p>

      <p>
        Information in the report is organized into three sections: Key
        Information, Summary, and Treatment System. The Treatment System section
        repeats for each treatment train discussed in an article. Collapse or
        expand each section by clicking on the header.
      </p>

      <p>
        Note that some fields in IWTT may not be populated for every article, if
        the field was not available in the original data source. See the data
        element descriptions below and{" "}
        <Link to="/about#Quality" target="_blank" rel="noopener noreferrer">
          IWTT Data Quality
        </Link>{" "}
        for more information on data completeness. For example, EPA has found
        that the majority of articles from industry publications and conferences
        do not describe the analytical methods used to measure pollutant
        concentrations. However, the detection limits are consistently provided
        when measured concentrations are reported at or below detection.
      </p>

      <p>
        Descriptions of each data element are provided below, organized by
        section.
      </p>

      <ul>
        <li>
          <a href="#KeyInformation">Key Information</a>
        </li>

        <li>
          <a href="#Summary">Summary</a>
        </li>

        <li>
          <a href="#TreatmentSystem">Treatment System</a>

          <ul>
            <li>
              <a href="#Parameter">Parameter Removal Information</a>
            </li>
          </ul>
        </li>
      </ul>

      <h3 id="KeyInformation">Key Information</h3>

      <p>
        This section provides citation and summary information about the
        article.
      </p>

      <dl>
        <dt>Title</dt>

        <dd>
          <p>The title of the article.</p>
        </dd>

        <dt>Authors</dt>

        <dd>
          <p>
            The name of the person(s) who wrote the article, listed in the order
            presented in the data source.
          </p>
        </dd>

        <dt>Main Author Affiliation</dt>

        <dd>
          <p>The affiliation of the primary author of the article.</p>
        </dd>

        <dt>Motivation Category</dt>

        <dd>
          <p>
            The general category or categories determined and assigned to each
            article based on the motivation described in each data source. The
            motivation categories are capacity increase, cost savings, effluent
            limit, environmental impairment, material recovery, water reuse, and
            zero liquid discharge.
          </p>
        </dd>

        <dt>Motivation</dt>

        <dd>
          <p>
            A summary written by EPA describing the motivation for evaluating
            the treatment system(s).
          </p>
        </dd>

        <dt>Journal/Publisher/Conference</dt>

        <dd>
          <p>The publication source of the article.</p>
        </dd>

        <dt>Document Type</dt>

        <dd>
          <p>
            A classification determined by EPA based on the publication source
            of the article. The types of articles reviewed by EPA are described
            in the{" "}
            <Link to="/about#Scope" target="_blank" rel="noopener noreferrer">
              Scope
            </Link>{" "}
            section of the About IWTT page. The Document Types are conference
            proceeding, government report, industry publication, and
            peer-reviewed journal.
          </p>
        </dd>

        <dt>Year</dt>

        <dd>
          <p>The year in which the article was published.</p>
        </dd>

        <dt>Industry</dt>

        <dd>
          <p>
            The{" "}
            <Link to="/glossary#PSC" target="_blank" rel="noopener noreferrer">
              industrial category
            </Link>{" "}
            or categories associated with the treatment systems described in the
            article.
          </p>
        </dd>

        <dt>Number of Treatment Systems</dt>

        <dd>
          <p>
            The number of pilot- or full-scale treatment systems described in
            the article.
          </p>
        </dd>

        <dt>Scale</dt>

        <dd>
          <p>
            The{" "}
            <Link
              to="/glossary#Scale"
              target="_blank"
              rel="noopener noreferrer"
            >
              scale
            </Link>{" "}
            of treatment system(s) described in the treatment system report
            section(s) below (e.g., pilot, full).
          </p>
        </dd>

        <dt>Key Parameters</dt>

        <dd>
          <p>
            The primary pollutants of interest or pollutants targeted for
            removal in the article, as summarized by EPA.
          </p>
        </dd>
      </dl>

      <h3 id="Summary">Summary</h3>

      <p>This section provides key summaries of the article.</p>

      <dl>
        <dt>Abstract</dt>

        <dd>
          <p>
            The abstract from each article, which provides a concise overview of
            the document.
          </p>
        </dd>

        <dt>Key Findings</dt>

        <dd>
          <p>
            The main conclusions of each article (e.g., the treatment system(s)
            used and parameter removal performance, if provided), as summarized
            by EPA.
          </p>
        </dd>
      </dl>

      <h3 id="TreatmentSystem">Treatment System</h3>

      <p>
        This section provides treatment performance data from the article. This
        section repeats for each treatment system described in the article.
      </p>

      <dl>
        <dt>Point Source Category</dt>

        <dd>
          <p>
            The{" "}
            <Link to="/glossary#PSC" target="_blank" rel="noopener noreferrer">
              industrial category
            </Link>{" "}
            that the wastewater data originated from.
          </p>
        </dd>

        <dt>SIC</dt>

        <dd>
          <p>
            The{" "}
            <Link to="/glossary#SIC" target="_blank" rel="noopener noreferrer">
              SIC code
            </Link>{" "}
            and description for the industry assigned by EPA to the treatment
            system based on the description of industrial activities in each
            data source.
          </p>
        </dd>

        <dt>NAICS</dt>

        <dd>
          <p>
            The{" "}
            <Link
              to="/glossary#NAICS"
              target="_blank"
              rel="noopener noreferrer"
            >
              NAICS code
            </Link>{" "}
            and description for the industry assigned by EPA to the treatment
            system based on the description of industrial activities in each
            data source.
          </p>
        </dd>

        <dt>Wastewater Discharge Type</dt>

        <dd>
          <p>
            When available from the data source, indicates either direct
            (discharge to a surface water) or indirect (transfer to a{" "}
            <Link to="/glossary#POTW" target="_blank" rel="noopener noreferrer">
              POTW
            </Link>
            ).
          </p>
        </dd>

        <dt>Scale</dt>

        <dd>
          <p>
            The{" "}
            <Link
              to="/glossary#Scale"
              target="_blank"
              rel="noopener noreferrer"
            >
              scale
            </Link>{" "}
            (i.e., pilot, full) of treatment system described in the article.
          </p>
        </dd>

        <dt>Treated Effluent Destination</dt>

        <dd>
          <p>
            The reported destination. Destinations include discharged (either
            direct or indirect), recycled/reused, or unknown.
          </p>
        </dd>

        <dt>Treatment Train</dt>

        <dd>
          <p>
            The description, code, and order of treatment units in the
            wastewater treatment system. EPA classified{" "}
            <Link
              to="/treatment-technologies"
              target="_blank"
              rel="noopener noreferrer"
            >
              Treatment Technologies
            </Link>{" "}
            in IWTT for comparative purposes.
          </p>
        </dd>

        <dt>System Description</dt>

        <dd>
          <p>
            A narrative explanation of the treatment train, as described in the
            article.
          </p>
        </dd>

        <dt>Chemical Addition</dt>

        <dd>
          <p>
            Additional information about the treatment chemicals and quantities
            used, if provided in the system description in the data source.
          </p>
        </dd>

        <dt>Other Relevant Parameters</dt>

        <dd>
          <p>
            A summary of additional treatment information, such as flow rate or
            residence time, if provided in the data source.
          </p>
        </dd>

        <dt>Manufacturer</dt>

        <dd>
          <p>
            The manufacturer of the treatment equipment, if provided in the data
            source.
          </p>
        </dd>

        <dt>Capital Cost</dt>

        <dd>
          <p>
            The upfront cost of the treatment system, if provided in the data
            source.
          </p>
        </dd>

        <dt>Operation and Maintenance (O&M) Cost</dt>

        <dd>
          <p>
            The costs associated with operating and maintain the treatment
            equipment, if provided in the data source.
          </p>
        </dd>
      </dl>

      <h4 id="Parameter">Parameter Removal Information</h4>

      <p>
        Information for each parameter monitored and reported, if provided in
        the data source. Note that not all treatment systems have associated
        parameter removal information. Detailed information for each parameter
        is displayed in collapsible sections of the treatment performance data
        table in the Treatment System section(s).
      </p>

      <dl>
        <dt>Parameter</dt>

        <dd>
          <p>
            The name of the{" "}
            <Link
              to="/glossary#Parameter"
              target="_blank"
              rel="noopener noreferrer"
            >
              parameter
            </Link>{" "}
            measured. The name is only as specific as stated in each article.
          </p>
        </dd>

        <dt>Influent</dt>

        <dd>
          <p>
            Numerical influent concentration value or quantity as reported in
            the data source. The influent data are taken before the first step
            of the treatment system, as described in the treatment train. In
            some cases, an exception is made to define influent after mechanical
            pre-treatment (MPT), since MPT does not typically alter the chemical
            make-up of the wastewater.
          </p>
        </dd>

        <dt>Effluent</dt>

        <dd>
          <p>
            Numerical effluent concentration value or quantity as reported in
            the data source. The effluent data are reported after the last step
            of treatment. The symbol “&lt;” indicates that the concentration
            value was measured at or below the detection limit.
          </p>
        </dd>

        <dt>Percent (%) Removal</dt>

        <dd>
          <p>
            The amount of parameter removed by the treatment system, as
            calculated in IWTT using the reported influent and effluent values
            reported, or as reported in the data source. The symbol “&gt;”
            indicates that the calculated value included at least one effluent
            concentration measured at or below the detection limit.
          </p>
        </dd>

        <dt>Analytical Method</dt>

        <dd>
          <p>
            The method used for measuring the concentration values, if provided
            in the data source.
          </p>
        </dd>

        <dt>Statistical Basis</dt>

        <dd>
          <p>
            The statistical measurement of the influent and effluent values. EPA
            selects the reported measurement basis from the data source based on
            the following priority: average, median, mode, maximum, minimum,
            individual. If a statistical basis is not stated in the data source,
            this field displays “unspecified.”
          </p>
        </dd>

        <dt>Detection Limits</dt>

        <dd>
          <p>
            The detection limit of the equipment used to measure the
            concentration values, if provided in the data source. If an influent
            value was reported as less than or less than or equal to a specific
            value, the influent detection limit is displayed.
          </p>
        </dd>

        <dt>Effluent Limit/Treatment Goal/Standard</dt>

        <dd>
          <p>
            The targeted treatment benchmark description and value for the
            parameter for the treatment system, if provided in the data source.
            This benchmark may represent a permit limit, effluent limitation,
            treatment or reuse goal, water quality standard, or other benchmark.
            Up to three benchmarks may be included in IWTT.
          </p>
        </dd>
      </dl>
    </section>
  );
}
