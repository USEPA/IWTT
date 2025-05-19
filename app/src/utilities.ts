import { type ReactNode, useEffect } from "react";
// ---
const {
  VITE_WEB_SERVICE_URL: url,
  VITE_WEB_SERVICE_PREFIX: prefix,
  VITE_WEB_SERVICE_SUFFIX: suffix,
  VITE_WEB_SERVICE_PARAMS: params,
} = import.meta.env;

export function webServiceUrl(endpoint: string, queryString?: string) {
  const searchParams = queryString
    ? params
      ? `?${queryString}&${params}`
      : `?${queryString}`
    : params
      ? `?${params}`
      : "";

  return url + prefix + endpoint + suffix + searchParams;
}

export function getNodeText(node: ReactNode): string {
  if (typeof node === "string" || typeof node === "number") {
    return node.toString();
  }

  if (typeof node === "boolean") {
    return "";
  }

  if (typeof node === "object" && node !== null) {
    if (node instanceof Array) {
      return node.map(getNodeText).join("");
    }

    if ("props" in node) {
      return getNodeText(node.props.children);
    }
  }

  return "";
}

export const displayEmptyValue = () => "---";

export function compareObjectsByField(options: {
  field: string;
  reverse: boolean;
}) {
  const { field, reverse } = options;

  return (objA: Object, objB: Object) => {
    // check if property exists on either object
    if (!objA.hasOwnProperty(field) || !objB.hasOwnProperty(field)) return 0;

    // get values from passed field of adjacent objects (normalize strings)
    const objAValue = objA[field as keyof typeof objA];
    const objBValue = objB[field as keyof typeof objB];

    let a =
      typeof objAValue === "string"
        ? (objAValue as unknown as string).toUpperCase()
        : objAValue;

    let b =
      typeof objBValue === "string"
        ? (objBValue as unknown as string).toUpperCase()
        : objBValue;

    // redefine null/undefined values, so they're sorted first
    if (a == null && typeof b === "string") a = " ";
    if (b == null && typeof a === "string") b = " ";

    // set 'value' by comparing values of passed fields of adjacent objects
    let value = 0;
    if (a < b) value = -1;
    if (a > b) value = 1;

    // conditionally reverse sort if passed 'reverse' param is true
    return reverse ? value * -1 : value;
  };
}

export function useScrollToHash() {
  useEffect(() => {
    const hash = window.location.hash.slice(1);
    if (!hash) return;

    const element = document.getElementById(hash);
    if (!element) return;

    element.scrollIntoView({ behavior: "smooth" });
  }, []);
}
