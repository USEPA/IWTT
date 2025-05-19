import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

function MultiSelectHelpText() {
  return (
    <p>
      Select one or more values using the dropdown menu or filter available
      options by typing text directly into the text box. Individual search terms
      may be removed by selecting the “x” to the right of each term, or all
      terms may be cleared by selecting the “x” on the right side of the box.
    </p>
  );
}

export function ArticleSearchHelp() {
  return (
    <section
      className={clsx(
        "tw-prose tw-max-w-none tw-p-4",
        "print:tw-p-0",
        "[&_dd_p:first-of-type]:tw-mt-0 [&_dd_p]:tw-mb-0",
      )}
    >
      <SectionHeading>Article Search Help</SectionHeading>

      <p>
        The Article Search allows you to identify industrial wastewater
        treatment data sources (e.g., publications) of interest based on
        bibliographic information and treatment performance criteria. Directly
        review the detailed data captured in IWTT by accessing the{" "}
        <Link
          to="/article-report-help"
          target="_blank"
          rel="noopener noreferrer"
        >
          Article Summary Report
        </Link>{" "}
        for each article returned.
      </p>

      <ul>
        <li>
          <a href="#SearchCriteria">Select Search Criteria</a>
        </li>

        <li>
          <a href="#SearchResults">Search Results</a>
        </li>
      </ul>

      <h3 id="SearchCriteria">Select Search Criteria</h3>

      <p>
        Search for wastewater treatment data sources in IWTT meeting the
        selected criteria. Choose from search options specifying industrial
        categories, treatment technologies, pollutants, and bibliographic
        information, and click the <strong>Search</strong> button.
      </p>

      <dl>
        <dt>Industry</dt>

        <dd>
          <p>
            Search for articles describing treatment systems associated with one
            or more{" "}
            <Link to="/glossary#PSC" target="_blank" rel="noopener noreferrer">
              Point Source Categories (PSCs)
            </Link>
            . Only industrial categories with information in IWTT are included
            in this search option. A full list of PSCs, including those that may
            not have data in IWTT, can be found in the PSC Codes section of the{" "}
            <Link to="/glossary" target="_blank" rel="noopener noreferrer">
              Glossary
            </Link>
            .
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>SIC Code</dt>

        <dd>
          <p>
            Search for articles describing treatment systems associated with one
            or more four-digit{" "}
            <Link to="/glossary#SIC" target="_blank" rel="noopener noreferrer">
              Standard Industrial Classification (SIC)
            </Link>{" "}
            codes. A{" "}
            <a
              href="https://www.osha.gov/pls/imis/sicsearch.html"
              target="_blank"
              rel="noopener noreferrer"
            >
              lookup link
            </a>{" "}
            is provided to help identify an appropriate SIC code.
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>NAICS Code</dt>

        <dd>
          <p>
            Search for articles describing treatment systems associated with one
            or more six-digit{" "}
            <Link
              to="/glossary#NAICS"
              target="_blank"
              rel="noopener noreferrer"
            >
              North American Industry Classification System (NAICS)
            </Link>{" "}
            codes. A{" "}
            <a
              href="https://www.census.gov/naics/"
              target="_blank"
              rel="noopener noreferrer"
            >
              lookup link
            </a>{" "}
            is provided to help identify an appropriate NAICS code.
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>Treatment Technology</dt>

        <dd>
          <p>
            Search for one or more wastewater treatment technologies (e.g., unit
            processes) associated with a treatment system. Refer to the{" "}
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
            for the technology "Membrane Filtration" may provide results for the
            technologies "Reverse Osmosis," “Nanofiltration,” “Forward Osmosis,”
            “Membrane Distillation,” and “Micro- and Ultra-Membrane Filtration.”
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>Treatment Scale</dt>

        <dd>
          <p>
            Search for articles based on the selected{" "}
            <Link
              to="/glossary#Scale"
              target="_blank"
              rel="noopener noreferrer"
            >
              scale
            </Link>{" "}
            of the treatment system(s) described in the data source. Select
            “Lab,” “Pilot,” or “Full.” “Pilot” and “Full” are selected by
            default.
          </p>

          <p>
            Note about lab scale systems: Treatment Technology, Pollutant,
            Target Pollutant Percent Removal, and NAICS Code search criteria are
            not available when you select lab scale systems only because this
            information is not captured in IWTT for lab scale systems.
          </p>
        </dd>

        <dt>Publication Date Range</dt>

        <dd>
          <p>
            Search for articles published within a specific timeframe. Both ends
            of the slider can be moved to adjust the range of years.
          </p>
        </dd>

        <dt>Pollutant</dt>

        <dd>
          <p>
            Search for one or more pollutants with treatment performance data
            (e.g., influent concentration/quantity, effluent
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
            organic.” Searching on multiple pollutants will return articles with
            any of the selected pollutants.
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>Target Pollutant Percent Removal</dt>

        <dd>
          <p>
            Search for parameters by the percent removed by a treatment system.
            If searching on multiple pollutants, the results will include
            articles with percent removals that are within the specified range
            for any of the parameters. Note that most, but not all, parameters
            have a percent removal either reported in the data source or
            calculated in IWTT.
          </p>

          <p>
            Check the box to expand a slider bar. Move one or both ends of the
            slider to search for articles with a specific range of percent
            removal.
          </p>
        </dd>

        <dt>Motivation Category</dt>

        <dd>
          <p>
            Search for articles classified by a motivation category. These are
            general categories in IWTT to classify articles based on the
            motivation(s) for evaluating or implementing a treatment system, as
            described in each data source. Each article may have one or more
            motivation categories. The motivation categories are capacity
            increase, cost savings, effluent limit, environmental impairment,
            material recovery, water reuse, and zero liquid discharge.
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>Document Type</dt>

        <dd>
          <p>
            Search for articles based on the data source of the publication. The
            document types are categorized as conference proceeding, government
            report, industry publication, and peer-reviewed journal. The types
            of data sources reviewed by EPA are described in the{" "}
            <Link to="/about#Scope" target="_blank" rel="noopener noreferrer">
              Scope
            </Link>{" "}
            section of About IWTT.
          </p>

          <MultiSelectHelpText />
        </dd>

        <dt>Keywords</dt>

        <dd>
          <p>
            Search for specific terms in the Title, Abstract, and Key Findings
            fields of articles stored in IWTT. To search for more than one
            keyword, separate each term with a comma. Searching on multiple
            keywords will return articles with any of the keywords.
          </p>
        </dd>

        <dt>Authors</dt>

        <dd>
          <p>
            Search for authors of articles in IWTT. To search for more than one
            author, separate each term with a comma. Searching on multiple
            authors will return articles with any of the authors listed.
          </p>
        </dd>
      </dl>

      <h3 id="SearchResults">Search Results</h3>

      <p>
        The Article Search results present articles and summary information that
        meet the specified search criteria. Since several search criteria apply
        to the treatment system(s) or pollutant(s) described within an article,
        users are encouraged to view the{" "}
        <Link
          to="/article-report-help"
          target="_blank"
          rel="noopener noreferrer"
        >
          Article Summary Report
        </Link>{" "}
        by clicking the article title to access the detailed information
        captured about the article.
      </p>

      <p>
        Search results will display below the search criteria panel. After
        performing an initial search, you may modify search criteria to refine
        the results or select <strong>Reset Search Results</strong> to clear the
        form and start a new search.
      </p>

      <dl>
        <dt>Number of Search Results</dt>

        <dd>
          <p>The number of articles which meet the search criteria.</p>
        </dd>

        <dt>Title</dt>

        <dd>
          <p>
            The title of the article. Select the hyperlink on the title to go to{" "}
            <Link
              to="/article-report-help"
              target="_blank"
              rel="noopener noreferrer"
            >
              Article Summary Report
            </Link>
            .
          </p>
        </dd>

        <dt>Author</dt>

        <dd>
          <p>All authors, listed in the order presented the article.</p>
        </dd>

        <dt>Publication</dt>

        <dd>
          <p>
            The publication source (e.g., journal, conference) of the article.
          </p>
        </dd>

        <dt>Year</dt>

        <dd>
          <p>The year in which the article was published.</p>
        </dd>

        <dt>Scale</dt>

        <dd>
          <p>
            The scale (e.g., pilot, full) of the treatment system(s) described
            in the article.
          </p>
        </dd>

        <dt># Treatment Systems</dt>

        <dd>
          <p>
            The count of pilot- or full-scale treatment systems described in the
            article and captured in IWTT.
          </p>
        </dd>

        <dt>Abstract</dt>

        <dd>
          <p>
            The abstract from each article provides an overview of its
            methodology, scope, and findings.
          </p>
        </dd>
      </dl>
    </section>
  );
}
