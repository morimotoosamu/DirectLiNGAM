## code to prepare `LiNGAM_sample_1000` dataset goes here

usethis::use_data(LiNGAM_sample_1000, overwrite = TRUE)

# import numpy as np
# import pandas as pd
#
# np.random.seed(100)
# x3 = np.random.uniform(size=1000)
# x0 = 3.0*x3 + np.random.uniform(size=1000)
# x2 = 6.0*x3 + np.random.uniform(size=1000)
# x1 = 3.0*x0 + 2.0*x2 + np.random.uniform(size=1000)
# x5 = 4.0*x0 + np.random.uniform(size=1000)
# x4 = 8.0*x0 - 1.0*x2 + np.random.uniform(size=1000)
# X = pd.DataFrame(np.array([x0, x1, x2, x3, x4, x5]).T ,columns=['x0', 'x1', 'x2', 'x3', 'x4', 'x5'])
