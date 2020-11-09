import models from './utils/models.js'
export default{
    name: 'Doc',
    template: '#docview',
    props: ['id','has_model', 'thumbnail', 'related'],
    data: function(){
        return {
            url_doc: this.$store.getters['principal/base_url']+'concern/',
            doc: ''

        }
    },
	components: {

	},
	watch: {
        doc(){
            return this.doc;
        }
	},
	created: function () {        
        this.url_doc = this.url_doc + models.types[this.has_model] + '/' + this.id + '.json';
        this.get_data();
    },
    /*mounted: function () {
        this.$nextTick(function () {
            alert();
            openPDF(this.related);
        })
    },*/
	methods: {
        async get_data() {
            await axios.get(this.url_doc)
               .then(response => {
                   this.doc = response.data
               })
        },
        filter_key(metadata, key){
            if(!article_filter(key))
                return false;

            if (typeof metadata == "object")
                if (metadata == null || metadata.length < 1) {
                    return false
                }

            if (typeof metadata === "string")
                if (metadata == "") {
                    return false
                }


            return true
            
        }
	},
}