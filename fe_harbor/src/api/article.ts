import { axiosInstance} from './axios';

export const fetchArticles = async () => {
    const articles = await axiosInstance.get("/articles");
    return articles;
}

export const createArticle = ({name, text}: {name: string, text: string}) => {
    axiosInstance.post("/articles", {name, text}, {headers: {Authorization: localStorage.getItem("access_token")}})
}