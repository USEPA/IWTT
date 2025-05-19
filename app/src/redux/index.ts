import { type Action, combineReducers } from "redux";
import { useDispatch, useSelector } from "react-redux";
import { type ThunkAction } from "redux-thunk";
// ---
import { type RootState, type AppDispatch } from "@/redux/store";
import industry from "@/redux/reducers/inputsIndustry";
import technology from "@/redux/reducers/inputsTechnology";
import pollutant from "@/redux/reducers/inputsPollutant";
import year from "@/redux/reducers/inputsYear";
import sic from "@/redux/reducers/inputsSic";
import naics from "@/redux/reducers/inputsNaics";
import category from "@/redux/reducers/inputsCategory";
import documentType from "@/redux/reducers/inputsDocumentType";
import guidedSearch from "@/redux/reducers/guidedSearch";
import articleSearch from "@/redux/reducers/articleSearch";
import articleReport from "@/redux/reducers/articleReport";

export type SelectOption = {
  value: string;
  label: string;
};

const inputs = combineReducers({
  industry,
  technology,
  pollutant,
  year,
  sic,
  naics,
  category,
  documentType,
});

export const rootReducer = combineReducers({
  inputs,
  guidedSearch,
  articleSearch,
  articleReport,
});

export type AppThunk = ThunkAction<void, RootState, unknown, Action<string>>;

export const useAppDispatch = useDispatch.withTypes<AppDispatch>();
export const useAppSelector = useSelector.withTypes<RootState>();
