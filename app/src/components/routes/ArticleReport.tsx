import { Fragment, useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";
import { LoadingIndicator } from "@/components/LoadingIndicator";
import { Details, Summary } from "@/components/Disclosure";
import { Table } from "@/components/Table";
import { Message } from "@/components/Message";
import { useAppDispatch, useAppSelector } from "@/redux/index";
import {
  type JSON,
  fetchArticleReportData,
} from "@/redux/reducers/articleReport";
import { displayEmptyValue } from "@/utilities";

type JsonData = Exclude<JSON["data"], Record<string, never>>;

function formatNumber(input: number) {
  return input.toLocaleString(undefined, {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

function formatTreatmentTrain(options: {
  input: string[];
  map: Record<string, string>;
}) {
  const { input, map } = options;

  return input.map((item, index) => {
    const delimiter = input.length - index > 1 ? "\xa0\xa0➝\xa0\xa0" : "";
    return (
      <span key={index}>
        {map[item]} ({item}){delimiter}
      </span>
    );
  });
}

function maybe(value: string | number | null) {
  return value != null ? value : displayEmptyValue();
}

function FieldHeading(props: { children: React.ReactNode }) {
  const { children } = props;
  return (
    <h3
      className={clsx(
        "tw-mb-0.5 tw-font-[inherit] tw-text-sm tw-font-bold tw-leading-none",
      )}
    >
      {children}
    </h3>
  );
}

function ArticleReportContent(props: { reportId: string; json: JSON }) {
  const { reportId, json } = props;
  const technologyMap = useAppSelector(({ inputs }) => inputs.technology.map);

  /* parameter removal details table rows */
  const [detailsOpenBySystem, setDetailsOpenBySystem] = useState<{
    [key: number]: boolean;
  }>({});

  if (Object.keys(json.data).length === 0) {
    return (
      <Message>
        <p>Article Report with ID of {reportId} does not exist.</p>
      </Message>
    );
  }

  const data = json.data as JsonData;

  return (
    <>
      <Details>
        <Summary>Key Information</Summary>

        <section
          className={clsx(
            "tw-flex tw-flex-wrap tw-border tw-border-neutral-400 tw-p-2",
            "print:tw-border-0 print:tw-p-0",
          )}
        >
          <div className={clsx("tw-w-full tw-p-2")}>
            <section className="iwtt-field">
              <FieldHeading>Title</FieldHeading>
              <p>{maybe(data.Title)}</p>
            </section>
          </div>

          <div className={clsx("tw-w-full tw-p-2")}>
            <section className="iwtt-field">
              <FieldHeading>Authors</FieldHeading>
              <p>{maybe(data.Authors)}</p>
            </section>
          </div>

          <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
            <section className="iwtt-field">
              <FieldHeading>Main Author Affiliation</FieldHeading>
              <p>{maybe(data.Main_Author)}</p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Motivation Category</FieldHeading>
              <p>
                {data.MotivationCategory
                  ? data.MotivationCategory.join(", ")
                  : displayEmptyValue()}
              </p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Motivation</FieldHeading>
              <p>{maybe(data.Motivation)}</p>
            </section>
          </div>

          <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
            <section className="iwtt-field">
              <FieldHeading>Journal / Publisher / Conference</FieldHeading>
              <p>{maybe(data.Journal_Publisher)}</p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Document Type</FieldHeading>
              <p>{maybe(data.DocumentType)}</p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Year</FieldHeading>
              <p>{maybe(data.RefDate)}</p>
            </section>
          </div>

          <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
            <section className="iwtt-field">
              <FieldHeading>Industry</FieldHeading>
              <p>
                {data.Industry ? data.Industry.join(", ") : displayEmptyValue()}
              </p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Number of Treatment Systems</FieldHeading>
              <p>{maybe(data.CountSystem)}</p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Scale</FieldHeading>
              <p>{maybe(data.Scale)}</p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Key Parameters</FieldHeading>
              <p>{maybe(data.MainParameter)}</p>
            </section>
          </div>
        </section>
      </Details>

      <Details>
        <Summary>Summary</Summary>

        <section
          className={clsx(
            "tw-flex tw-flex-wrap tw-border tw-border-neutral-400 tw-p-2",
            "print:tw-border-0 print:tw-p-0",
          )}
        >
          <div className={clsx("tw-w-full tw-p-2")}>
            <section className="iwtt-field">
              <FieldHeading>Abstract</FieldHeading>
              <p>{maybe(data.Abstract)}</p>
            </section>

            <section className="iwtt-field">
              <FieldHeading>Key Findings</FieldHeading>
              <p>{maybe(data.Key_Findings)}</p>
            </section>
          </div>
        </section>
      </Details>

      {data.Treatment_Systems?.sort((a, b) => a.System_ID - b.System_ID).map(
        (t) => (
          <Fragment key={t.System_ID}>
            <Details>
              <Summary>Treatment System {t.System_ID}</Summary>

              <section
                className={clsx(
                  "tw-flex tw-flex-wrap tw-border tw-border-neutral-400 tw-p-2",
                  "print:tw-border-0 print:tw-p-0",
                )}
              >
                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>Point Source Category</FieldHeading>
                    <p>
                      {maybe(t.PSC_Desc)} ({t.PSC_Code})
                    </p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>SIC</FieldHeading>
                    <p>
                      {maybe(t.SICName)} ({t.SIC_Code})
                    </p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>NAICS</FieldHeading>
                    <p>
                      {maybe(t.NAICSName)} ({t.Naics_Code})
                    </p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>Scale</FieldHeading>
                    <p>{maybe(t.TreatmentSystemScale)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>Wastewater Discharge Type</FieldHeading>
                    <p>{maybe(t.Discharge_Designation)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>Treated Effluent Destination</FieldHeading>
                    <p>{maybe(t.WW_Use)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2")}>
                  <section className="iwtt-field">
                    <FieldHeading>Treatment Train</FieldHeading>
                    <p>
                      {formatTreatmentTrain({
                        input: t.TT_Code,
                        map: technologyMap,
                      })}
                    </p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2")}>
                  <section className="iwtt-field">
                    <FieldHeading>System Description</FieldHeading>
                    <p>{maybe(t.Treatment_Tech_Description)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2")}>
                  <section className="iwtt-field">
                    <FieldHeading>Chemical Addition</FieldHeading>
                    <p>{maybe(t.Chemical_Addition)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2")}>
                  <section className="iwtt-field">
                    <FieldHeading>Other Relevant Parameters</FieldHeading>
                    <p>{maybe(t.Addt_System_Parameters)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>Manufacturer</FieldHeading>
                    <p>{maybe(t.Manufacturer)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>Capital Cost</FieldHeading>
                    <p>{maybe(t.Capital_Cost)}</p>
                  </section>
                </div>

                <div className={clsx("tw-w-full tw-p-2", "md:tw-w-1/3")}>
                  <section className="iwtt-field">
                    <FieldHeading>O&M Cost</FieldHeading>
                    <p>{maybe(t.OandM_Cost)}</p>
                  </section>
                </div>

                {t.Parameters && (
                  <div className={clsx("tw-w-full tw-p-2")}>
                    <section className={clsx("iwtt-field", "tw-relative")}>
                      <FieldHeading>Parameter Removal Information</FieldHeading>

                      <button
                        className={clsx(
                          "tw-absolute tw-right-0 tw-top-0 tw-cursor-pointer tw-text-xs tw-text-[#005ea2]",
                          "hover:tw-text-[#1a4480]",
                          "focus:tw-text-[#1a4480]",
                          "print:tw-hidden",
                        )}
                        type="button"
                        title="Toggle table rows"
                        onClick={(_ev) => {
                          setDetailsOpenBySystem({
                            ...detailsOpenBySystem,
                            [t.System_ID]: !detailsOpenBySystem[t.System_ID],
                          });
                        }}
                      >
                        {detailsOpenBySystem[t.System_ID]
                          ? "Collapse all rows [–]"
                          : "Expand all rows [+]"}
                      </button>

                      <Table className={clsx("!tw-mt-2")}>
                        <thead>
                          <tr>
                            <th>Parameter</th>
                            <th style={{ width: "18.75%" }}>Influent</th>
                            <th style={{ width: "18.75%" }}>Effluent</th>
                            <th style={{ width: "18.75%" }}>% Removal</th>
                          </tr>
                        </thead>

                        {t.Parameters.map((parameter) => {
                          return (
                            <Fragment key={parameter.ParamID}>
                              <TreatmentSystemParameter
                                detailsOpen={detailsOpenBySystem[t.System_ID]}
                                p={parameter}
                              />
                            </Fragment>
                          );
                        })}
                      </Table>
                    </section>
                  </div>
                )}
              </section>
            </Details>
          </Fragment>
        ),
      )}
    </>
  );
}

function TreatmentSystemParameter(props: {
  detailsOpen: boolean;
  p: JsonData["Treatment_Systems"][number]["Parameters"][number];
}) {
  const { detailsOpen, p } = props;

  const influentConcentration =
    p.InfluentConcentration != null
      ? `${p.InfluentFlag || ""} ${p.InfluentConcentration} ${p.InfluentUnits}`
      : p.InfluentFlag != null
        ? p.InfluentFlag
        : displayEmptyValue();

  const effluentConcentration =
    p.EffluentConcentration != null
      ? `${p.EffluentFlag || ""} ${p.EffluentConcentration} ${p.EffluentUnits}`
      : p.EffluentFlag != null
        ? p.EffluentFlag
        : displayEmptyValue();

  const percentRemoval = p.UpdatedRemoval
    ? `${p.UpdateRemovalFlag || ""} ` +
      `${formatNumber(p.UpdatedRemoval) === "100.00" ? "100" : formatNumber(p.UpdatedRemoval)}` // prettier-ignore
    : displayEmptyValue();

  return (
    <tbody>
      <tr>
        <td className={clsx("!tw-pl-6")}>{p.Parameter}</td>
        <td>{influentConcentration}</td>
        <td>{effluentConcentration}</td>
        <td>{percentRemoval}</td>
      </tr>

      <tr>
        <td className={clsx("!tw-p-0")} colSpan={4}>
          <details className={clsx("tw-relative")} open={detailsOpen}>
            {/* NOTE: empty summary element covers the row above */}
            <summary
              className={clsx(
                "tw-absolute -tw-top-8 tw-w-full tw-cursor-pointer tw-px-2.5 tw-py-2",
              )}
            />

            <section className={clsx("tw-flex tw-flex-wrap")}>
              <div className={clsx("tw-w-full tw-p-2", "sm:tw-w-1/2")}>
                <section className="iwtt-field">
                  <FieldHeading>Analytical Method</FieldHeading>
                  <p>{maybe(p.AnalyticalMethod)}</p>
                </section>

                <section className="iwtt-field">
                  <FieldHeading>Detection Limits</FieldHeading>
                  <p>
                    <em>Influent:</em> {maybe(p.InfluentDL)}{" "}
                    {p.InfluentDL && p.InfluentDLUnits}
                  </p>
                  <p>
                    <em>Effluent:</em> {maybe(p.EffluentDL)}{" "}
                    {p.EffluentDL && p.EffluentDLUnits}
                  </p>
                </section>
              </div>

              <div className={clsx("tw-w-full tw-p-2", "sm:tw-w-1/2")}>
                <section className="iwtt-field">
                  <FieldHeading>Statistical Basis</FieldHeading>
                  <p>{maybe(p.PerformStat)}</p>
                </section>

                <section className="iwtt-field">
                  <FieldHeading>
                    Effluent Limit/Treatment Goal/Standards
                  </FieldHeading>
                  <p>
                    <em>Limit 1:</em>{" "}
                    {p.EffluentLimit
                      ? `${p.ELDescription} – ${p.EffluentLimit} ${p.ELUnits}`
                      : displayEmptyValue()}
                  </p>
                  <p>
                    <em>Limit 2:</em>{" "}
                    {p.EL2
                      ? `${p.ELDescription2} – ${p.EL2} ${p.ELUnits2}`
                      : displayEmptyValue()}
                  </p>
                  <p>
                    <em>Limit 3:</em>{" "}
                    {p.EL3
                      ? `${p.ELDescription3} – ${p.EL3} ${p.ELUnits3}`
                      : displayEmptyValue()}
                  </p>
                </section>
              </div>
            </section>
          </details>
        </td>
      </tr>
    </tbody>
  );
}

export function ArticleReport() {
  const { reportId } = useParams();

  const json = useAppSelector(({ articleReport }) => articleReport.json);
  const dispatch = useAppDispatch();

  useEffect(() => {
    if (reportId) dispatch(fetchArticleReportData(reportId));
  }, [reportId]);

  if (!reportId) return null;

  return (
    <section
      className={clsx(
        "tw-p-4",
        "[&_p]:tw-text-sm",
        "[&_.iwtt-field:not(:first-child)]:tw-mt-4",
        "print:tw-p-0",
      )}
    >
      <SectionHeading>Article Summary Report</SectionHeading>

      {!json ? (
        <LoadingIndicator text="Loading Article Report..." />
      ) : (
        <ArticleReportContent reportId={reportId} json={json} />
      )}
    </section>
  );
}
