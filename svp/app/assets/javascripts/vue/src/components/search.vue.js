export default{
    name: 'search',
    template: "#search",
    data() {
        return {
            search: ""
        }
    },
    methods: {
        search_term() {
            var val = this.search;
            var params = this.$store.getters['principal/url'].split("?");
            var urlParams = new URLSearchParams(this.$store.getters['principal/url'].split('?')[1]);

            if (val != "") {        

                if(urlParams.has('q')){
                    //urlParams.set('search_field', 'all_fields');
                    urlParams.set('q', val);
                } 
                else {
                    urlParams.append('q',val);
                    urlParams.append('search_field', 'all_fields');
                }
                
                this.$store.commit('principal/set_url', params[0] + "?" + urlParams.toString());
                this.$store.dispatch('pages/next_page', 1);
            }else {
                urlParams.delete('search_field');
                urlParams.delete('q');
				this.$store.commit('principal/set_url', params[0] + "?" + urlParams.toString());
			}        
            
            this.$store.dispatch('principal/get_data');
		}

    }
}