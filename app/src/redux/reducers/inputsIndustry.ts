import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    Industries: {
      psc: string; // number as string
      p_psc_desc: string;
    }[];
  };
};

type Action =
  | { type: "industry/fetch-request" }
  | {
      type: "industry/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "industry/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "industry/set-options";
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
    case "industry/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "industry/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "industry/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "industry/set-options": {
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

export function fetchIndustryData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "industry/fetch-request" });

    return fetch(webServiceUrl("lookup_industry_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "industry/fetch-success",
          payload: { json },
        });

        const options = json.data.Industries.map((item) => ({
          value: item.psc,
          label: item.p_psc_desc,
        })).sort((a, b) => {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });

        dispatch({
          type: "industry/set-options",
          payload: { options },
        });
      })
      .catch((err) => {
        dispatch({
          type: "industry/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
