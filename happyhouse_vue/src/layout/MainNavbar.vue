<template>
  <navbar
    position="fixed"
    type="info"
    :transparent="transparent"
    :color-on-scroll="colorOnScroll"
    menu-classes="ml-auto"
  >
    <template>
      <router-link v-popover:popover1 class="navbar-brand" to="/">HAPPY HOUSE</router-link>
      <el-popover
        ref="popover1"
        popper-class="popover"
        placement="bottom"
        width="200"
        trigger="hover"
      >
        <div class="popover-body">Happy House Home</div>
      </el-popover>
    </template>
    <template slot="navbar-menu">
      <li class="nav-item">
        <router-link class="nav-link" to="/housing">
          <i class="now-ui-icons location_map-big"></i>
          <p>Search House</p>
        </router-link>
      </li>
      <li class="nav-item" v-if="user !== null">
        <router-link class="nav-link" to="/profile">
          <i class="now-ui-icons users_single-02"></i>
          <p>My Page</p>
        </router-link>
      </li>
      <drop-down
        tag="li"
        title="Community"
        icon="now-ui-icons transportation_air-baloon"
        class="nav-item"
      >
        <nav-link to="/notice">
          <i class="now-ui-icons ui-1_bell-53"></i> 공지사항
        </nav-link>
        <nav-link to="/qna">
          <i class="now-ui-icons ui-2_chat-round"></i> Q&A
        </nav-link>
      </drop-down>
      <li class="nav-item" v-if="user === null">
        <nav-link class="nav-link btn btn-neutral" style="color: #4bb5ff" to="/login">
          <i class="now-ui-icons objects_key-25"></i>
          <p>LOGIN</p>
        </nav-link>
      </li>
      <li class="nav-item" v-if="role == 'admin'">
        <!-- <n-button type="neutral" simple style="color: #4bb5ff">test</n-button> -->
        <div>
          <nav-link class="nav-link btn btn-neutral" style="color: #4bb5ff" to="/userlist">
            <i class="now-ui-icons ui-1_settings-gear-63"></i>
            <p>회원관리</p>
          </nav-link>
        </div>
      </li>
      <li class="nav-item" v-if="user !== null">
        <!-- <n-button type="neutral" simple style="color: #4bb5ff">test</n-button> -->
        <div @click="logout">
          <nav-link class="nav-link btn btn-neutral" style="color: #4bb5ff">
            <i class="now-ui-icons objects_key-25"></i>
            <p>LOGOUT</p>
          </nav-link>
        </div>
      </li>
    </template>
  </navbar>
</template>

<script>
    import { DropDown, Navbar, NavLink } from "@/components";
    import { Popover } from "element-ui";

    import { mapGetters, mapState } from "vuex";
    import { AUTH_LOGOUT } from "@/store/actions/auth";
    export default {
        name: "main-navbar",
        props: {
            transparent: Boolean,
            colorOnScroll: Number,
            loginUser: String,
        },
        data() {
            return {
                user: this.$props.loginUser,
                role: "",
            };
        },
        created() {
            if (this.user != null) {
                this.role = JSON.parse(sessionStorage.getItem("userinfo")).role;
            }
        },
        mounted() {
            console.log("나브바 마운트에 들어왔다.");
            if (this.user != null) {
                this.role = JSON.parse(sessionStorage.getItem("userinfo")).role;
            }
            console.log(JSON.parse(sessionStorage.getItem("userinfo")).role);
        },
        components: {
            DropDown,
            Navbar,
            NavLink,
            [Popover.name]: Popover,
        },
        methods: {
            logout: function () {
                alert("로그아웃 합니다. 로그인 하십시오.");
                sessionStorage.clear();
                this.user = null;
                this.role = null;
                return this.$router.push("/login");
                // this.$store.dispatch(AUTH_LOGOUT).then(() => this.$router.push("/login"));
            },
        },
        computed: {
            ...mapGetters(["isAuthenticated", "isProfileLoaded", "getProfile"]),
            ...mapState({
                authLoading: (state) => state.auth.status === "loading",
                // ,uname: state => `${state.user.getProfile}`,
            }),
            loading: function () {
                return this.authStatus === "loading" && !this.isAuthenticated;
            },
        },
    };
</script>

<style scoped></style>
