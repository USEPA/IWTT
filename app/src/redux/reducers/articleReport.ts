import { type AppThunk } from "@/redux/index";
import { webServiceUrl } from "@/utilities";

export type JSON = {
  status: "success";
  data:
    | {
        "Reference ID": number;
        Title: string;
        Authors: string;
        Main_Author: string;
        Journal_Publisher: string;
        Industry: string[];
        DocumentType: string;
        RefDate: string; // number as string
        MotivationCategory: string[];
        Motivation: string;
        CountSystem: number;
        Scale: string;
        MainParameter: string;
        Abstract: string;
        Key_Findings: string;
        Treatment_Systems: {
          System_ID: number;
          System_Name: string;
          TreatmentSystemScale: string;
          PSC_Code: string; // number as string
          PSC_Desc: string;
          SIC_Code: string; // number as string
          SICName: string;
          Naics_Code: string; // number as string
          NAICSName: string;
          TT_Code: string[];
          Discharge_Designation: null; // TODO: confirm type
          WW_Use: null; // TODO: confirm type
          Treatment_Tech_Description: string;
          Chemical_Addition: null; // TODO: confirm type
          Addt_System_Parameters: string;
          Manufacturer: null; // TODO: confirm type
          Capital_Cost: null; // TODO: confirm type
          OandM_Cost: null; // TODO: confirm type
          Media_Type: null; // TODO: confirm type
          pH_Descriptor: string;
          Low_pH_Range: string; // number as string
          High_pH_Range: string; // number as string
          Parameters: {
            ParamID: number;
            Parameter: string;
            InfluentFlag: null;
            InfluentConcentration: number;
            InfluentUnits: string;
            EffluentFlag: null; // TODO: confirm type
            EffluentConcentration: null; // TODO: confirm type
            EffluentUnits: null; // TODO: confirm type
            ReportedRemovalFlag: null; // TODO: confirm type
            ReportedRemoval: string; // number as string
            CalculatedRemoval: null; // TODO: confirm type
            UpdateRemovalFlag: null; // TODO: confirm type
            UpdatedRemoval: number;
            AnalyticalMethod: string;
            PerformStatID: number;
            PerformStat: string;
            InfluentDL: null; // TODO: confirm type
            InfluentDLUnits: null; // TODO: confirm type
            EffluentDL: null; // TODO: confirm type
            EffluentDLUnits: null; // TODO: confirm type
            ELDescription: null; // TODO: confirm type
            EffluentLimit: null; // TODO: confirm type
            ELUnits: null; // TODO: confirm type
            ELDescription2: null; // TODO: confirm type
            EL2: null; // TODO: confirm type
            ELUnits2: null; // TODO: confirm type
            ELDescription3: null; // TODO: confirm type
            EL3: null; // TODO: confirm type
            ELUnits3: null; // TODO: confirm type
          }[];
        }[];
      }
    | Record<string, never>;
};

type Action =
  | { type: "article-report/fetch-request" }
  | {
      type: "article-report/fetch-success";
      payload: { json: JSON };
    }
  | {
      type: "article-report/fetch-failure";
      payload: { error: string };
    };

type State = {
  isFetching: boolean;
  json: JSON | null;
  error: string | null;
};

const initialState = {
  isFetching: false,
  json: null,
  error: null,
};

export default function reducer(
  state: State = initialState,
  action: Action,
): State {
  switch (action.type) {
    case "article-report/fetch-request": {
      return {
        ...state,
        isFetching: true,
      };
    }

    case "article-report/fetch-success": {
      const { json } = action.payload;
      return {
        ...state,
        isFetching: false,
        json,
      };
    }

    case "article-report/fetch-failure": {
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

export function fetchArticleReportData(id: string): AppThunk {
  return (dispatch) => {
    dispatch({ type: "article-report/fetch-request" });

    return fetch(webServiceUrl("report_json", `p_ref_id=${id}`))
      .then((res) => res.json())
      .then((json: JSON) => {
        dispatch({
          type: "article-report/fetch-success",
          payload: { json },
        });
      })
      .catch((err) => {
        dispatch({
          type: "article-report/fetch-failure",
          payload: { error: err.message },
        });
      });
  };
}
