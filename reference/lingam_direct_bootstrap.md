# Direct LiNGAM のブートストラップ

Direct LiNGAM のブートストラップ

## Usage

``` r
lingam_direct_bootstrap(
  X,
  n_sampling,
  prior_knowledge = NULL,
  apply_prior_knowledge_softly = FALSE,
  measure = "pwling",
  reg_method = "adaptive_lasso",
  lambda = "BIC",
  seed = NULL,
  verbose = TRUE
)
```

## Arguments

- X:

  数値行列 (n_samples x n_features)

- n_sampling:

  ブートストラップの反復回数

- prior_knowledge:

  事前知識行列 (NULL可)

- apply_prior_knowledge_softly:

  事前知識のソフト適用 (logical)

- measure:

  独立性の評価尺度 ("pwling" or "kernel")

- reg_method:

  回帰手法 ("ols", "lasso", "adaptive_lasso")

- lambda:

  ラムダ選択 ("lambda.min", "lambda.1se", "AIC", "BIC","oracle")

- seed:

  乱数シード (NULL可)

- verbose:

  進捗を表示するか (logical)

## Value

BootstrapResult (list)

## Examples

``` r
LiNGAM_sample_1000 <- generate_lingam_sample_6()

# Fast example with OLS
bs <- lingam_direct_bootstrap(LiNGAM_sample_1000$data,
  n_sampling = 10L,
  reg_method = "ols",
  seed = 42
)
#> Bootstrap: 10 iterations, method=ols
#>   iteration 1 / 10
#>   iteration 10 / 10
#> Completed in 0.2 seconds.
get_probabilities(bs)
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,]  0.0  0.1  0.5  0.9  0.1  0.0
#> [2,]  0.9  0.0  0.9  0.9  0.4  0.5
#> [3,]  0.5  0.1  0.0  0.9  0.1  0.4
#> [4,]  0.1  0.1  0.1  0.0  0.1  0.1
#> [5,]  0.9  0.6  0.9  0.9  0.0  0.5
#> [6,]  1.0  0.5  0.6  0.9  0.5  0.0

# \donttest{
# With LASSO (requires glmnet)
bs_lasso <- lingam_direct_bootstrap(LiNGAM_sample_1000$data,
  n_sampling = 30L,
  seed = 42
)
#> Bootstrap: 30 iterations, method=adaptive_lasso
#>   iteration 1 / 30
#>   iteration 10 / 30
#>   iteration 20 / 30
#>   iteration 30 / 30
#> Completed in 1.8 seconds.
# }
```
