import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    CountREF_ID: number;
    Reference_Info:
      | {
          Ref_ID: number;
          Authors: string;
          Title: string;
          RefDate: string; // number as string
          Journal_Publisher: string;
          Abstract: string;
          Scale: string;
          CountSystem: number;
        }[]
      | null;
  };
};

type Action =
  | {
      type: "article-search/set-publication-range";
      payload: { publicationRange: [number, number] };
    }
  | {
      type: "article-search/set-industries";
      payload: { industries: SelectOption[] };
    }
  | {
      type: "article-search/set-technologies";
      payload: { technologies: SelectOption[] };
    }
  | {
      type: "article-search/set-scale";
      payload: { scale: string };
    }
  | {
      type: "article-search/set-pollutants";
      payload: { pollutants: SelectOption[] };
    }
  | {
      type: "article-search/set-percent";
      payload: { percent: [number, number] };
    }
  | { type: "article-search/set-removal" }
  | {
      type: "article-search/set-sic";
      payload: { sic: SelectOption[] };
    }
  | {
      type: "article-search/set-naics";
      payload: { naics: SelectOption[] };
    }
  | {
      type: "article-search/set-year";
      payload: { year: [number, number] };
    }
  | {
      type: "article-search/set-categories";
      payload: { categories: SelectOption[] };
    }
  | {
      type: "article-search/set-document-types";
      payload: { documentTypes: SelectOption[] };
    }
  | {
      type: "article-search/set-keywords";
      payload: { keywords: string };
    }
  | {
      type: "article-search/set-authors";
      payload: { authors: string };
    }
  | {
      type: "article-search/set-query";
      payload: { searchQuery: string };
    }
  | { type: "article-search/reset-results" }
  | { type: "article-search/fetch-request" }
  | {
      type: "article-search/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "article-search/fetch-failure";
      payload: { error: string };
    };

type State = {
  isFetching: boolean;
  json: JSON | null;
  error: string | null;
  publicationRange: [number, number];
  inputs: {
    industries: SelectOption[];
    technologies: SelectOption[];
    scale: string[];
    pollutants: SelectOption[];
    removal: boolean;
    percent: [number, number];
    sic: SelectOption[];
    naics: SelectOption[];
    year: [number, number];
    categories: SelectOption[];
    documentTypes: SelectOption[];
    keywords: string;
    authors: string;
  };
  searchQuery: string;
  resultsDisplayed: boolean;
};

export const initialState = {
  isFetching: false,
  json: null,
  error: null,
  publicationRange: [-Infinity, Infinity] as [number, number],
  inputs: {
    industries: [],
    technologies: [],
    scale: ["Full", "Pilot"],
    pollutants: [],
    removal: false,
    percent: [1, 100] as [number, number],
    sic: [],
    naics: [],
    year: [-Infinity, Infinity] as [number, number],
    categories: [],
    documentTypes: [],
    keywords: "",
    authors: "",
  },
  searchQuery: "",
  resultsDisplayed: false,
};

export default function reducer(
  state: State = initialState,
  action: Action,
): State {
  switch (action.type) {
    case "article-search/set-publication-range": {
      const { publicationRange } = action.payload;
      return {
        ...state,
        publicationRange,
      };
    }

    case "article-search/set-industries": {
      const { industries } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          industries,
        },
      };
    }

    case "article-search/set-technologies": {
      const { technologies } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          technologies,
        },
      };
    }

    case "article-search/set-scale": {
      const { scale } = action.payload;

      return {
        ...state,
        inputs: {
          ...state.inputs,
          scale: state.inputs.scale.includes(scale)
            ? state.inputs.scale.filter((item) => item !== scale)
            : [...state.inputs.scale, scale],
        },
      };
    }

    case "article-search/set-pollutants": {
      const { pollutants } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          pollutants,
        },
      };
    }

    case "article-search/set-removal": {
      const { removal } = state.inputs;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          removal: !removal,
        },
      };
    }

    case "article-search/set-percent": {
      const { percent } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          percent,
        },
      };
    }

    case "article-search/set-sic": {
      const { sic } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          sic,
        },
      };
    }

    case "article-search/set-naics": {
      const { naics } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          naics,
        },
      };
    }

    case "article-search/set-year": {
      const { year } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          year,
        },
      };
    }

    case "article-search/set-categories": {
      const { categories } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          categories,
        },
      };
    }

    case "article-search/set-document-types": {
      const { documentTypes } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          documentTypes,
        },
      };
    }

    case "article-search/set-keywords": {
      const { keywords } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          keywords,
        },
      };
    }

    case "article-search/set-authors": {
      const { authors } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          authors,
        },
      };
    }

    case "article-search/set-query": {
      const { searchQuery } = action.payload;
      return {
        ...state,
        searchQuery,
      };
    }

    case "article-search/reset-results": {
      const { publicationRange } = state;
      return {
        ...state,
        json: null,
        inputs: {
          ...initialState.inputs,
          year: publicationRange,
        },
        searchQuery: "",
        resultsDisplayed: false,
      };
    }

    case "article-search/fetch-request": {
      return {
        ...state,
        isFetching: true,
        json: null,
        error: null,
        resultsDisplayed: false,
      };
    }

    case "article-search/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
        resultsDisplayed: true,
      };
    }

    case "article-search/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    default: {
      return state;
    }
  }
}

