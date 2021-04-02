FROM spark-base

ARG spark_master_web_ui=5050

EXPOSE ${spark_master_web_ui} ${SPARK_MASTER_PORT}

CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out