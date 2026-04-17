#' 誤差の独立性検定の p 値を計算
#'
#' @param X 元データ (matrix or data.frame)
#' @param lingam_result direct_lingam() の返り値
#' @param method 相関係数の種類 ("spearman", "pearson", "kendall")
#' @return p 値の行列 (n_features x n_features)
#' @importFrom stats cor.test
#' @export
#' @examples
#' # サンプルデータの呼び出し
#' data(LiNGAM_sample_1000)
#'
#' # Direct LiNGAM の実行
#' result <- direct_lingam(LiNGAM_sample_1000)
#'
#' # p 値の計算（デフォルト: Spearman）
#' p_vals <- get_error_independence_p_values(LiNGAM_sample_1000, result)
#' round(p_vals, 3)
#'
#' # Kendall で計算
#' p_vals_k <- get_error_independence_p_values(LiNGAM_sample_1000, result, method = "kendall")
#' round(p_vals_k, 3)
get_error_independence_p_values <- function(X, lingam_result, method = "spearman") {
  X <- as.matrix(X)
  B <- lingam_result$adjacency_matrix
  n_features <- ncol(X)

  # 残差（誤差項）の計算
  E <- X - X %*% t(B)

  # 全ペアのインデックスを生成（対角を除く）
  pairs <- which(upper.tri(matrix(TRUE, n_features, n_features)), arr.ind = TRUE)

  # 上三角の全ペアを一括計算
  p_upper <- apply(pairs, 1, function(idx) {
    stats::cor.test(E[, idx[1]], E[, idx[2]], method = method)$p.value
  })

  # 対称行列に格納
  p_values <- matrix(NA, nrow = n_features, ncol = n_features)
  p_values[pairs] <- p_upper
  p_values[pairs[, 2:1]] <- p_upper # 下三角にコピー

  colnames(p_values) <- rownames(p_values) <- colnames(X)

  return(p_values)
}
