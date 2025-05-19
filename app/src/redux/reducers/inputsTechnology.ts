import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    Treatment_Technologies: {
      p_tt_code: string;
      p_tt_desc: string;
      p_tt_cat: string | null;
      p_tt_definition: string | null;
    }[];
  };
};

type Action =
  | { type: "technology/fetch-request" }
  | {
      type: "technology/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "technology/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "technology/set-options";
      payload: { options: SelectOption[] };
    }
  | {
      type: "technology/set-map";
      payload: { map: Record<string, string> };
    };

type State = {
  isFetching: boolean;
  json: JSON | null;
  error: string | null;
  options: SelectOption[];
  map: Record<string, string>;
};

const initialState = {
  isFetching: false,
  json: null,
  error: null,
  options: [],
  map: {},
};

export default function reducer(
  state: State = initialState,
  action: Action,
): State {
  switch (action.type) {
    case "technology/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "technology/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "technology/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "technology/set-options": {
      const { options } = action.payload;
      return {
        ...state,
        options,
      };
    }

    case "technology/set-map": {
      const { map } = action.payload;
      return {
        ...state,
        map,
      };
    }

    default: {
      return state;
    }
  }
}

export function fetchTechnologyData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "technology/fetch-request" });

    return fetch(webServiceUrl("lookup_treat_tech_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "technology/fetch-success",
          payload: { json },
        });

        const options = json.data.Treatment_Technologies.map((item) => ({
          value: item.p_tt_code,
          label: item.p_tt_desc,
        })).sort((a, b) => {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });

        dispatch({
          type: "technology/set-options",
          payload: { options },
        });

        const map = options.reduce(
          (object, option) => {
            object[option.value] = option.label;
            return object;
          },
          {} as Record<string, string>,
        );

        dispatch({
          type: "technology/set-map",
          payload: { map },
        });
      })
      .catch((err) => {
        dispatch({
          type: "technology/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
