import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    NAICS: {
      p_naics_code: string; // number as string
      p_naics_desc: string;
    }[];
  };
};

type Action =
  | { type: "naics/fetch-request" }
  | {
      type: "naics/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "naics/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "naics/set-options";
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
    case "naics/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "naics/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "naics/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "naics/set-options": {
      return {
        ...state,
        options: action.payload.options,
      };
    }

    default: {
      return state;
    }
  }
}

export function fetchNaicsData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "naics/fetch-request" });

    return fetch(webServiceUrl("lookup_naics_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "naics/fetch-success",
          payload: { json },
        });

        const options = json.data.NAICS.map((item) => ({
          value: item.p_naics_code,
          label: `${item.p_naics_desc} (${item.p_naics_code})`,
        })).sort((a, b) => {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });

        dispatch({
          type: "naics/set-options",
          payload: { options },
        });
      })
      .catch((err) => {
        dispatch({
          type: "naics/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
