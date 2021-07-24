<template>
    <div class="small">
        <line-chart :chart-data="datacollection"></line-chart>
    </div>
</template>

<script>
    import LineChart from "./BarChart.js";

    export default {
        components: {
            LineChart,
        },
        props: {
            dataset: Array,
        },
        data() {
            return {
                datacollection: {},
            };
        },
        computed: {
            chartdata() {
                return this.dataset;
            },
        },
        watch: {
            dataset: {
                deep: true,
                handler(newValue, oldValue) {
                    this.fillData();
                },
            },
        },
        created() {
            console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            console.log(this.dataset);
            this.fillData();
        },
        mounted() {
            console.log(this.dataset);
            this.fillData();
        },
        methods: {
            fillData() {
                var tempdata = this.chartdata;
                console.log("@@@@@@@         차트데이터 뿌리기                @@@@@@@@");
                console.log(tempdata[0].name);
                this.datacollection = {
                    labels: ["주변 정보"],
                    datasets: [
                        {
                            label: tempdata[0].name + " (" + tempdata[0].count + ")",
                            backgroundColor: "rgba(255, 99, 132, 0.2)",
                            borderColor: "rgba(255,99,132,1)",
                            borderWidth: 1,
                            data: [tempdata[0].count],
                        },
                        {
                            label: tempdata[1].name + " (" + tempdata[1].count + ")",
                            backgroundColor: "rgba(54, 162, 235, 0.2)",
                            borderColor: "rgba(54, 162, 235, 1)",
                            borderWidth: 1,
                            data: [tempdata[1].count],
                        },
                        {
                            label: tempdata[2].name + " (" + tempdata[2].count + ")",
                            backgroundColor: "rgba(255, 206, 86, 0.2)",
                            borderColor: "rgba(255, 206, 86, 1)",
                            borderWidth: 1,
                            data: [tempdata[2].count],
                        },
                        {
                            label: tempdata[3].name + " (" + tempdata[3].count + ")",
                            backgroundColor: "rgba(75, 192, 192, 0.2)",
                            borderColor: "rgba(75, 192, 192, 1)",
                            borderWidth: 1,
                            data: [tempdata[3].count],
                        },
                        {
                            label: tempdata[4].name + " (" + tempdata[4].count + ")",
                            backgroundColor: "rgba(153, 102, 255, 0.2)",
                            borderColor: "rgba(153, 102, 255, 1)",
                            borderWidth: 1,
                            data: [tempdata[4].count],
                        },
                        {
                            label: tempdata[5].name + " (" + tempdata[5].count + ")",
                            backgroundColor: "rgba(255, 159, 64, 0.2)",
                            borderColor: "rgba(255, 159, 64, 1)",
                            borderWidth: 1,
                            data: [tempdata[5].count],
                        },
                        // {
                        //     label: tempdata[6].name,
                        //     backgroundColor: "rgb(75, 181, 255)",
                        //     data: [tempdata[6].count],
                        // },
                        // {
                        //     label: tempdata[7].name,
                        //     backgroundColor: "rgb(75, 181, 255)",
                        //     data: [tempdata[7].count],
                        // },
                        // {
                        //     label: tempdata[8].name,
                        //     backgroundColor: "rgb(75, 181, 255)",
                        //     data: [tempdata[8].count],
                        // },
                        // {
                        //     label: tempdata[9].name,
                        //     backgroundColor: "rgb(75, 181, 255)",
                        //     data: [tempdata[9].count],
                        // },
                    ],
                };
            },
            // getRandomInt() {
            //     return Math.floor(Math.random() * (50 - 5 + 1)) + 5;
            // },
        },
    };
</script>

<style>
    .small {
        max-width: 600px;
        margin: 150px auto;
    }
</style>
