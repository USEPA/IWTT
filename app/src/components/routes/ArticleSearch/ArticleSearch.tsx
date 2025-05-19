import clsx from "clsx";
// ---
import { SectionHeading } from "@/components/SectionHeading";
import { CenteredButton } from "@/components/CenteredButton";
import { LoadingIndicator } from "@/components/LoadingIndicator";
import { SearchForm } from "./components/SearchForm";
import { SearchResults } from "./components/SearchResults";
import { useAppDispatch, useAppSelector } from "@/redux/index";
import { fetchArticleSearchData } from "@/redux/reducers/articleSearch";

export function ArticleSearch() {
  const fetchingData = useAppSelector(
    ({ articleSearch }) => articleSearch.isFetching,
  );
  const resultsDisplayed = useAppSelector(
    ({ articleSearch }) => articleSearch.resultsDisplayed,
  );
  const dispatch = useAppDispatch();

  return (
    <section className={clsx("tw-p-4", "print:tw-p-0")}>
      <SectionHeading>Article Search</SectionHeading>

      <SearchForm />

      <div className={clsx("tw-my-4")}>
        <CenteredButton
          text="Search"
          onClick={(_ev) => dispatch(fetchArticleSearchData())}
        />

        {resultsDisplayed && (
          <CenteredButton
            className={clsx(
              "tw-mt-4 !tw-bg-neutral-500",
              "hover:!tw-bg-neutral-600",
              "focus:!tw-bg-neutral-600",
            )}
            text="Reset Search Results"
            onClick={(_ev) => {
              dispatch({ type: "article-search/reset-results" });
            }}
          />
        )}
      </div>

      {fetchingData && <LoadingIndicator text="Searching articles..." />}

      {resultsDisplayed && <SearchResults />}
    </section>
  );
}
