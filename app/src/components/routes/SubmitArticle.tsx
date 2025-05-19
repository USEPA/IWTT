import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

export function SubmitArticle() {
  return (
    <section className={clsx("tw-prose tw-max-w-none tw-p-4", "print:tw-p-0")}>
      <SectionHeading>Submit an Article to IWTT</SectionHeading>

      <p>
        EPA is seeking articles, including published or accepted peer-reviewed
        journal articles or conference proceedings. EPA expects articles to meet
        the following quality criteria to be included in IWTT:
      </p>

      <ul>
        <li>Published since 2000;</li>
        <li>
          Describes pilot- or full-scale systems treating industrial wastewater;
          and
        </li>
        <li>
          Includes specific technical data, including:
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
              <a
                href="https://www.epa.gov/cwa-methods"
                target="_blank"
                rel="noopener noreferrer"
              >
                Analytical methods or test procedures
              </a>{" "}
              used to analyze parameters in wastewater;
            </li>
            <li>
              Pollutant parameters removed, including treatment system influent
              and effluent quality, and percent removals achieved, if available;
              and
            </li>
            <li>
              Specific motivations for evaluating and employing new
              technologies.
            </li>
          </ul>
        </li>
      </ul>

      <h3>Instructions</h3>

      <p>
        Please submit an article for consideration by sending an email message
        to{" "}
        <a href="mailto:iwtt@epa.gov?subject=Article%20submission%20for%20IWTT">
          IWTT@epa.gov
        </a>{" "}
        (clicking the link opens an email message in your default email program,
        populated with a subject line) with the following information:
      </p>

      <ol>
        <li>Your name</li>
        <li>Your email address</li>
        <li>Article file attached (PDF preferred)</li>
        <li>Citation information (if not included in the article file)</li>
        <li>Confirmation that IWTT quality criteria are met</li>
      </ol>

      <p>
        You will receive a reply confirming your submission. You may receive
        separate notification as to whether the article meets IWTT quality
        criteria. EPA cannot provide a timeframe in which specific articles may
        be entered into IWTT, as the rate at which information is entered into
        IWTT will depend on EPA resources and future priorities.
      </p>
    </section>
  );
}
