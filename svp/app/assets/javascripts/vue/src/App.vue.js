import search from './components/search.vue.js'
import facets from './components/facets.vue.js'
import docs from './components/docs.vue.js'
import pages from './components/pages.vue.js'
import helperbar from './components/helperbar.vue.js'

export default{
    name: 'App',
    template: '#home',
	components: {
		'search': search,
		'facets': facets,
		'docs': docs,
		'pages': pages,
		'helperbar': helperbar
	},
	computed: {
		repo(){
			return this.$store.state.principal.repo;
		}		
	},
	created: function () {
		this.get_data();
	},
	methods: {
		get_data() {
			this.$store.dispatch('principal/get_data', this.$store.getters['principal/url']);
		}
	},
}