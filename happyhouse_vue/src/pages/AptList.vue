<template>
    <div style="padding-top: 60px">
        <div class="overflow-auto">
            <b-pagination v-model="currentPage" :total-rows="rows" :per-page="perPage" aria-controls="my-table"></b-pagination>
            <b-table id="my-table" hover head-variant="dark" :items="items" :per-page="perPage" :current-page="currentPage" small :fields="fields">
                <template #cell(상세보기)="data">
                    <b-button size="sm" @click="showAptDetail(data.item.번호)">상세보기</b-button>
                </template>
            </b-table>

            <!-- <b-table hover head-variant="dark" id="pages-table" :items="items" :fields="fields">
                <template #cell(상세보기)="">
                    <b-button size="sm" @click="test">상세보기</b-button>
                </template>
            </b-table> -->
        </div>
    </div>
</template>

<script>
    export default {
        props: {
            aptinfo: Array,
            gugun_name: String,
        },
        data() {
            return {
                perPage: 10,
                currentPage: 1,
                items: [],

                fields: [{ key: "번호" }, { key: "아파트이름" }, { key: "아파트면적" }, { key: "금액" }, { key: "상세보기" }],
            };
        },
        created() {
            for (var i = 0; i < this.aptinfo.length; i++) {
                this.items.push({
                    번호: i + 1,
                    아파트이름: this.aptinfo[i].아파트,
                    아파트면적: this.aptinfo[i].전용면적,
                    금액: this.aptinfo[i].거래금액,
                });
            }
            console.log(this.items);
        },
        computed: {
            rows() {
                return this.items.length;
            },
        },
        methods: {
            update(data) {
                // I need to disable the button here
                this.output = data;
                data.item.name = "Dave";
                this.$refs["btn" + data.index].disabled = true;
            },
            showAptDetail(a, b) {
                console.log(a);
                console.log(this.aptinfo[a - 1]);
                console.log("테스트 함수 들어왔다.");
                this.$emit("showAptDetail", this.aptinfo[a - 1]);
                // console.log(index);
                // console.log(this.aptinfo[index]);
                // console.log(this.$refs["btn" + data.index]);
            },
        },
    };
</script>

<style></style>