export function fetchArticleSearchData(): AppThunk {
  return (dispatch, getState) => {
    const {
      industries,
      technologies,
      scale,
      pollutants,
      removal,
      percent,
      sic,
      naics,
      year,
      categories,
      documentTypes,
      keywords,
      authors,
    } = getState().articleSearch.inputs;

    const scaleIsLabOnly = scale.length === 1 && scale[0] === "Lab";
    // if 'Treatment Scale' is 'Lab' only, the following fields are disabled:
    // 'Treatment Technology', 'Pollutant', 'Target Pollutant Percent Removal', 'NAICS Code'

    const paramsList = [];

    paramsList.push(`p_year_min=${year[0]}&p_year_max=${year[1]}`);

    if (industries.length > 0) {
      const value = industries.map((item) => item.value).join(";");
      paramsList.push(`p_point_source_category_code=${value}`);
    }

    if (technologies.length > 0 && !scaleIsLabOnly) {
      const value = technologies.map((item) => item.value).join(";");
      paramsList.push(`p_treatment_technology_code=${value}`);
    }

    if (scale.length > 0) {
      const value = scale.join(";");
      paramsList.push(`p_treatment_scale=${value}`);
    }

    /* prettier-ignore */
    if (pollutants.length > 0 && !scaleIsLabOnly) {
      const value = pollutants.map((item) => encodeURIComponent(item.value)).join(';');
      paramsList.push(`p_pollutant_search_term=${value}`);
    }

    /* prettier-ignore */
    if (removal && percent && !scaleIsLabOnly) {
      paramsList.push(`p_percent_removal_flag=Y&p_percent_min=${percent[0]}&p_percent_max=${percent[1]}`,);
    }

    if (sic) {
      const value = sic.map((item) => item.value).join(";");
      if (value) paramsList.push(`p_sic=${value}`);
    }

    if (naics && !scaleIsLabOnly) {
      const value = naics.map((item) => item.value).join(";");
      if (value) paramsList.push(`p_naics=${value}`);
    }

    /* prettier-ignore */
    if (categories.length > 0) {
      const value = categories.map((item) => encodeURIComponent(item.value)).join(";");
      paramsList.push(`p_motivation_category=${value}`);
    }

    /* prettier-ignore */
    if (documentTypes.length > 0) {
      const value = documentTypes.map((item) => encodeURIComponent(item.value)).join(";");
      paramsList.push(`p_document_type=${value}`);
    }

    /* prettier-ignore */
    if (keywords) {
      const value = keywords.split(/[ ,]+/).map((item) => encodeURIComponent(item)).join(';');
      paramsList.push(`p_keyword=${value}`);
    }

    /* prettier-ignore */
    if (authors) {
      const value = authors.split(/[ ,]+/).map((item) => encodeURIComponent(item)).join(';');
      paramsList.push(`p_author=${value}`);
    }

    const queryString = paramsList.join("&");

    /* set article search query to be used by CSV download */
    dispatch({
      type: "article-search/set-query",
      payload: { searchQuery: queryString },
    });

    dispatch({ type: "article-search/fetch-request" });

    return fetch(webServiceUrl("art_search_json", queryString))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "article-search/fetch-success",
          payload: { json },
        });
      })
      .catch((err) => {
        dispatch({
          type: "article-search/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
