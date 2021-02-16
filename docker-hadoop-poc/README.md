https://github.com/big-data-europe/docker-hive 기반으로 postgresql을 mysql로 변경함

- echo system version
    - hadoop v3.2.1
    - hive v2.3.7
    - metastore mysql 8

- up
    ```
    $ docker-compose up -d --build
    ```

- Clean Up
    ```
    $ docker-compose down -v
    $ docker volume prune
    ```  
