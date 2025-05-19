import { NavLink, Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";

export function Help() {
  return (
    <section className={clsx("tw-prose tw-max-w-none tw-p-4", "print:tw-p-0")}>
      <SectionHeading>
        Help Documentation and Technical Assistance
      </SectionHeading>

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

      <h3>Help Documentation</h3>
      <ul>
        <li>
          <NavLink to="/guided-search-help">
            Guided Technology Search Help
          </NavLink>
        </li>
        <li>
          <NavLink to="/article-search-help">Article Search Help</NavLink>
        </li>
        <li>
          <NavLink to="/article-report-help">
            Article Summary Report Help
          </NavLink>
        </li>
        <li>
          <NavLink to="/treatment-technologies">
            Treatment Technology Descriptions
          </NavLink>
        </li>
      </ul>

      <div className={clsx("tw-clear-both")}>
        <p>
          Need further information? Submit your technical questions, general
          inquiries, and website feedback to IWTT Technical Assistance (
          <a href="mailto:iwtt@epa.gov?subject=Technical%20Assistance">
            iwtt@epa.gov
          </a>
          ).
        </p>
      </div>
    </section>
  );
}
