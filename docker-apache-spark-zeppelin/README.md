- Based on the [Docker Spark](https://github.com/big-data-europe/docker-spark)
- Zepplin on http://localhost:8888
- 'spark-submit' samples
    ```bash
    docker-compose up -d --build

    docker exec -it spark-zeppelin bash
    
    cd /workspace/pyspark-samples
    $SPARK_HOME/bin/spark-submit --master spark://spark-master:7077 --executor-memory 4G --num-executors 2 ./pyspark-collect.py
    ```