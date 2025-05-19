import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    SIC: {
      p_sic_code: string; // number as string
      p_sic_desc: string;
      p_sic_code_2_digit: string; // number as string
      p_sic_desc_2_digit: string;
    }[];
  };
};

type Action =
  | { type: "sic/fetch-request" }
  | {
      type: "sic/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "sic/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "sic/set-options";
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
    case "sic/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "sic/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "sic/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "sic/set-options": {
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

export function fetchSicData(): AppThunk {
  return (dispatch: any) => {
    dispatch({ type: "sic/fetch-request" });

    return fetch(webServiceUrl("lookup_sic_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "sic/fetch-success",
          payload: { json },
        });

        const options = json.data.SIC.map((item) => ({
          value: item.p_sic_code,
          label: `${item.p_sic_desc} (${item.p_sic_code})`,
        })).sort((a, b) => {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });

        dispatch({
          type: "sic/set-options",
          payload: { options },
        });
      })
      .catch((err) => {
        dispatch({
          type: "sic/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
