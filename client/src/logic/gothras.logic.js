import { api } from "../api/apiClient";

export const getGothras    = ()         => api(`/gothras`);
export const createGothra  = (data)     => api(`/gothras`,      { method: "POST", body: JSON.stringify(data) });
export const updateGothra  = (id, data) => api(`/gothras/${id}`, { method: "PUT",  body: JSON.stringify(data) });