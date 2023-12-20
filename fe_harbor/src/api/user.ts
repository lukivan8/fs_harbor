import { axiosInstance } from "./axios";

interface RegisterData {
    email: string;
    password: string;
    password_confirmation: string;
}

export interface TokenResponse {
    data: {
        access_token: string
        renewal_token: string
    }
}

export const registerUser = async ({ email, password, password_confirmation }: RegisterData) => {
    return await axiosInstance.post<TokenResponse>(`/auth/register?email=${email}&password=${password}&password_confirmation=${password_confirmation}`)
}

export const login = async ({email, password}:Omit<RegisterData, "password_confirmation">) => {
    return await axiosInstance.post<TokenResponse>(`/auth/session?email=${email}&password=${password}`)
}

export const me = async () => {
    return await axiosInstance.get("/auth/me", {headers: {Authorization: localStorage.getItem("access_token")}})
}

