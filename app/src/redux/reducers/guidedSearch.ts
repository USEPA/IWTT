import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type SearchParams = {
  industry: string;
  technology: string;
  pollutant: string;
};

type LastSearch = {
  industries: string[];
  technologies: string[];
  pollutants: string[];
};

type JSON = {
  status: "success";
  data: {
    CountIndustry: number;
    CountSystem: number;
    CountSystemFull: number;
    CountSystemPilot: number;
    CountPollutant: number;
    Industries: {
      PSCCode: string; // string as number
      PSCName: string;
      CountSystembyInd: number;
      CountPollbyInd: number;
    }[];
    Technologies: {
      TreatmentTech: string;
      TreatmentTechCode: string;
      CountSystembyTech: number;
      CountIndbyTech: number;
      CountPollbyTech: number;
    }[];
    Pollutants: {
      ParameterName: string;
      CountSystembyPoll: number;
      CountIndbyPoll: number;
    }[];
    Details: {
      PSCName: string;
      ScaleSystem: string;
      TreatmentSystem: string[];
      ParameterName: string;
      InfluentFlag: null; // TODO: confirm type
      InfluentConcentration: number;
      EffluentFlag: null; // TODO: confirm type
      EffluentConcentration: null; // TODO: confirm type
      Units: null; // TODO: confirm type
      UpdateRemovalFlag: null; // TODO: confirm type
      UpdateRemoval: number;
      Author: string;
      MainAuthor: string;
      Year: string; // number as string
      Ref_ID: number;
      System_Name: string;
      Parameter_ID: number;
    }[];
  };
};

type Action =
  | {
      type: "guided-search/set-industries";
      payload: { industries: SelectOption[] };
    }
  | {
      type: "guided-search/set-technologies";
      payload: { technologies: SelectOption[] };
    }
  | {
      type: "guided-search/set-pollutants";
      payload: { pollutants: SelectOption[] };
    }
  | {
      type: "guided-search/set-filter";
      payload: { filter: string };
    }
  | {
      type: "guided-search/set-params";
      payload: { searchParams: SearchParams };
    }
  | { type: "guided-search/reset-results" }
  | {
      type: "guided-search/display-modal";
      payload: { modalTitle: string };
    }
  | { type: "guided-search/close-modal" }
  | { type: "guided-search/fetch-request" }
  | {
      type: "guided-search/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "guided-search/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "guided-search/set-last-inputs";
      payload: { lastSearch: LastSearch };
    };

type State = {
  isFetching: boolean;
  json: JSON | null;
  error: string | null;
  inputs: {
    industries: SelectOption[];
    technologies: SelectOption[];
    pollutants: SelectOption[];
  };
  filter: string;
  searchParams: SearchParams;
  resultsDisplayed: boolean;
  modal: {
    active: boolean;
    title: string;
  };
  lastSearch: {
    industries: string[];
    technologies: string[];
    pollutants: string[];
  };
};

export const initialState = {
  isFetching: false,
  json: null,
  error: null,
  inputs: {
    industries: [],
    technologies: [],
    pollutants: [],
  },
  filter: "Industry",
  searchParams: {
    industry: "",
    technology: "",
    pollutant: "",
  },
  resultsDisplayed: false,
  modal: {
    active: false,
    title: "",
  },
  lastSearch: {
    industries: [],
    technologies: [],
    pollutants: [],
  },
};

export default function reducer(
  state: State = initialState,
  action: Action,
): State {
  switch (action.type) {
    case "guided-search/set-industries": {
      const { industries } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          industries,
        },
      };
    }

    case "guided-search/set-technologies": {
      const { technologies } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          technologies,
        },
      };
    }

    case "guided-search/set-pollutants": {
      const { pollutants } = action.payload;
      return {
        ...state,
        inputs: {
          ...state.inputs,
          pollutants,
        },
      };
    }

    case "guided-search/set-filter": {
      const { filter } = action.payload;
      return {
        ...state,
        filter,
      };
    }

    case "guided-search/set-params": {
      const { searchParams } = action.payload;
      return {
        ...state,
        searchParams,
      };
    }

    case "guided-search/reset-results": {
      const { inputs, filter, searchParams, resultsDisplayed, modal } =
        initialState;
      return {
        ...state,
        inputs,
        filter,
        searchParams,
        resultsDisplayed,
        modal,
      };
    }

    case "guided-search/display-modal": {
      const { modalTitle } = action.payload;
      return {
        ...state,
        modal: {
          active: true,
          title: modalTitle,
        },
      };
    }

    case "guided-search/close-modal": {
      const { modal } = initialState;
      return {
        ...state,
        modal,
      };
    }

    case "guided-search/fetch-request": {
      return {
        ...state,
        isFetching: true,
        json: null,
        error: null,
        resultsDisplayed: false,
      };
    }

    case "guided-search/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
        resultsDisplayed: true,
      };
    }

    case "guided-search/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "guided-search/set-last-inputs": {
      const { lastSearch } = action.payload;
      return {
        ...state,
        lastSearch,
      };
    }

    default: {
      return state;
    }
  }
}

export function fetchGuidedSearchData(): AppThunk {
  return (dispatch, getState) => {
    const { industries, technologies, pollutants } =
      getState().guidedSearch.inputs;

    let industryParam = "";
    let technologyParam = "";
    let pollutantParam = "";

    let paramsList = [];

    if (industries.length > 0) {
      industryParam = industries.map((item) => item.value).join(";");
      paramsList.push(`p_point_source_category_code=${industryParam}`);
    }

    if (technologies.length > 0) {
      technologyParam = technologies.map((item) => item.value).join(";");
      paramsList.push(`p_treatment_technology_code=${technologyParam}`);
    }

    /* prettier-ignore */
    if (pollutants.length > 0) {
      pollutantParam = pollutants.map((item) => encodeURIComponent(item.value)).join(';');
      paramsList.push(`p_pollutant_search_term=${pollutantParam}`);
    }

    const queryString = paramsList.join("&");

    /* set guided search params to be used by CSV download */
    const searchParams = {
      industry: industryParam,
      technology: technologyParam,
      pollutant: pollutantParam,
    };

    dispatch({
      type: "guided-search/set-params",
      payload: { searchParams },
    });

    dispatch({ type: "guided-search/fetch-request" });

    return fetch(webServiceUrl("guid_search_json", queryString))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "guided-search/fetch-success",
          payload: { json },
        });
      })
      .catch((err) => {
        dispatch({
          type: "guided-search/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}

export function setGuidedSearchInputs(): AppThunk {
  return (dispatch, getState) => {
    const { industries, technologies, pollutants } =
      getState().guidedSearch.inputs;

    const lastSearch = {
      industries: industries.map((item) => item.label),
      technologies: technologies.map((item) => item.label),
      pollutants: pollutants.map((item) => item.label),
    };

    dispatch({
      type: "guided-search/set-last-inputs",
      payload: { lastSearch },
    });
  };
}
