#' 全変数間の総合因果効果を一括推定
#'
#' @param X 元データ (n_samples x n_features)
#' @param lingam_result direct_lingam() の返り値
#' @return 総合因果効果の行列 (行: 結果変数, 列: 原因変数)
estimate_all_total_effects <- function(X, lingam_result) {
  X <- as.matrix(X)
  n_features <- ncol(X)
  adj_matrix <- lingam_result$adjacency_matrix
  causal_order <- lingam_result$causal_order

  # --- 【最大の高速化】数万件のデータを一度だけ共分散行列に圧縮 ---
  cov_mat <- cov(X)

  # 結果を格納する行列 (ゼロ初期化)
  TE <- matrix(0, nrow = n_features, ncol = n_features)
  if (!is.null(colnames(X))) {
    rownames(TE) <- colnames(X)
    colnames(TE) <- colnames(X)
  }

  # 因果順序の上流から下流へ向かって処理
  # (一番下流の変数は他の原因にならないので n_features - 1 まで)
  for (i in 1:(n_features - 1)) {
    from_idx <- causal_order[i]

    # from_idx の親変数を特定し、説明変数を定義
    parents <- which(abs(adj_matrix[from_idx, ]) > 0)
    predictors <- unique(c(from_idx, parents))

    # 説明変数同士の共分散行列 (Σ_xx)
    cov_xx <- cov_mat[predictors, predictors, drop = FALSE]

    # --- 【ベクトル化】因果順序が from_idx より「後」の全変数を一括で目的変数(Y)とする ---
    to_indices <- causal_order[(i + 1):n_features]

    # 説明変数と目的変数群との共分散行列 (Σ_xy)
    cov_xy <- cov_mat[predictors, to_indices, drop = FALSE]

    # 係数行列を一括計算: β = Σ_xx^-1 Σ_xy
    # Rのsolve()は連立方程式を解くC言語ルーチンを呼び出すため極めて高速
    beta_mat <- solve(cov_xx, cov_xy)

    # predictors の中の from_idx の位置を特定し、その行(係数)を抽出
    from_pos <- which(predictors == from_idx)[1]

    # 結果行列の該当箇所に一括代入
    TE[to_indices, from_idx] <- beta_mat[from_pos, ]
  }

  return(TE)
}
