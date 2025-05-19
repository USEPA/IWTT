import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

export function Glossary() {
  return (
    <section
      className={clsx(
        "tw-prose tw-max-w-none tw-p-4",
        "print:tw-p-0",
        "[&_dd_p:first-of-type]:tw-mt-0 [&_dd_p]:tw-mb-0",
      )}
    >
      <SectionHeading>Glossary</SectionHeading>

      <dl>
        <dt id="CFR">Code of Federal Regulations (CFR)</dt>

        <dd>
          <p>
            The codification of the general and permanent rules published in the
            Federal Register by the departments and agencies of the U.S. Federal
            Government. The CFR is produced by the Office of the Federal
            Register (OFR) and the Government Publishing Office. View more
            information at the{" "}
            <a
              href="https://www.ecfr.gov/cgi-bin/ECFR?page=browse"
              target="_blank"
              rel="noopener noreferrer"
            >
              Electronic Code of Federal Regulations (e-CFR) website
            </a>
            .
          </p>
        </dd>

        <dt>Direct Discharge</dt>

        <dd>
          <p>
            Pollutants released to surface waters, such as streams, lakes, or
            oceans.
          </p>
        </dd>

        <dt id="ELG">Effluent Guidelines</dt>

        <dd>
          <p>
            National regulatory standards for industrial wastewater discharged
            to surface waters and to municipal sewage treatment plants. EPA
            issues these regulations for industrial{" "}
            <a href="#PSC">point source categories</a>, based on the performance
            of treatment and control technologies. View more information at
            EPA’s{" "}
            <a
              href="https://www.epa.gov/eg"
              target="_blank"
              rel="noopener noreferrer"
            >
              Effluent Guidelines website
            </a>
            .
          </p>
        </dd>

        <dt>Indirect Discharge</dt>

        <dd>
          <p>
            Pollutants released to a{" "}
            <a href="#POTW">publicly owned treatment works (POTW)</a>.
          </p>
        </dd>

        <dt id="Industry">Industry</dt>

        <dd>
          <p>
            Industry classifications in IWTT correspond to{" "}
            <a href="#PSC">Point Source Categories (PSC)</a> or descriptions of
            two-digit <a href="#SIC">SIC codes</a>.
          </p>
        </dd>

        <dt>Motivation Category</dt>

        <dd>
          <p>
            General categories in IWTT to classify articles based on the
            motivation(s) for evaluating or implementing a treatment system, as
            described in each data source. Each article may have one or more
            motivation categories. Motivation categories include: effluent
            limit, cost savings, water reuse, capacity increase, zero liquid
            discharge, environmental impairment, and material recovery.
          </p>
        </dd>

        <dt id="NAICS">
          North American Industry Classification (NAICS) System
        </dt>

        <dd>
          <p>
            The North American Industry Classification System (NAICS) is the
            standard used by Federal statistical agencies in classifying
            business establishments for collecting, analyzing, and publishing
            statistical data related to the U.S. business economy.
          </p>

          <p>
            EPA assigned a NAICS code to each treatment system in IWTT based on
            the description of industrial activities in each data source. In
            some cases, there may not be sufficient information in the data
            source to classify the industrial activities associated with the
            wastewater treatment system. In such a case, a wastewater treatment
            system is assigned “999999 – Unspecified.”
          </p>

          <p>
            The NAICS system has replaced the U.S. Standard Industrial
            Classification (SIC) system. View more information about NAICS
            codes, and a crosswalk between NAICS and SIC codes, on the U.S.
            Census Bureau{" "}
            <a
              href="https://www.census.gov/naics/"
              target="_blank"
              rel="noopener noreferrer"
            >
              NAICS webpage
            </a>
            .
          </p>
        </dd>

        <dt id="Parameter">Parameter</dt>

        <dd>
          <p>
            The name of the analyte (e.g., substance name and form) measured, as
            stated in the data source.
          </p>
        </dd>

        <dt id="PSC">Point Source Category (PSC)</dt>

        <dd>
          <p>
            Industrial activities defined by EPA in the Effluent Guidelines
            program. The three-digit codes in the 400s correspond to the 40{" "}
            <a href="#CFR">CFR</a> Part Number (e.g., 40 CFR Part 405), while
            codes in the 500s indicate industry categories evaluated during
            EPA’s review of industrial dischargers.
          </p>

          <p>
            EPA assigned the PSC to a treatment system in IWTT based on the
            description of industrial activities in each data source and a
            crosswalk between <a href="#SIC">SIC codes</a> and PSC codes. This
            is not a determination of applicability to the Effluent Guidelines.
          </p>

          <p>
            In some cases, there may not be sufficient information in the data
            source to classify the industrial activities associated with the
            wastewater treatment system. In such a case, a wastewater treatment
            system is assigned “99 – Non-classifiable establishments.”
          </p>

          <p>
            View more information, including a list of industry category names
            and corresponding PSC codes, on EPA’s{" "}
            <a
              href="https://www.epa.gov/eg/industrial-effluent-guidelines#existing"
              target="_blank"
              rel="noopener noreferrer"
            >
              Industrial Effluent Guidelines webpage
            </a>
            .
          </p>
        </dd>

        <dt id="Pollutant">Pollutant</dt>

        <dd>
          <p>
            The grouping of parameters into a simplified naming convention for
            searching IWTT. Note that results are presented at the{" "}
            <a href="#Parameter">parameter</a>-level. For example, a search for
            the pollutant “Nitrogen” may provide results for the parameters
            “Nitrogen, total” and “Nitrogen, organic.”
          </p>
        </dd>

        <dt id="POTW">Publicly Owned Treatment Works (POTW)</dt>

        <dd>
          <p>
            A sewage treatment plant that is owned and usually operated by a
            government agency.
          </p>
        </dd>

        <dt id="Scale">Scale</dt>

        <dd>
          <p>
            The relative size and purpose of the treatment system, as described
            in the data source.
          </p>

          <ul>
            <li>
              <strong>Full</strong> – A fully operational system that is past
              any testing phase.
            </li>

            <li>
              <strong>Pilot</strong> – A small-scale system operated to gain
              information relating to the anticipated performance of the larger
              system.
            </li>

            <li>
              <strong>Lab</strong> – Testing conducted in a laboratory,
              generally with synthesized wastewater and/or modeled results.
              Treatment performance data for lab scale systems are not included
              in IWTT.
            </li>
          </ul>
        </dd>

        <dt id="SIC">Standard Industrial Classification (SIC) System</dt>

        <dd>
          <p>
            A system for classifying industries by a four-digit code established
            by the U.S. government to identify processes, products, and
            services. Although the SIC system has been replaced by the NAICS
            system, many government agencies, including EPA, use the SIC system
            promote data comparability. EPA’s data collection system for the
            Clean Water Act NPDES Program, ICIS-NPDES, includes a primary
            four-digit SIC codes for facilities, reflecting the principal
            activity causing the discharge at each facility.
          </p>

          <p>
            EPA assigned an SIC code to each treatment system in IWTT based on
            the description of industrial activities in each data source. The
            SIC codes will allow for the comparison of information across
            ICIS-NPDES and IWTT. In some cases, there may not be sufficient
            information in the data source to classify the industrial activities
            associated with the wastewater treatment system. In such a case, a
            wastewater treatment system is assigned “9999 – Non-classifiable
            establishments.”
          </p>

          <p>
            View more information about SIC codes on the U.S. Department of
            Labor{" "}
            <a
              href="https://www.osha.gov/pls/imis/sicsearch.html"
              target="_blank"
              rel="noopener noreferrer"
            >
              SIC System Search
            </a>
            . View more information about NAICS codes, and a crosswalk between
            NAICS and SIC codes, on the U.S. Census Bureau{" "}
            <a
              href="https://www.census.gov/naics/"
              target="_blank"
              rel="noopener noreferrer"
            >
              NAICS webpage
            </a>
            . View more information about pollutant discharges on the{" "}
            <a
              href="https://www.epa.gov/npdes"
              target="_blank"
              rel="noopener noreferrer"
            >
              Clean Water Act NPDES Program website
            </a>
            .
          </p>
        </dd>

        <dt id="TreatmentSystem">Treatment System</dt>

        <dd>
          <p>
            A technology or combination of technologies (e.g., series of unit
            processes or treatment train) that treats and discharges wastewater
            to surface waters. In IWTT, EPA has arranged a treatment system (or
            systems) in a series of{" "}
            <Link
              to="/treatment-technologies"
              target="_blank"
              rel="noopener noreferrer"
            >
              treatment technology codes
            </Link>{" "}
            for each article based on a review of the information. While this
            may represent a simplification of some treatment system
            configurations, the treatment technology codes allow users to query
            and identify treatment technologies used and associated pollutant
            removal performance data. IWTT includes a description of the
            treatment system to provide additional detail about the treatment
            train.
          </p>
        </dd>
      </dl>
    </section>
  );
}
