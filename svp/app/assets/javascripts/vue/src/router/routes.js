import App from '../App.vue.js';
import Doc from '../Doc.vue.js'

var routes = [
  {
    path: '/',
    component: App
  },
  {
    path: '/docs',
    component: Doc,
    props: (route) => ({ id: route.query.id, has_model: route.query.has_model, thumbnail: route.query.thumbnail, related: route.query.related })
  }
]

var router = new VueRouter({
    routes: routes,
    base: '/'
});

export default router;
