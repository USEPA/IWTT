import clsx from "clsx";
// ---
import {
  IndustryInfoModalBody,
  TechnologyInfoModalBody,
  PollutantInfoModalBody,
} from "@/components/App";
import { FormFieldSelect } from "./FormFieldSelect";
import { FormFieldCheckboxGroup } from "./FormFieldCheckboxGroup";
import { FormFieldCheckbox } from "./FormFieldCheckbox";
import { FormFieldSlider } from "./FormFieldSlider";
import { FormFieldText } from "./FormFieldText";
import { useAppDispatch, useAppSelector } from "@/redux/index";

export function SearchForm() {
  const industryOptions = useAppSelector(
    ({ inputs }) => inputs.industry.options,
  );
  const sicOptions = useAppSelector(({ inputs }) => inputs.sic.options);
  const naicsOptions = useAppSelector(({ inputs }) => inputs.naics.options);
  const technologyOptions = useAppSelector(
    ({ inputs }) => inputs.technology.options,
  );
  const yearOptions = useAppSelector(({ inputs }) => inputs.year.options);
  const pollutantOptions = useAppSelector(
    ({ inputs }) => inputs.pollutant.options,
  );
  const categoryOptions = useAppSelector(
    ({ inputs }) => inputs.category.options,
  );
  const documentTypeOptions = useAppSelector(
    ({ inputs }) => inputs.documentType.options,
  );
  const selectedIndustries = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.industries,
  );
  const selectedSicCodes = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.sic,
  );
  const selectedNaicsCodes = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.naics,
  );
  const selectedTechnologies = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.technologies,
  );
  const selectedScale = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.scale,
  );
  const selectedYears = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.year,
  );
  const selectedPollutants = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.pollutants,
  );
  const removalSelected = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.removal,
  );
  const selectedPercent = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.percent,
  );
  const selectedCategories = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.categories,
  );
  const selectedDocumentTypes = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.documentTypes,
  );
  const keywords = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.keywords,
  );
  const authors = useAppSelector(
    ({ articleSearch }) => articleSearch.inputs.authors,
  );
  const dispatch = useAppDispatch();

  const scaleIsLabOnly =
    selectedScale.length === 1 && selectedScale[0] === "Lab";

  return (
    <div className={clsx("tw-mt-10 tw-flex tw-flex-wrap")}>
      <div className={clsx("tw-w-full", "sm:tw-w-1/2")}>
        <FormFieldSelect
          label="Industry"
          options={industryOptions}
          value={selectedIndustries}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-industries",
              payload: { industries: selection },
            });
          }}
          info={<IndustryInfoModalBody />}
        />

        <FormFieldSelect
          label={
            <>
              <abbr title="Standard Industrial Classification">SIC</abbr> Code
            </>
          }
          options={sicOptions}
          value={selectedSicCodes}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-sic",
              payload: { sic: selection },
            });
          }}
        />

        <FormFieldSelect
          label={
            <>
              <abbr title="North American Industry Classification System">
                NAICS
              </abbr>{" "}
              Code
            </>
          }
          disabled={scaleIsLabOnly}
          options={naicsOptions}
          value={selectedNaicsCodes}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-naics",
              payload: { naics: selection },
            });
          }}
        />

        <FormFieldSelect
          label="Treatment Technology"
          disabled={scaleIsLabOnly}
          options={technologyOptions}
          value={selectedTechnologies}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-technologies",
              payload: { technologies: selection },
            });
          }}
          info={<TechnologyInfoModalBody />}
        />

        <FormFieldCheckboxGroup
          label="Treatment Scale"
          checkboxes={["Full", "Pilot", "Lab"]}
          selectedCheckboxes={selectedScale}
          onChange={(checkbox) => {
            dispatch({
              type: "article-search/set-scale",
              payload: { scale: checkbox },
            });
          }}
        />

        <FormFieldSlider
          label="Publication Date Range"
          options={yearOptions}
          value={selectedYears}
          onChange={(value) => {
            dispatch({
              type: "article-search/set-year",
              payload: { year: value },
            });
          }}
        />
      </div>

      <div className={clsx("tw-w-full", "sm:tw-w-1/2")}>
        <FormFieldSelect
          label="Pollutant"
          disabled={scaleIsLabOnly}
          options={pollutantOptions}
          value={selectedPollutants}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-pollutants",
              payload: { pollutants: selection },
            });
          }}
          info={<PollutantInfoModalBody />}
        />

        <FormFieldCheckbox
          label="Target Pollutant Percent Removal"
          labelHidden
          className={clsx("[&_label]:tw-font-bold")}
          disabled={scaleIsLabOnly}
          checked={removalSelected}
          onChange={() => {
            dispatch({ type: "article-search/set-removal" });
          }}
        />

        {removalSelected && !scaleIsLabOnly && (
          <FormFieldSlider
            label="Target Pollutant Percent Removal"
            labelHidden
            className={clsx("-tw-mt-4")}
            options={[...Array(101).keys()].slice(1)}
            value={selectedPercent}
            onChange={(value) => {
              dispatch({
                type: "article-search/set-percent",
                payload: { percent: value },
              });
            }}
          />
        )}

        <FormFieldSelect
          label="Motivation Category"
          options={categoryOptions}
          value={selectedCategories}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-categories",
              payload: { categories: selection },
            });
          }}
          info={
            <p>
              General categories in IWTT to classify articles based on the
              motivation(s) for evaluating or implementing a treatment system,
              as described in each data source. Each article may have one or
              more motivation categories.
            </p>
          }
        />

        <FormFieldSelect
          label="Document Type"
          options={documentTypeOptions}
          value={selectedDocumentTypes}
          onChange={(selection) => {
            dispatch({
              type: "article-search/set-document-types",
              payload: { documentTypes: selection },
            });
          }}
        />

        <FormFieldText
          label="Keywords"
          value={keywords}
          onChange={(value) => {
            dispatch({
              type: "article-search/set-keywords",
              payload: { keywords: value },
            });
          }}
          info={
            <p>
              Search for specific terms in the Title, Abstract, and Key Findings
              fields of articles stored in IWTT. To search for more than one
              keyword, separate each term with a comma.
            </p>
          }
        />

        <FormFieldText
          label="Authors"
          value={authors}
          onChange={(value) => {
            dispatch({
              type: "article-search/set-authors",
              payload: { authors: value },
            });
          }}
          info={
            <p>
              Search for authors of articles in IWTT. To search for more than
              one author, separate each term with a comma.
            </p>
          }
        />
      </div>
    </div>
  );
}
