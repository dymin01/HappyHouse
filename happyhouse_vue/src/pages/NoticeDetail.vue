<template>
  <div>
    <div class="section section-about-us">
      <div class="container">
        <div class="row">
          <div class="col-md-8 ml-auto mr-auto text-center">
            <h2 class="title">공지사항</h2>
            <h5 class="description">{{ notice.regtime }}</h5>
          </div>
        </div>
        <div class="separator separator-primary"></div>
        <div class="section-story-overview">
          <div class="row">
            <div class="col-md-6">
              <div
                class="image-container image-left"
                style="background-image: url('../../img/login.jpg')"
              >
                <!-- First image on the left side -->
                <p class="blockquote" style="border-color:#4bb5ff;color:#4bb5ff">
                  작성자
                  <br />
                  <br />
                  <small style="color:#4bb5ff">-{{ notice.userid }}</small>
                </p>
              </div>
              <!-- Second image on the left side of the article -->
              <div class="image-container" style="background-image: url('../../img/join.jpg')"></div>
            </div>
            <div class="col-md-5">
              <!-- First image on the right side, above the article -->
              <div
                class="image-container image-right"
                style="background-image: url('../../img/bg6.jpg')"
              ></div>
              <h3>{{ notice.subject }}</h3>
              <p>{{ notice.content }}</p>
              <div class="pull-right">
                <div class="row mt-5">
                  <router-link :to="`/notice`">
                    <n-button type="info" round>목록</n-button>
                  </router-link>
                  <div v-if="sessionUser == null"></div>
                  <div v-else-if="sessionUser.role == 'admin'">
                    <router-link :to="`/notice/form/${this.$route.params.articleno}`">
                      <n-button type="default" round>수정</n-button>
                    </router-link>
                    <n-button type="primary" @click="deleteNotice" round>삭제</n-button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import http from '@/http-common_map.js';
import { Button, FormGroupInput } from '@/components';
export default {
  name: 'notice-detail',
  bodyClass: 'notice-detail-page',
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
      notice: {},
    };
  },
  created() {
    http
      .get(`/notice/${this.$route.params.articleno}`)
      .then(({ data }) => {
        this.notice = data;
      })
      .catch(() => {
        alert("에러가 발생했습니다.");
      });
  },
  methods: {
    deleteNotice() {
      http
      .get(`/notice/delete/${this.$route.params.articleno}`)
      .then(() => {
        this.$router.push('/notice');
      })
      .catch(() => {
        alert("에러가 발생했습니다.");
      });
    }
  }
};
</script>
<style></style>
