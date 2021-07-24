<template>
  <div class="page-header clear-filter">
    <div
      class="page-header-image"
      style="background-image: url('img/login.jpg'); filter: brightness(60%)"
    ></div>
    <div class="content">
      <div class="container">
        <div class="col-md-5 ml-auto mr-auto">
          <card type="login" plain>
            <div slot="header" class="logo-container">
              <img v-lazy="'img/now-logo.png'" alt />
            </div>

            <fg-input
              class="input-lg"
              addon-left-icon="now-ui-icons users_circle-08"
              placeholder="ID"
              v-model="form.userid"
            ></fg-input>

            <fg-input
              class="input-lg"
              addon-left-icon="now-ui-icons ui-1_lock-circle-open"
              placeholder="PASSWORD"
              type="password"
              v-model="form.userpwd"
            ></fg-input>

            <template slot="raw-content">
              <div class="card-footer text-center">
                <a class="btn btn-info btn-round btn-lg btn-block" @click="login">Login</a>
              </div>
              <div class="pull-right">
                <h6>
                  <!-- <nav-link class="nav-link" style="color: #4bb5ff" to="/join">
                                        <p>Create Account</p>
                  </nav-link>-->
                  <router-link to="/join" class="link footer-link">Create Account</router-link>
                </h6>
              </div>
            </template>
          </card>
        </div>
      </div>
    </div>
    <main-footer></main-footer>
  </div>
</template>
<script>
    import http from "@/http-common_map.js";
    import { Card, Button, FormGroupInput } from "@/components";
    import MainFooter from "@/layout/MainFooter";
    export default {
        name: "login-page",
        bodyClass: "login-page",
        components: {
            Card,
            MainFooter,
            [Button.name]: Button,
            [FormGroupInput.name]: FormGroupInput,
        },
        data() {
            return {
                form: {
                    userid: "",
                    userpwd: "",
                },
            };
        },
        created() {
            if (sessionStorage.getItem("userinfo") !== null) {
                this.$router.push("/");
            }
        },
        methods: {
            login() {
                if (this.form.userid == "") {
                    alert("아이디를 입력하세요.");
                    return;
                }
                if (this.form.userpwd == "") {
                    alert("패스워드를 입력하세요.");
                    return;
                }
                http.post("/user/login", this.form)
                    .then(({ data }) => {
                        alert("로그인 성공");
                        sessionStorage.setItem("userinfo", JSON.stringify(data));
                        this.$router.go();
                    })
                    .catch(() => {
                        alert("로그인 실패");
                        this.visablelogin = false;
                        this.submitted = false;
                        this.form.userpwd = "";
                    });
            },
        },
    };
</script>
<style></style>
