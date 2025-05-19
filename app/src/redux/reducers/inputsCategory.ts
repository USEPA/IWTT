import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    MotivationCategories: {
      p_motivationcategory: string;
    }[];
  };
};

type Action =
  | { type: "category/fetch-request" }
  | {
      type: "category/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "category/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "category/set-options";
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
    case "category/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "category/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "category/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "category/set-options": {
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

export function fetchCategoryData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "category/fetch-request" });

    return fetch(webServiceUrl("lookup_motiv_cat_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "category/fetch-success",
          payload: { json },
        });

        const options = json.data.MotivationCategories.map((item) => ({
          value: item.p_motivationcategory,
          label: item.p_motivationcategory,
        })).sort((a, b) => {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });

        dispatch({
          type: "category/set-options",
          payload: { options },
        });
      })
      .catch((err) => {
        dispatch({
          type: "category/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
