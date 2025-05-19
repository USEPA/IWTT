import { type AppThunk, type SelectOption } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

type JSON = {
  status: "success";
  data: {
    Document_Types: {
      p_document_type: string;
    }[];
  };
};

type Action =
  | { type: "document-type/fetch-request" }
  | {
      type: "document-type/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "document-type/fetch-failure";
      payload: { error: string };
    }
  | {
      type: "document-type/set-options";
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
    case "document-type/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "document-type/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "document-type/fetch-failure": {
      const { error } = action.payload;
      return {
        ...state,
        isFetching: false,
        error,
      };
    }

    case "document-type/set-options": {
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

export function fetchDocumentTypeData(): AppThunk {
  return (dispatch) => {
    dispatch({ type: "document-type/fetch-request" });

    return fetch(webServiceUrl("lookup_doc_type_json"))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "document-type/fetch-success",
          payload: { json },
        });

        const options = json.data.Document_Types.map((item) => ({
          value: item.p_document_type,
          label: item.p_document_type,
        })).sort((a, b) => {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });

        dispatch({
          type: "document-type/set-options",
          payload: { options },
        });
      })
      .catch((err) => {
        dispatch({
          type: "document-type/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
