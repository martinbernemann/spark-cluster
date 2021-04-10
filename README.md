
## Description
This spins a Spark cluster with
- JupyterLab-Git
- Spark 3.0.2, Python 3.7, Scala 2.11
- Master node  
- 2 worker
- One node with JupyterLab
- PySpark and Scala Kernel
- A shared Volume `/opt/workspace` surviving cluster up and downs, shared between Jupyer node and all Spark nodes
- Master/Worker WebUIs at 5050+n instead of default 8080+n

## Access
- Jupyter lab http://localhost:8888 
- Master http://locahost:5050 (SPARK_WORKER_WEBUI_PORT) 
- Worker node / executers http://localhost:5051 and 52 (SPARK_MASTER_WEBUI_PORT)
- Jobs http://localhost:4040 plus 1 for each new SparkContext

## Notebooks

### Spark
Scala kernel will create a context implicity on forst import. Use the following as first cell to start spylon-kernel context using the workers and not local[*]
```
%%init_spark
launcher.master = "spark://spark-master:7077"
launcher.conf.spark.executor.memory = "512mb"
```

### PySpark
Use default mehod
```
from pyspark.sql import SparkSession
spark = SparkSession \
    .builder \
    .appName("Some Spark App") \
    .master("spark://spark-master:7077") \
    .config("spark.executor.memory", "512mb") \
    .getOrCreate()
```

## Some commands
Start cluster with
```
docker-compose up -d
```

See cluster logs
```
docker-compose logs
```

Update cluster
```
docker-compose down
./build.sh
docker-compose up --force-recreate -d
docker image prune -f
```

## Known issues
- Docker and linux WSL command line loose track of time during host hibernation
- Make sure to provide >=3GB or more to docker for building images, they get a SIGTERM otherwise during setup
- To re-enable window switch on macOS set in "Keybard Shortcuts", disabling the detault, which opens settinsg eitor instead:
```
{ 
  "shortcuts": [
    {
      "command": "settingeditor:open",
      "keys": [
        "Accel ,"
      ],
      "selector": "body",
      "disabled": true
    }
  ]
}
```

## Special thanks to
- André Perez University of Sao Paulo. https://towardsdatascience.com/apache-spark-cluster-on-docker-ft-a-juyterlab-interface-418383c95445
