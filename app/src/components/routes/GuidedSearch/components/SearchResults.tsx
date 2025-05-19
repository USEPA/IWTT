import { type ReactNode, useState } from "react";
import { Link } from "react-router-dom";
import { PlusCircleIcon } from "@heroicons/react/16/solid";
import clsx from "clsx";
// ---
import { CenteredButton } from "@/components/CenteredButton";
import { Details, Summary } from "@/components/Disclosure";
import { Table } from "@/components/Table";
import { Message } from "@/components/Message";
import { useAppDispatch, useAppSelector } from "@/redux/index";
import {
  getNodeText,
  displayEmptyValue,
  compareObjectsByField,
  webServiceUrl,
} from "@/utilities";

export function SearchResults() {
  const json = useAppSelector(({ guidedSearch }) => guidedSearch.json);
  const searchParams = useAppSelector(
    ({ guidedSearch }) => guidedSearch.searchParams,
  );
  const lastSearch = useAppSelector(
    ({ guidedSearch }) => guidedSearch.lastSearch,
  );
  const searchFilter = useAppSelector(
    ({ guidedSearch }) => guidedSearch.filter,
  );
  const dispatch = useAppDispatch();

  const [sortBy, setSortBy] = useState("PSCName");
  const [sortDirection, setSortDirection] = useState<"asc" | "desc">("asc");

  if (!json) return;

  function SortableColumn(props: {
    style?: Object;
    className?: string;
    field: string;
    text: ReactNode;
  }) {
    const { style, className, field, text } = props;
    return (
      <th style={style || {}} className={clsx("!tw-p-0", className)}>
        <button
          className={clsx(
            "tw-relative tw-w-full tw-py-2 tw-pl-2.5 tw-pr-[1.625rem] tw-text-left",
            "focus:tw-z-[1]",
            "after:tw-absolute after:tw-right-1 after:tw-h-4 after:tw-w-4",
            "after:tw-bg-[url('/assets/img/table-sort-icons.svg')]",
            "after:tw-bg-[length:96px_32px]",
            sortBy === field
              ? sortDirection === "asc"
                ? "after:tw-bg-[position:-40px_-8px]"
                : "after:tw-bg-[position:-72px_-8px]"
              : "after:tw-bg-[position:-8px_-8px]",
          )}
          type="button"
          title={`Sort search results by ${getNodeText(text)}`}
          onClick={(_ev) => {
            setSortBy(field);
            setSortDirection(
              field !== sortBy
                ? "asc"
                : sortDirection === "asc"
                  ? "desc"
                  : "asc",
            );
          }}
        >
          {text}
        </button>
      </th>
    );
  }

  function ModalButton({ modalTitle }: { modalTitle: string }) {
    const title = `Treatment Performance for ${modalTitle}`;
    return (
      <button
        className={clsx("tw-rounded-full tw-text-[#0071bc]")}
        type="button"
        title={title}
        onClick={(_ev) => {
          dispatch({
            type: "guided-search/display-modal",
            payload: { modalTitle },
          });
        }}
      >
        <span className="tw-sr-only">{title}</span>
        <PlusCircleIcon className="tw-h-3.5 tw-w-3.5" aria-hidden="true" />
      </button>
    );
  }

  function NoResultsMessage() {
    return (
      <Message>
        <p>
          The search returned zero results. IWTT does not currently contain
          treatment performance information meeting these search criteria.
          Select new or remove selected search criteria to expand the search.
        </p>

        <p>
          For more information about the scope of data captured, see{" "}
          <Link to="/about" target="_blank" rel="noopener noreferrer">
            About IWTT
          </Link>
          .
        </p>
      </Message>
    );
  }

  function noDataForSelectedSearchFilter() {
    if (!json) return true;

    if (
      (searchFilter === "Industry" && !json.data.Industries) ||
      (searchFilter === "Treatment Technology" && !json.data.Technologies) ||
      (searchFilter === "Pollutant" && !json.data.Pollutants)
    ) {
      return true;
    }
    return false;
  }

  const downloadUrl = () => {
    let letter = "";
    if (searchFilter === "Industry") letter = "i";
    if (searchFilter === "Treatment Technology") letter = "t";
    if (searchFilter === "Pollutant") letter = "p";

    const queryString =
      `p_point_source_category_code=${searchParams.industry}` +
      `&p_treatment_technology_code=${searchParams.technology}` +
      `&p_pollutant_search_term=${searchParams.pollutant}`;

    return webServiceUrl(`guid_search_${letter}_csv`, queryString);
  };

  function compareBy(field: string) {
    return compareObjectsByField({ field, reverse: sortDirection === "desc" });
  }

  const sortedIndustries = json.data.Industries
    ? [
        // convert PSCCode to a number, so its sorted by number and not string
        ...json.data.Industries.map((d) => ({ ...d, PSCCode: Number(d.PSCCode) })), // prettier-ignore
      ].sort(compareBy(sortBy))
    : [];

  const sortedTechnologies = json.data.Technologies
    ? [...json.data.Technologies].sort(compareBy(sortBy))
    : [];

  const sortedPollutants = json.data.Pollutants
    ? [...json.data.Pollutants].sort(compareBy(sortBy))
    : [];

  return (
    <section>
      {!json.data.Details ? (
        <NoResultsMessage />
      ) : (
        <>
          {/* --- results summary --- */}
          <Details className={clsx("tw-bg-neutral-100")}>
            <Summary>Summary of Results</Summary>

            <section
              className={clsx(
                "tw-flex tw-flex-wrap tw-border tw-border-t-0 tw-border-neutral-400",
                "[&_p]:tw-text-sm",
                "[&_p:not(:first-child)]:tw-mt-2",
                "print:tw-border-0 print:tw-p-0",
              )}
            >
              <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                <p>
                  <strong>Industries Selected: </strong>
                  <span className={clsx("tw-block")}>
                    {lastSearch.industries.length > 0
                      ? lastSearch.industries.join(" • ")
                      : displayEmptyValue()}
                  </span>
                </p>

                <p>
                  <strong>Distinct Industries Returned: </strong>
                  <span>{json.data.CountIndustry}</span>
                </p>
              </div>

              <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                <p>
                  <strong>Treatment Technologies Selected: </strong>
                  <span className={clsx("tw-block")}>
                    {lastSearch.technologies.length > 0
                      ? lastSearch.technologies.join(" • ")
                      : displayEmptyValue()}
                  </span>
                </p>

                <p>
                  <strong>
                    Distinct Systems Containing Selected Treatment Technologies
                    Returned:{" "}
                  </strong>
                  <span>{json.data.CountSystem}</span>
                </p>

                <p className={clsx("tw-inline-block tw-w-full", "sm:tw-w-1/2")}>
                  <strong>Full-Scale: </strong>
                  <span>{json.data.CountSystemFull}</span>
                </p>

                <p className={clsx("tw-inline-block tw-w-full", "sm:tw-w-1/2")}>
                  <strong>Pilot-Scale: </strong>
                  <span>{json.data.CountSystemPilot}</span>
                </p>
              </div>

              <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                <p>
                  <strong>Pollutants Selected: </strong>
                  <span className={clsx("tw-block")}>
                    {lastSearch.pollutants.length > 0
                      ? lastSearch.pollutants.join(" • ")
                      : displayEmptyValue()}
                  </span>
                </p>

                <p>
                  <strong>Distinct Parameters Returned: </strong>
                  <span>{json.data.CountPollutant}</span>
                </p>
              </div>
            </section>
          </Details>

          {/* --- results table --- */}
          {noDataForSelectedSearchFilter() ? (
            <NoResultsMessage />
          ) : (
            <>
              <>
                {searchFilter === "Industry" && (
                  <Table
                    className={clsx(
                      "[&_:where(th,td):not(:first-child)]:tw-text-right",
                    )}
                  >
                    <thead>
                      <tr>
                        <SortableColumn field="PSCName" text="Industry" />
                        <SortableColumn
                          field="PSCCode"
                          text={<abbr title="Point Source Category">PSC</abbr>}
                        />
                        <SortableColumn
                          field="CountSystembyInd"
                          text="#&nbsp;Treatment Systems"
                        />
                        <SortableColumn
                          field="CountPollbyInd"
                          text="#&nbsp;Parameters"
                        />
                        <th>More Detail</th>
                      </tr>
                    </thead>

                    <tbody>
                      {sortedIndustries.map((i) => (
                        <tr key={i.PSCCode}>
                          <td>{i.PSCName}</td>
                          <td>{i.PSCCode}</td>
                          <td>{i.CountSystembyInd}</td>
                          <td>{i.CountPollbyInd}</td>
                          <td className={clsx("tw-text-right")}>
                            <ModalButton modalTitle={i.PSCName} />
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                )}

                {searchFilter === "Treatment Technology" && (
                  <Table
                    className={clsx(
                      "[&_:where(th,td):not(:first-child)]:tw-text-right",
                    )}
                  >
                    <thead>
                      <tr>
                        <SortableColumn
                          field="TreatmentTech"
                          text="Treatment Technology"
                        />
                        <SortableColumn
                          field="CountSystembyTech"
                          text="#&nbsp;Treatment Systems"
                        />
                        <SortableColumn
                          field="CountIndbyTech"
                          text="#&nbsp;Industries"
                        />
                        <SortableColumn
                          field="CountPollbyTech"
                          text="#&nbsp;Parameters"
                        />
                        <th>More Detail</th>
                      </tr>
                    </thead>

                    <tbody>
                      {sortedTechnologies.map((t) => (
                        <tr key={t.TreatmentTech}>
                          <td>{t.TreatmentTech}</td>
                          <td>{t.CountSystembyTech}</td>
                          <td>{t.CountIndbyTech}</td>
                          <td>{t.CountPollbyTech}</td>
                          <td className={clsx("tw-text-right")}>
                            <ModalButton modalTitle={t.TreatmentTech} />
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                )}

                {searchFilter === "Pollutant" && (
                  <Table
                    className={clsx(
                      "[&_:where(th,td):not(:first-child)]:tw-text-right",
                    )}
                  >
                    <thead>
                      <tr>
                        <SortableColumn
                          field="ParameterName"
                          text="Parameter"
                        />
                        <SortableColumn
                          field="CountSystembyPoll"
                          text="#&nbsp;Treatment Systems"
                        />
                        <SortableColumn
                          field="CountIndbyPoll"
                          text="#&nbsp;Industries"
                        />
                        <th>More Detail</th>
                      </tr>
                    </thead>

                    <tbody>
                      {sortedPollutants.map((p) => (
                        <tr key={p.ParameterName}>
                          <td>{p.ParameterName}</td>
                          <td>{p.CountSystembyPoll}</td>
                          <td>{p.CountIndbyPoll}</td>
                          <td className={clsx("tw-text-right")}>
                            <ModalButton modalTitle={p.ParameterName} />
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </Table>
                )}
              </>

              <p className={clsx("tw-mt-4")}>
                <a href={downloadUrl()} download tabIndex={-1}>
                  <CenteredButton text="Download Guided Search Results" />
                </a>
              </p>
            </>
          )}
        </>
      )}
    </section>
  );
}
