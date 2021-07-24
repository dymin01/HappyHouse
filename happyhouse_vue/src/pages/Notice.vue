<template>
  <div>
    <div class="page-header page-header-small">
      <parallax class="page-header-image" style="background-image: url('img/bg3.jpg')"></parallax>
      <div class="content-center">
        <div class="container">
          <h1 class="title">공지사항</h1>
          <div v-if="sessionUser == null"></div>
          <div v-else-if="sessionUser.role == 'admin'" class="text-center">
            <a class="btn btn-info btn-round" @click="$router.push(`/notice/form`)">글쓰기</a>
          </div>
        </div>
      </div>
    </div>

    <div class="section section-team text-center">
      <div class="container">
        <card v-for="notice in notices" class="card col-md-3 m-2" :key="notice.articleno">
          <router-link class="nav-link" :to="`notice/read/${notice.articleno}`">
            <h4 class="card-title text-info">{{ notice.subject }}</h4>
            <div class="card-body">
              <h6 class="card-subtitle mb-2 text-muted">{{ getFormatDate(notice.regtime) }}</h6>
              <p
                class="card-text text-muted"
              >{{ notice.content.substr(0, 6) + (notice.content.length > 6 ? "...": "") }}</p>
            </div>
          </router-link>
        </card>
      </div>
    </div>
  </div>
</template>
<script>
import http from '@/http-common_map.js';
import moment from 'moment';
import { Button, FormGroupInput, Card } from '@/components';
export default {
  name: 'notice',
  bodyClass: 'notice-page',
  components: {
    [Button.name]: Button,
    [FormGroupInput.name]: FormGroupInput
  },
  data() {
    return {
      sessionUser: JSON.parse(sessionStorage.getItem('userinfo')),
      form: {
        firstName: '',
        email: '',
        message: ''
      },
      notices: []
    };
  },
  created() {
    http
      .get("/notice/list")
      .then(({ data }) => {
        this.notices = data;
      })
      .catch(() => {
        alert("에러가 발생했습니다.");
      });
  },
  methods: {
    getFormatDate(regtime) {
      return moment(new Date(regtime)).format("YYYY.MM.DD");
    }
  }
};
</script>
<style></style>
