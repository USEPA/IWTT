import { type ReactNode, useEffect } from "react";
import { type NavLinkProps, NavLink, Outlet } from "react-router-dom";
import clsx from "clsx";
// ---
import { useAppDispatch } from "@/redux/index";
import { fetchIndustryData } from "@/redux/reducers/inputsIndustry";
import { fetchTechnologyData } from "@/redux/reducers/inputsTechnology";
import { fetchPollutantData } from "@/redux/reducers/inputsPollutant";
import { fetchYearData } from "@/redux/reducers/inputsYear";
import { fetchSicData } from "@/redux/reducers/inputsSic";
import { fetchNaicsData } from "@/redux/reducers/inputsNaics";
import { fetchCategoryData } from "@/redux/reducers/inputsCategory";
import { fetchDocumentTypeData } from "@/redux/reducers/inputsDocumentType";
import { useScrollToHash } from "@/utilities";

function HeaderLink(props: {
  to: NavLinkProps["to"];
  tab?: boolean;
  children: ReactNode;
}) {
  const { to, tab = false, children } = props;
  return (
    <NavLink
      to={to}
      className={clsx(
        "tw-block tw-border tw-border-b-0 tw-border-neutral-400 tw-bg-white tw-p-3.5 tw-text-[0.8125rem] tw-font-bold tw-uppercase !tw-text-neutral-600 tw-no-underline",
        "hover:tw-bg-neutral-100",
        "focus:tw-bg-neutral-100",
        "[&.active]:tw-bg-neutral-100",
        tab
          ? clsx(
              "md:tw-relative md:tw-z-[1] md:tw-border-b md:tw-border-r-0",
              "md:focus:tw-z-[2]",
              "md:[&.active]:tw-border-b-white md:[&.active]:tw-bg-white",
            )
          : clsx(
              "md:tw-m-3 md:tw-border-0 md:tw-border-b-2 md:tw-border-b-transparent md:!tw-bg-white md:tw-p-0.5 md:tw-font-normal md:tw-normal-case",
              "md:hover:tw-border-neutral-200",
              "md:focus:tw-border-neutral-200",
            ),
      )}
    >
      {children}
    </NavLink>
  );
}

export function AppLayout() {
  const dispatch = useAppDispatch();

  useEffect(() => {
    dispatch(fetchIndustryData());
    dispatch(fetchTechnologyData());
    dispatch(fetchPollutantData());
    dispatch(fetchYearData());
    dispatch(fetchSicData());
    dispatch(fetchNaicsData());
    dispatch(fetchCategoryData());
    dispatch(fetchDocumentTypeData());
  });

  useScrollToHash();

  return (
    <div className={clsx("tw-my-4")}>
      <div className={clsx("tw-prose tw-mb-8 tw-max-w-none")}>
        <p>
          IWTT allows you to access industrial wastewater treatment technology
          performance data identified from data sources meeting data quality
          criteria. Data sources include conference proceedings, government
          reports, industry publications, and peer-reviewed journals. Please see{" "}
          <NavLink to="/about" target="_blank" rel="noopener noreferrer">
            About IWTT
          </NavLink>{" "}
          for more information and{" "}
          <NavLink to="/help" target="_blank" rel="noopener noreferrer">
            Help
          </NavLink>{" "}
          for instructions on how to use the tool.
        </p>
      </div>

      <header
        className={clsx(
          "after:tw-clear-both after:tw-table",
          "[&_li]:tw-mb-0 [&_li]:tw-leading-none",
          "[&_li]:md:tw-float-left",
          "print:tw-hidden",
        )}
      >
        <ul
          className={clsx(
            "tw-m-0 tw-list-none",
            "md:tw-relative md:tw-top-px md:tw-float-left md:tw-border-r md:tw-border-neutral-400",
          )}
        >
          <li>
            <HeaderLink to="/guided-search" tab>
              Guided Technology Search
            </HeaderLink>
          </li>
          <li>
            <HeaderLink to="/article-search" tab>
              Article Search
            </HeaderLink>
          </li>
          <li>
            <HeaderLink to="/download-database" tab>
              Download Database
            </HeaderLink>
          </li>
        </ul>

        <ul className={clsx("!tw-m-0 tw-list-none", "md:tw-float-right")}>
          <li>
            <HeaderLink to="/glossary">Glossary</HeaderLink>
          </li>
          <li>
            <HeaderLink to="/help">Help</HeaderLink>
          </li>
          <li>
            <HeaderLink to="/about">About IWTT</HeaderLink>
          </li>
        </ul>
      </header>

      <section
        className={clsx(
          "tw-relative tw-min-h-60 tw-border tw-border-neutral-400",
          "print:tw-border-0",
        )}
      >
        <Outlet />
      </section>
    </div>
  );
}
