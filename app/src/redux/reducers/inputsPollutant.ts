import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    Parameter_Codes: {
      p_pollutant_search_term: string;
      p_parameter: number;
      p_parameter_desc: string;
      p_CAS: number | null;
    }[];
  };
};

type Action =
  | { type: "pollutant/fetch-request" }
  | {
      type: "pollutant/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "pollutant/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "pollutant/set-options";
      payload: { options: SelectOption[] };
    };

type State = {
  isFetching: boolean;
  json: JSON | null;
  error: string | null;
  options: SelectOption[];
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
    case "pollutant/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "pollutant/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "pollutant/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "pollutant/set-options": {
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

export function fetchPollutantData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "pollutant/fetch-request" });

    return fetch(webServiceUrl("lookup_parameter_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "pollutant/fetch-success",
          payload: { json },
        });

        const pollutants = json.data.Parameter_Codes.map((item) => {
          return item.p_pollutant_search_term;
        });

        const options = [...new Set(pollutants)].sort().map((item) => ({
          value: item,
          label: item,
        }));

        dispatch({
          type: "pollutant/set-options",
          payload: { options },
        });
      })
      .catch((err) => {
        dispatch({
          type: "pollutant/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
