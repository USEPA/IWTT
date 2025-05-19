import { type ReactElement } from "react";
import Select from "react-select";
import clsx from "clsx";
// ---
import { InfoPopup } from "@/components/InfoPopup";
import {
  type SelectOption,
  useAppDispatch,
  useAppSelector,
} from "@/redux/index";

export function SearchBlock(props: {
  label: string;
  options: SelectOption[];
  info: ReactElement;
}) {
  const { label, options, info } = props;

  const industryValues = useAppSelector(
    ({ guidedSearch }) => guidedSearch.inputs.industries,
  );
  const treatmentTechnologyValues = useAppSelector(
    ({ guidedSearch }) => guidedSearch.inputs.technologies,
  );
  const pollutantValues = useAppSelector(
    ({ guidedSearch }) => guidedSearch.inputs.pollutants,
  );
  const resultsDisplayed = useAppSelector(
    ({ guidedSearch }) => guidedSearch.resultsDisplayed,
  );
  const dispatch = useAppDispatch();

  const value =
    label === "Industry"
      ? industryValues
      : label === "Treatment Technology"
        ? treatmentTechnologyValues
        : label === "Pollutant"
          ? pollutantValues
          : [];

  return (
    <div className={clsx("tw-w-full", "md:tw-w-1/3")}>
      <section className={clsx("tw-p-2")}>
        {!resultsDisplayed && (
          <div
            className={clsx(
              "tw-mx-auto tw-mb-2 tw-h-20 tw-w-20",
              "tw-bg-[url('/assets/img/search-block-icons.svg')]",
              "tw-bg-[length:280px_100px]",
              label === "Industry" && "tw-bg-[position:-10px_-10px]",
              label === "Treatment Technology" && "tw-bg-[position:-100px_-10px]", // prettier-ignore
              label === "Pollutant" && "tw-bg-[position:-190px_-10px]",
            )}
          />
        )}

        <div
          className={clsx(
            "tw-mb-2 tw-flex tw-items-center tw-justify-center tw-gap-1 tw-text-center tw-text-lg tw-font-bold tw-text-neutral-700",
          )}
        >
          {label}
          <InfoPopup modalTitle={label} modalBody={info} />
        </div>

        <Select
          className="iwtt-select"
          classNamePrefix="iwtt-select"
          aria-label={label}
          name={label}
          placeholder={`Search by ${label}...`}
          value={value}
          options={options}
          isMulti={true}
          onChange={(item) => {
            if (label === "Industry") {
              dispatch({
                type: "guided-search/set-industries",
                payload: { industries: item },
              });
            }

            if (label === "Treatment Technology") {
              dispatch({
                type: "guided-search/set-technologies",
                payload: { technologies: item },
              });
            }

            if (label === "Pollutant") {
              dispatch({
                type: "guided-search/set-pollutants",
                payload: { pollutants: item },
              });
            }
          }}
        />
      </section>
    </div>
  );
}
