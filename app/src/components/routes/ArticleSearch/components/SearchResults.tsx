import { type ReactNode, useState } from "react";
import { Link } from "react-router-dom";
import clsx from "clsx";
// ---
import { CenteredButton } from "@/components/CenteredButton";
import { Table } from "@/components/Table";
import { Message } from "@/components/Message";
import { useAppSelector } from "@/redux/index";
import { getNodeText, compareObjectsByField, webServiceUrl } from "@/utilities";

export function SearchResults() {
  const json = useAppSelector(({ articleSearch }) => articleSearch.json);
  const searchQuery = useAppSelector(
    ({ articleSearch }) => articleSearch.searchQuery,
  );

  const [sortBy, setSortBy] = useState("Title");
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

  const sortedTableRows = json.data.Reference_Info
    ? [...json.data.Reference_Info].sort(
        compareObjectsByField({
          field: sortBy,
          reverse: sortDirection === "desc",
        }),
      )
    : [];

  return (
    <section>
      {!json.data.Reference_Info ? (
        <NoResultsMessage />
      ) : (
        <>
          <div className={clsx("tw-mx-auto tw-mt-4 tw-flex tw-items-end")}>
            <p
              className={clsx(
                "tw-inline-block tw-w-full tw-text-sm tw-font-bold tw-leading-none",
                "sm:tw-w-1/2",
              )}
            >
              Number of Search Results: {json.data.CountREF_ID}
            </p>

            <p
              className={clsx(
                "tw-inline-block tw-w-full tw-text-right",
                "sm:tw-w-1/2",
              )}
            >
              <a
                href={webServiceUrl("art_search_csv", searchQuery)}
                download
                tabIndex={-1}
              >
                <CenteredButton
                  className={clsx("tw-inline-block")}
                  text="Download Article Search Results"
                />
              </a>
            </p>
          </div>

          <Table>
            <thead>
              <tr>
                <SortableColumn field="Title" text="Title" />
                <SortableColumn field="Authors" text="Author" />
                <SortableColumn
                  style={{ width: "10%" }}
                  field="Journal_Publisher"
                  text="Publication"
                />
                <SortableColumn
                  style={{ width: "10%" }}
                  field="RefDate"
                  text="Year"
                />
                <SortableColumn
                  style={{ width: "10%" }}
                  field="Scale"
                  text="Scale"
                />
                <SortableColumn
                  style={{ width: "10%" }}
                  field="CountSystem"
                  text="#&nbsp;Treatment Systems"
                />
              </tr>
            </thead>
            {sortedTableRows.map((item) => (
              <tbody key={item.Ref_ID}>
                <tr
                  className={clsx(
                    "[&_td]:tw-border-transparent",
                    "[&_td:first-child]:tw-border-l-neutral-400",
                    "[&_td:last-child]:tw-border-r-neutral-400",
                  )}
                >
                  <td>
                    <Link
                      to={`/article-report/${item.Ref_ID}`}
                      title="View Article Summary Report"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {item.Title}
                    </Link>
                  </td>
                  <td>{item.Authors}</td>
                  <td>{item.Journal_Publisher}</td>
                  <td>{item.RefDate}</td>
                  <td>{item.Scale}</td>
                  <td>{item.CountSystem}</td>
                </tr>
                <tr>
                  <td colSpan={6}>
                    <strong>Abstract:</strong> {item.Abstract}
                  </td>
                </tr>
              </tbody>
            ))}
          </Table>
        </>
      )}
    </section>
  );
}
