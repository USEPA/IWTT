import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";
import { Table } from "@/components/Table";

export function GuidedSearchHelp() {
  return (
    <section
      className={clsx(
        "tw-prose tw-max-w-none tw-p-4",
        "print:tw-p-0",
        "[&_dd_p:first-of-type]:tw-mt-0 [&_dd_p]:tw-mb-0",
      )}
    >
      <SectionHeading>Guided Technology Search Help</SectionHeading>

      <p>
        The Guided Technology Search allows you to access pilot- and full-scale
        treatment performance data by industry, treatment technology, or
        pollutant. Use the search results to answer questions such as "What
        technologies are specific industries using to treat their wastewater?"
        and "What technologies target the removal of specific parameters?" The
        Guided Technology Search offers a step-by-step approach to exploring the
        data in IWTT.
      </p>

      <ul>
        <li>
          <a href="#SelectCriteria">Select Search Criteria</a>
        </li>

        <li>
          <a href="#ResultsHelp">Search Results</a>

          <ul>
            <li>
              <a href="#ResultsSummary">Summary of Results</a>
            </li>

            <li>
              <a href="#ResultsTable">Results Table</a>
            </li>
          </ul>
        </li>

        <li>
          <a href="#MoreDetail">More Detail – Treatment Performance</a>

          <ul>
            <li>
              <a href="#Summary">Summary Section</a>
            </li>

            <li>
              <a href="#Table">Table</a>
            </li>
          </ul>
        </li>
      </ul>

      <h3 id="SelectCriteria">Select Search Criteria</h3>

      <p>
        Select one or more values using the dropdown menu or filter available
        options by typing text directly into the text box. Individual search
        terms may be removed by selecting the “x” to the left of each term or
        all terms may be cleared by selecting the “x” on the right side of the
        box.
      </p>

      <dl>
        <dt>Industry</dt>

        <dd>
          <p>
            Filter results by one or more industry classifications associated
            with a treatment system. Industry classifications correspond to{" "}
            <Link to="/glossary#PSC" target="_blank" rel="noopener noreferrer">
              Point Source Categories (PSC)
            </Link>{" "}
            or descriptions of two-digit{" "}
            <Link to="/glossary#SIC" target="_blank" rel="noopener noreferrer">
              SIC codes
            </Link>
            . Only industrial categories with information in IWTT are included
            in this search option.
          </p>
        </dd>

        <dt>Treatment Technology</dt>

        <dd>
          <p>
            Filter results by one or more wastewater treatment technologies
            (e.g., unit processes) used to reduce the concentration or quantity
            of pollutants in the discharged wastewater. Refer to the{" "}
            <Link
              to="/treatment-technologies"
              target="_blank"
              rel="noopener noreferrer"
            >
              Treatment Technology Descriptions
            </Link>{" "}
            for the list of treatment technology classifications and
            descriptions in IWTT. Only treatment technologies with data in IWTT
            are included in this search option. In some cases, the search term
            represents a grouping of technologies into a simplified naming
            convention for the purpose of searching IWTT. For example, a search
            for the technology “Membrane Filtration” may provide results for the
            technologies “Reverse Osmosis,” “Nanofiltration,” “Forward Osmosis,”
            “Membrane Distillation,” and “Micro- and Ultra-Membrane Filtration.”{" "}
          </p>
        </dd>

        <dt>Pollutant</dt>

        <dd>
          <p>
            Filter results by one or more pollutants with treatment performance
            data (e.g., influent concentration/quantity, effluent
            concentration/quantity or percent removal) in IWTT. In some cases,
            the search term represents a grouping of{" "}
            <Link
              to="/glossary#Pollutant"
              target="_blank"
              rel="noopener noreferrer"
            >
              parameters
            </Link>{" "}
            into a simplified naming convention for the purpose of searching
            IWTT. For example, a search for the pollutant “Nitrogen” may provide
            results for the parameters “Nitrogen, total” and “Nitrogen,
            organic.”
          </p>
        </dd>
      </dl>

      <h3 id="ResultsHelp">Search Results</h3>

      <p>
        After running a search, the Summary of Results pane and the Results
        Table will load on the page below the search criteria.
      </p>

      <p>
        The <strong>View Results By</strong> buttons allow you to choose how the
        results are aggregated. Customize results table view by either industry,
        treatment technology, or pollutant (e.g., select “Industry” to view a
        list of industries meeting the search criteria). See the{" "}
        <a href="#ResultsTable">Results Table</a> section for descriptions of
        the information presented for each table view.
      </p>

      <h4 id="ResultsSummary">Summary of Results</h4>

      <p>
        This section provides a summary of the search criteria selected and
        overall counts of data meeting the search criteria. Note that this
        section may be collapsed or expanded by clicking on the header.
      </p>

      <dl>
        <dt>
          Industries Selected/Treatment Technologies Selected/Pollutants
          Selected
        </dt>

        <dd>
          <p>
            The Industries, Treatment Technologies, and Pollutants fields
            display the search criteria selected by the user.
          </p>
        </dd>

        <dt>Distinct Industries Returned</dt>

        <dd>
          <p>
            The number of unique industries in IWTT matching the criteria
            selected, regardless of the grouping of the results. When viewing
            results grouped by Industry, this count will match the number of
            rows in the results table. When viewing results grouped by
            technology or pollutant, this count may not be equivalent to the sum
            of the values in the “# Industries” column in the results table
            because the same industry may be counted in more than one group.
          </p>
        </dd>

        <dt>
          Distinct Systems Containing Selected Treatment Technologies Returned
        </dt>

        <dd>
          <p>
            The number of unique treatment technology systems in IWTT matching
            the criteria selected, regardless of the grouping of the results.
            When viewing results grouped by industry or pollutant, this count
            may not be equivalent to the sum of the values in the “# Treatment
            Systems” column in the results table because the same treatment
            system may be counted in more than one group.
          </p>

          <ul>
            <li>
              <strong>Full-scale</strong> – The number of unique full-scale
              treatment technology systems with data matching the criteria
              selected.
            </li>

            <li>
              <strong>Pilot-scale</strong> – The number of unique pilot-scale
              treatment technology systems with data matching the criteria
              selected.
            </li>
          </ul>
        </dd>

        <dt>Distinct Parameters Returned</dt>

        <dd>
          The number of unique pollutants in IWTT matching the criteria
          selected, regardless of the grouping of the results. When viewing
          results grouped by pollutant, this count will match the number of rows
          in the results table. When viewing results grouped by technology or
          industry, this count may not be equivalent to the sum of the values in
          the “# Parameters” column in the results table because the same
          pollutant may be counted in more than one group.
        </dd>
      </dl>

      <h4 id="ResultsTable">
        <strong>Results Table</strong>
      </h4>

      <p>
        The results table will display different columns based on the selection
        you make under View Results By. The table below describes which columns
        will appear based on which aggregation is selected. Download the results
        table data in a comma-separated value (CSV) file by clicking the{" "}
        <strong>Download Guided Search Results</strong> button at the bottom of
        the table. Note that the download will correspond to the current results
        view. The name of each column in the download file is presented below in{" "}
        <em>[brackets]</em>.
      </p>

      <Table className={clsx("tw-not-prose")}>
        <caption className={clsx("tw-mb-2 tw-text-center")}>
          Columns in Results Tables
        </caption>

        <thead className={clsx("[&_th]:tw-text-center")}>
          <tr>
            <th rowSpan={2} className={clsx("!tw-align-bottom")}>
              Results Column
            </th>
            <th colSpan={3}>View Results By</th>
          </tr>
          <tr>
            <th>
              <strong>Industry</strong>
            </th>
            <th>
              <strong>Technology</strong>
            </th>
            <th>
              <strong>Pollutant</strong>
            </th>
          </tr>
        </thead>
        <tbody className={clsx("[&_td:not(:first-child)]:tw-text-center")}>
          <tr>
            <td>
              Industry <em>[PSCName]</em>
            </td>
            <td>✔</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>
              PSC <em>[PSCCode]</em>
            </td>
            <td>✔</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>
              Treatment Technology <em>[TreatmentTech, TreatmentTechCode]</em>
            </td>
            <td>&nbsp;</td>
            <td>✔</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>
              Parameter <em>[ParameterName]</em>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>✔</td>
          </tr>
          <tr>
            <td>
              # Industries <em>[CountInd]</em>
            </td>
            <td>&nbsp;</td>
            <td>✔</td>
            <td>✔</td>
          </tr>
          <tr>
            <td>
              # Treatment Systems <em>[CountSystem]</em>
            </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
          </tr>
          <tr>
            <td>
              # Parameters <em>[CountPoll]</em>
            </td>
            <td>✔</td>
            <td>✔</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>More Detail</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
          </tr>
        </tbody>
      </Table>

      <dl>
        <dt>More Detail</dt>

        <dd>
          <p>
            Provides a hyperlink to the treatment performance results pop-up
            window for the selected row of data.
          </p>
        </dd>
      </dl>

      <h3 id="MoreDetail">More Detail – Treatment Performance</h3>

      <p>
        Click the <strong>More Detail</strong> icon in the results table to view
        a pop up with detailed treatment performance data for the selected
        results row. The data are presented in a table with a summary section at
        the top. Close the pop-up by clicking outside the area of the pop-up or
        by clicking the “x” in the top-right corner.
      </p>

      <p>
        Download the treatment performance data in a CSV file by clicking the{" "}
        <strong>Download Treatment Performance Details</strong> button at the
        bottom of the table. The name of each column in the download file is
        presented below in <em>[brackets]</em>.
      </p>

      <h4 id="Summary">Summary Section</h4>

      <p>
        The{" "}
        <strong>
          Industries Selected/Treatment Technologies Selected/Pollutants
          Selected
        </strong>{" "}
        displays the criteria selected by the user. This section may be
        collapsed or expanded by clicking on the header.
      </p>

      <h4 id="Table">Table</h4>

      <dl>
        <dt>
          Industry <em>[PSCName]</em>
        </dt>

        <dd>
          <p>
            The industrial category from which the wastewater data originated.
          </p>
        </dd>

        <dt>
          Scale <em>[ScaleSystem]</em>
        </dt>

        <dd>The treatment system’s scale (i.e., pilot or full)</dd>

        <dt>
          Treatment Train <em>[TreatmentSystem], [System_Name]</em>
        </dt>

        <dd>
          <p>
            The order of treatment units used in the system. This column uses{" "}
            <Link
              to="/treatment-technologies"
              target="_blank"
              rel="noopener noreferrer"
            >
              Treatment Technology Codes
            </Link>{" "}
            as described in the table above. Hover over a code to see the full
            name of the treatment technology. In the download file, the column
            “System_Name” is the unique identifier for the treatment system in
            IWTT.
          </p>
        </dd>

        <dt>
          Parameter <em>[ParameterName], [ParameterID]</em>
        </dt>

        <dd>
          <p>
            The name of the parameter measured. The name is only as specific as
            stated in each article. In the download file, the column
            “ParameterID” is the unique identifier for a parameter in IWTT.
          </p>
        </dd>

        <dt>
          Influent <em>[InfluentFlag], [InfluentConcentration]</em>
        </dt>

        <dd>
          <p>
            Numerical influent value as reported by the data source. The
            influent data are collected before the first step of treatment or
            after mechanical pre-treatment (MPT).
          </p>
        </dd>

        <dt>
          Effluent <em>[EffluentFlag], [EffluentConcentration]</em>
        </dt>

        <dd>
          <p>
            Numerical effluent value as reported by the data source. The
            effluent data are collected after the last step of treatment.
          </p>
        </dd>

        <dt>
          Units <em>[Units]</em>
        </dt>

        <dd>
          <p>
            Unit of measure associated with the influent and effluent
            concentration values.
          </p>
        </dd>

        <dt>
          % Removal <em>[UpdateRemovalFlag], [UpdateRemoval]</em>
        </dt>

        <dd>
          <p>
            The percent of the pollutant removed from the wastestream as
            reported by the data source or calculated in IWTT.
          </p>
        </dd>

        <dt>
          Article <em>[Authors], [MainAuthor], [Year], [RefID]</em>
        </dt>

        <dd>
          <p>
            The citation information (Author, Year) of the data source. This
            column provides a hyperlink to the Article Summary Report. In the
            download file, the column “RefID” is the unique identifier for the
            article in IWTT.
          </p>
        </dd>
      </dl>
    </section>
  );
}
