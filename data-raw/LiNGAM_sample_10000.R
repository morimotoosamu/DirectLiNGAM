## code to prepare `LiNGAM_sample_10000` dataset goes here

# import numpy as np
# import pandas as pd
#
# np.random.seed(100)
# x3_super_large = np.random.uniform(size=10000)
# x0_super_large = 3.0*x3_super_large + np.random.uniform(size=10000)
# x2_super_large = 6.0*x3_super_large + np.random.uniform(size=10000)
# x1_super_large = 3.0*x0_super_large + 2.0*x2_super_large + np.random.uniform(size=10000)
# x5_super_large = 4.0*x0_super_large + np.random.uniform(size=10000)
# x4_super_large = 8.0*x0_super_large - 1.0*x2_super_large + np.random.uniform(size=10000)
# x6_super_large = 2.0*x1_super_large + np.random.uniform(size=10000)
# x7_super_large = 1.5*x4_super_large + 3.0*x0_super_large + np.random.uniform(size=10000)
# x8_super_large = 0.5*x2_super_large + 2.0*x5_super_large + np.random.uniform(size=10000)
# x9_super_large = 7.0*x3_super_large + 1.0*x6_super_large + np.random.uniform(size=10000)
#
# X_super_large = pd.DataFrame(np.array([x0_super_large, x1_super_large, x2_super_large, x3_super_large, x4_super_large, x5_super_large, x6_super_large, x7_super_large, x8_super_large, x9_super_large]).T ,
#                              columns=['x0', 'x1', 'x2', 'x3', 'x4', 'x5', 'x6', 'x7', 'x8', 'x9'])

usethis::use_data(LiNGAM_sample_10000, overwrite = TRUE)
