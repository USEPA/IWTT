import { type AppThunk } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    p_min_year: string; // number as string
    p_max_year: string; // number as string
  };
};

type Action =
  | { type: "year/fetch-request" }
  | {
      type: "year/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "year/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "year/set-options";
      payload: { options: number[] };
    };

type State = {
  isFetching: boolean;
  json: JSON | null;
  error: string | null;
  options: number[];
};

const initialState = {
  isFetching: false,
  json: null,
  error: null,
  options: [],
};

export default function reducer(
  state: State = initialState,
  action: Action,
): State {
  switch (action.type) {
    case "year/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "year/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "year/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "year/set-options": {
      const { options } = action.payload;
      return {
        ...state,
        options,
      };
    }

    default: {
      return state;
    }
  }
}

export function fetchYearData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "year/fetch-request" });

    return fetch(webServiceUrl("lookup_year_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "year/fetch-success",
          payload: { json },
        });

        const minYear = Number(json.data.p_min_year);
        const maxYear = Number(json.data.p_max_year);

        const options = Array.from(
          { length: maxYear - minYear + 1 },
          (_, index) => index + minYear,
        );

        dispatch({
          type: "year/set-options",
          payload: { options },
        });

        dispatch({
          type: "article-search/set-publication-range",
          payload: { publicationRange: [minYear, maxYear] },
        });

        dispatch({
          type: "article-search/set-year",
          payload: { year: [minYear, maxYear] },
        });
      })
      .catch((err) => {
        dispatch({
          type: "year/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
