import Vue from "vue";
import Router from "vue-router";
import Index from "./pages/Index.vue";
import Housing from "./pages/Housing.vue";
import Login from "./pages/Login.vue";
import Join from "./pages/Join.vue";
import Profile from "./pages/Profile.vue";
import Notice from "./pages/Notice.vue";
import NoticeDetail from "./pages/NoticeDetail.vue";
import NoticeForm from "./pages/NoticeForm.vue";
import QandA from "./pages/QandA.vue";
import QnAForm from "./pages/QnAForm.vue";
import MainNavbar from "./layout/MainNavbar.vue";
import MainFooter from "./layout/MainFooter.vue";
import UserList from './pages/UserList.vue';

Vue.use(Router);

export default new Router({
  linkExactActiveClass: "active",
  mode: "history",
  routes: [{
      path: "/",
      name: "index",
      components: {
        default: Index,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        header: {
          colorOnScroll: 400,
          loginUser: sessionStorage.getItem("userinfo"),
        },
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/userlist",
      name: "userlist",
      components: {
        default: UserList,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        header: {
          colorOnScroll: 400,
        },
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/housing",
      name: "housing",
      components: {
        default: Housing,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        header: {
          colorOnScroll: 400,
        },
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/login",
      name: "login",
      components: {
        default: Login,
        header: MainNavbar,
      },
      props: {
        header: {
          colorOnScroll: 400,
          loginUser: sessionStorage.getItem("userinfo"),
        },
      },
    },
    {
      path: "/join",
      name: "join",
      components: {
        default: Join,
        header: MainNavbar,
      },
      props: {
        header: {
          colorOnScroll: 400,
        },
      },
    },
    {
      path: "/profile",
      name: "profile",
      components: {
        default: Profile,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        header: {
          colorOnScroll: 400,
          loginUser: sessionStorage.getItem('userinfo'),
        },
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/notice",
      name: "notice",
      components: {
        default: Notice,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        header: {
          colorOnScroll: 400,
        },
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/notice/read/:articleno",
      name: "notice-detail",
      components: {
        default: NoticeDetail,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/notice/form",
      name: "notice-form",
      components: {
        default: NoticeForm,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/notice/form/:articleno",
      name: "notice-edit",
      components: {
        default: NoticeForm,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/qna",
      name: "qna",
      components: {
        default: QandA,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        header: {
          colorOnScroll: 400,
        },
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/qna/form",
      name: "qna-form",
      components: {
        default: QnAForm,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        footer: {
          backgroundColor: "black",
        },
      },
    },
    {
      path: "/qna/form/:articleno",
      name: "qna-edit",
      components: {
        default: QnAForm,
        header: MainNavbar,
        footer: MainFooter,
      },
      props: {
        footer: {
          backgroundColor: "black",
        },
      },
    },
  ],
  scrollBehavior: (to) => {
    if (to.hash) {
      return {
        selector: to.hash,
      };
    } else {
      return {
        x: 0,
        y: 0,
      };
    }
  },
});