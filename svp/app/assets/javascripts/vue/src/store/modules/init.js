export default {
    namespaced: true,
    state: {
        repo: '',
        base_url: 'https://repositorio.colmex.mx/',
        //url: "https://repositorio.colmex.mx/catalog.json",
        url: "https://repositorio.colmex.mx/catalog.json?f[member_of_collections_ssim][]=Tesis",
        modalFacets: false
    },
    mutations: {
        set_repo(state, repo) {
			 state.repo = repo;
        },
        set_url(state, url){
            state.url = url;
        },
        set_modalFacets(state, value){
            state.modalFacets = value;
        }
    },
    getters: {
        repo(state){
            return state.repo
        },
        url(state){
            return state.url
        },
        modalFacets(state){
            return state.modalFacets
        },
        base_url(state){
            return state.base_url;
        }
    },
    actions: {
        async get_data({ state, commit }) {
            await axios.get(state.url)
               .then(response => {
                   var repository = filter_data(response.data.response);
                   commit('set_repo', repository);
               })
       }
    }
}