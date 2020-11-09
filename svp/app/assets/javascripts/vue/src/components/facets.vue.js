import facetModal from './facetModal.vue.js'

export default {
    name: "facets",
    props: ["facets", "params"],
    template: "#facetas",
    components:{
        'facetModal': facetModal
    },
    data: function(){
        return {
            facet_data: "",
		    facet_label: "",
		    facet_sort: "index",
		    acet_page: 1
        }
    },
    methods: {
        query(type, val, label) {
            var params = this.$store.getters['principal/url'].split("?");
            var urlParams = new URLSearchParams(this.$store.getters['principal/url'].split('?')[1]);
            if(!urlParams.has('f['+ type +'][]')){
                urlParams.set('f['+ type +'][]', val);
            } 
            else urlParams.append('f['+ type +'][]', val);

            this.$store.commit('principal/set_url', params[0] + "?" + urlParams.toString());
            this.$store.dispatch('principal/get_data');
            this.$store.commit('filters/set_filter', {label, val, type});
		},
        delete_query: function (type, val, label) {
            this.$store.dispatch('filters/delete_query', {type, val, label});
		},
        get_data_facet(val) {
            this.facet_label = val
			axios.get(this.facet_url)
				.then(response => {

					this.facet_data = response.data.response.facets.items
					this.facet_page = response.data.response.facets.facet_page
					this.facet_sort = response.data.response.facets.sort
					this.$store.commit('principal/set_modalFacets', true);
                });
        },
        compare_params: function (type, val) {
            var response = false
            var urlParams = new URLSearchParams(this.$store.getters['principal/url'].split('?')[1]);
            urlParams.forEach(function(value, key) {
                if(key == 'f['+ type +'][]' && value == val)
                response = true;
            });

			return response
        },    
    },
    computed:{
        facet_url() {
            return this.$store.getters['principal/base_url'] + "catalog/facet/" + this.facet_label + ".json?facet.page=" + this.facet_page + "&facet.sort=" + this.facet_sort
        },
        showModal(){
			return this.$store.state.principal.modalFacets;
        },
        test_url(){
            return this.$store.getters['principal/base_url'];
        }
    },
    watch:{
        facet_label(){
            return this.facet_label
        }
    }
};