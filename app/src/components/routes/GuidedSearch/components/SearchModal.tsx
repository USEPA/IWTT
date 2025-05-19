import { type ReactNode, useState } from "react";
import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { CenteredButton } from "@/components/CenteredButton";
import { Details, Summary } from "@/components/Disclosure";
import { Table } from "@/components/Table";
import { Modal } from "@/components/Modal";
import { useAppDispatch, useAppSelector } from "@/redux/index";
import {
  getNodeText,
  displayEmptyValue,
  compareObjectsByField,
  webServiceUrl,
} from "@/utilities";

function formatNumber(input: number) {
  return input.toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

export function SearchModal() {
  const technologyMap = useAppSelector(({ inputs }) => inputs.technology.map);
  const activeItem = useAppSelector(
    ({ guidedSearch }) => guidedSearch.modal.title,
  );
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

  function TreatmentTrain({ abbrevs }: { abbrevs: string[] }) {
    return abbrevs.map((abbr, index) => {
      const delimiter = abbrevs.length - index > 1 ? "\xa0\xa0➝\xa0\xa0" : "";
      const definition = technologyMap[abbr];
      return (
        <span key={index}>
          <abbr title={definition}>{abbr}</abbr>
          {delimiter}
        </span>
      );
    });
  }

  const tableRows = json.data.Details.filter((d) => {
    if (searchFilter === "Industry") {
      return d.PSCName === activeItem;
    }

    if (searchFilter === "Treatment Technology") {
      const technologies = d.TreatmentSystem.map((t) => technologyMap[t]);
      return technologies.includes(activeItem);
    }

    if (searchFilter === "Pollutant") {
      return d.ParameterName === activeItem;
    }

    return false;
  });

  const sortedTableRows = [...tableRows].sort(
    compareObjectsByField({ field: sortBy, reverse: sortDirection === "desc" }),
  );

  const selectedIndustries =
    searchFilter === "Industry" ? [activeItem] : lastSearch.industries;

  const selectedTechnologies =
    searchFilter === "Treatment Technology"
      ? [activeItem]
      : lastSearch.technologies;

  const selectedPollutants =
    searchFilter === "Pollutant" ? [activeItem] : lastSearch.pollutants;

  function downloadUrl() {
    if (!json) return "";

    let queryString;

    if (searchFilter === "Industry") {
      const industry = json.data.Industries.filter((i) => i.PSCName === activeItem); // prettier-ignore
      queryString = `p_point_source_category_code=${industry[0].PSCCode}`;
    } else {
      queryString = `p_point_source_category_code=${searchParams.industry}`;
    }

    if (searchFilter === "Treatment Technology") {
      const technology = json.data.Technologies.filter((t) => t.TreatmentTech === activeItem); // prettier-ignore
      queryString += `&p_treatment_technology_code=${technology[0].TreatmentTechCode}`;
    } else {
      queryString += `&p_treatment_technology_code=${searchParams.technology}`;
    }

    if (searchFilter === "Pollutant") {
      const pollutant = json.data.Pollutants.filter((p) => p.ParameterName === activeItem); // prettier-ignore
      queryString += `&p_parameter_desc=${encodeURIComponent(pollutant[0].ParameterName)}`; // prettier-ignore
    } else {
      queryString += `&p_pollutant_search_term=${searchParams.pollutant}`;
    }

    return webServiceUrl("guid_search_d_csv", queryString);
  }

  return (
    <Modal
      title={`Treatment Performance for ${activeItem}`}
      onCloseClick={() => dispatch({ type: "guided-search/close-modal" })}
    >
      {/* --- results summary --- */}
      <Details className={clsx("tw-bg-neutral-100")}>
        <Summary>Summary</Summary>

        <section
          className={clsx(
            "tw-flex tw-flex-wrap tw-border tw-border-t-0 tw-border-neutral-400",
            "[&_p]:tw-text-sm",
          )}
        >
          <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
            <p>
              <strong>Industries Selected:</strong>
              <span className={clsx("tw-block")}>
                {selectedIndustries.length > 0
                  ? selectedIndustries.join(" • ")
                  : displayEmptyValue()}
              </span>
            </p>
          </div>

          <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
            <p>
              <strong>Treatment Technologies Selected:</strong>
              <span className={clsx("tw-block")}>
                {selectedTechnologies.length > 0
                  ? selectedTechnologies.join(" • ")
                  : displayEmptyValue()}
              </span>
            </p>
          </div>

          <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
            <p>
              <strong>Pollutants Selected:</strong>
              <span className={clsx("tw-block")}>
                {selectedPollutants.length > 0
                  ? selectedPollutants.join(" • ")
                  : displayEmptyValue()}
              </span>
            </p>
          </div>
        </section>
      </Details>

      {/* --- results table --- */}
      <Table>
        <thead>
          <tr>
            <SortableColumn
              style={{ width: "20%" }}
              field="PSCName"
              text="Industry"
            />
            <SortableColumn
              field="ScaleSystem"
              text="Scale" //
            />
            <th style={{ width: "20%" }}>Treatment Train</th>
            <SortableColumn
              style={{ width: "20%" }}
              field="ParameterName"
              text="Parameter"
            />
            <SortableColumn
              className={clsx("tw-text-right")}
              field="InfluentConcentration"
              text="Influent"
            />
            <SortableColumn
              className={clsx("tw-text-right")}
              field="EffluentConcentration"
              text="Effluent"
            />
            <SortableColumn
              field="Units"
              text="Units" //
            />
            <SortableColumn
              className={clsx("tw-text-right")}
              field="UpdateRemoval"
              text="%&nbsp;Removal"
            />
            <SortableColumn
              style={{ width: "20%" }}
              field="MainAuthor"
              text="Article"
            />
          </tr>
        </thead>
        <tbody>
          {sortedTableRows.map((item, index) => {
            const industry = item.PSCName ? item.PSCName : displayEmptyValue();
            const scale = item.ScaleSystem
              ? item.ScaleSystem
              : displayEmptyValue();
            const treatmentTrain = item.TreatmentSystem ? (
              <TreatmentTrain abbrevs={item.TreatmentSystem} />
            ) : (
              displayEmptyValue()
            );
            const parameter = item.ParameterName
              ? item.ParameterName
              : displayEmptyValue();
            const influentConcentration = item.InfluentConcentration
              ? `${item.InfluentFlag || ""} ${item.InfluentConcentration}`
              : displayEmptyValue();
            const effluentConcentration = item.EffluentConcentration
              ? `${item.EffluentFlag || ""} ${item.EffluentConcentration}`
              : displayEmptyValue();
            const units = item.Units ? item.Units : displayEmptyValue();
            const percentRemoval = item.UpdateRemoval
              ? `${item.UpdateRemovalFlag || ""} ${
                  formatNumber(item.UpdateRemoval) === "100.00"
                    ? "100"
                    : formatNumber(item.UpdateRemoval)
                }`
              : displayEmptyValue();

            return (
              <tr key={index}>
                <td>{industry}</td>
                <td>{scale}</td>
                <td>{treatmentTrain}</td>
                <td>{parameter}</td>
                <td className={clsx("tw-text-right")}>
                  {influentConcentration}
                </td>
                <td className={clsx("tw-text-right")}>
                  {effluentConcentration}
                </td>
                <td>{units}</td>
                <td className={clsx("tw-text-right")}>{percentRemoval}</td>
                <td>
                  <Link
                    to={`/article-report/${item.Ref_ID}`}
                    title="View Article Summary Report"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    {item.MainAuthor}, {item.Year}
                  </Link>
                </td>
              </tr>
            );
          })}
        </tbody>
      </Table>

      <p className={clsx("tw-mt-4")}>
        <a href={downloadUrl()} download>
          <CenteredButton text="Download Treatment Performance Details" />
        </a>
      </p>
    </Modal>
  );
}
