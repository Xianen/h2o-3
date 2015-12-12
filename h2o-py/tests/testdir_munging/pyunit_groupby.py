import sys
sys.path.insert(1, "../../")
import h2o
import pandas as pd
import numpy as np

def group_by(ip,port):
    # Connect to a pre-existing cluster
    

    h2o_iris = h2o.import_frame(path=h2o.locate("smalldata/iris/iris_wheader.csv"))
    pd_iris = pd.read_csv(h2o.locate("smalldata/iris/iris_wheader.csv"))

    h2o_agg_funcs = ["count","count_unique","first","last","min","max","mean","avg","sd","stdev","var","sum","ss"]
    na_handling = ["ignore","rm","all"]
    col_names = h2o_iris.col_names[0:4]

    print "Running smoke test"

    # smoke test
    for na in na_handling:
        grouped = h2o_iris.group_by("class")
        grouped \
            .count(na=na) \
            .min(  na=na) \
            .max(  na=na) \
            .mean( na=na) \
            .var(  na=na) \
            .sd(   na=na) \
            .ss(   na=na) \
            .sum(  na=na)
        print(grouped.get_frame())

if __name__ == "__main__":
    h2o.run_test(sys.argv, group_by)
