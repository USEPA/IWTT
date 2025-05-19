import clsx from "clsx";
// ---
import {
  IndustryInfoModalBody,
  TechnologyInfoModalBody,
  PollutantInfoModalBody,
} from "@/components/App";
import { SectionHeading } from "@/components/SectionHeading";
import { CenteredButton } from "@/components/CenteredButton";
import { LoadingIndicator } from "@/components/LoadingIndicator";
import { SearchBlock } from "./components/SearchBlock";
import { SearchFilter } from "./components/SearchFilter";
import { SearchResults } from "./components/SearchResults";
import { SearchModal } from "./components/SearchModal";
import { useAppDispatch, useAppSelector } from "@/redux/index";
import {
  setGuidedSearchInputs,
  fetchGuidedSearchData,
} from "@/redux/reducers/guidedSearch";

export function GuidedSearch() {
  const industryOptions = useAppSelector(
    ({ inputs }) => inputs.industry.options,
  );
  const technologyOptions = useAppSelector(
    ({ inputs }) => inputs.technology.options,
  );
  const pollutantOptions = useAppSelector(
    ({ inputs }) => inputs.pollutant.options,
  );
  const fetchingData = useAppSelector(
    ({ guidedSearch }) => guidedSearch.isFetching,
  );
  const resultsDisplayed = useAppSelector(
    ({ guidedSearch }) => guidedSearch.resultsDisplayed,
  );
  const modalDisplayed = useAppSelector(
    ({ guidedSearch }) => guidedSearch.modal.active,
  );
  const dispatch = useAppDispatch();

  return (
    <section className={clsx("tw-p-4", "print:tw-p-0")}>
      <SectionHeading>Guided Technology Search</SectionHeading>

      <p className={clsx("tw-text-center")}>
        Access pilot and full-scale treatment performance data by industry,
        treatment technology, or pollutant.
      </p>

      <div className={clsx("tw-mt-4 tw-flex tw-flex-wrap")}>
        <SearchBlock
          label="Industry"
          options={industryOptions}
          info={<IndustryInfoModalBody />}
        />

        <SearchBlock
          label="Treatment Technology"
          options={technologyOptions}
          info={<TechnologyInfoModalBody />}
        />

        <SearchBlock
          label="Pollutant"
          options={pollutantOptions}
          info={<PollutantInfoModalBody />}
        />
      </div>

      <div className={clsx("tw-my-4")}>
        <CenteredButton
          text="Search"
          onClick={(_ev) => {
            dispatch(setGuidedSearchInputs());
            dispatch(fetchGuidedSearchData());
          }}
        />

        {resultsDisplayed && (
          <CenteredButton
            className={clsx(
              "tw-mt-4 !tw-bg-neutral-500",
              "hover:!tw-bg-neutral-600",
              "focus:!tw-bg-neutral-600",
            )}
            text="Reset Search Results"
            onClick={(_ev) => dispatch({ type: "guided-search/reset-results" })}
          />
        )}
      </div>

      {fetchingData && <LoadingIndicator text="Searching articles..." />}

      {resultsDisplayed && (
        <>
          <div className={clsx("tw-mt-6 tw-text-center")}>
            <p className={clsx("tw-text-sm tw-font-bold")}>View results by:</p>

            <div
              className={clsx(
                "tw-mx-auto tw-w-fit",
                "md:tw-flex md:tw-justify-center md:tw-gap-4",
              )}
            >
              <SearchFilter label="Industry" />
              <SearchFilter label="Treatment Technology" />
              <SearchFilter label="Pollutant" />
            </div>
          </div>

          <SearchResults />
        </>
      )}

      {modalDisplayed && <SearchModal />}
    </section>
  );
}
