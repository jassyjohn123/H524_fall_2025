#!/usr/bin/env Rscript
#
# Code Testing Framework for H524 Biostatistics Course
# Extracts and tests R code from LaTeX files
#

library(stringr)

extract_r_code <- function(tex_file) {
  "Extract R code blocks from LaTeX file"

  content <- readLines(tex_file, warn = FALSE)
  content <- paste(content, collapse = "\n")

  # Extract code from verbatim environments
  verbatim_pattern <- "\\\\begin\\{verbatim\\}(.*?)\\\\end\\{verbatim\\}"
  verbatim_blocks <- str_match_all(content, verbatim_pattern)[[1]][, 2]

  # Extract code from rcode environments (tcolorbox listings)
  rcode_pattern <- "\\\\begin\\{rcode\\}(.*?)\\\\end\\{rcode\\}"
  rcode_blocks <- str_match_all(content, rcode_pattern)[[1]][, 2]

  # Extract code from lstlisting environments
  lst_pattern <- "\\\\begin\\{lstlisting\\}(.*?)\\\\end\\{lstlisting\\}"
  lst_blocks <- str_match_all(content, lst_pattern)[[1]][, 2]

  # Combine all code blocks
  all_blocks <- c(verbatim_blocks, rcode_blocks, lst_blocks)
  all_blocks <- all_blocks[!is.na(all_blocks) & nchar(trimws(all_blocks)) > 0]

  return(all_blocks)
}

test_code_block <- function(code, block_num) {
  "Test a single R code block"

  cat(sprintf("\n--- Testing Code Block %d ---\n", block_num))
  cat("Code:\n")
  cat(str_trunc(code, 100), "\n\n")

  # Create temporary environment for testing
  test_env <- new.env()

  tryCatch({
    # Try to parse the code first
    parsed <- parse(text = code)

    # Execute in test environment
    result <- eval(parsed, envir = test_env)

    cat("✅ Code executed successfully\n")
    return(TRUE)

  }, error = function(e) {
    cat("❌ Error:", conditionMessage(e), "\n")
    return(FALSE)
  }, warning = function(w) {
    cat("⚠️  Warning:", conditionMessage(w), "\n")
    return(TRUE)
  })
}

validate_r_file <- function(tex_file) {
  "Validate all R code in a LaTeX file"

  cat("\n", rep("=", 70), "\n", sep = "")
  cat("Testing R code in:", tex_file, "\n")
  cat(rep("=", 70), "\n", sep = "")

  if (!file.exists(tex_file)) {
    cat("Error: File not found:", tex_file, "\n")
    return(FALSE)
  }

  code_blocks <- extract_r_code(tex_file)

  if (length(code_blocks) == 0) {
    cat("\nNo R code blocks found in file.\n")
    return(TRUE)
  }

  cat(sprintf("\nFound %d code blocks to test\n", length(code_blocks)))

  results <- vector("logical", length(code_blocks))

  for (i in seq_along(code_blocks)) {
    results[i] <- test_code_block(code_blocks[i], i)
  }

  # Summary
  cat("\n", rep("=", 70), "\n", sep = "")
  cat("SUMMARY\n")
  cat(rep("=", 70), "\n", sep = "")
  cat(sprintf("Total blocks: %d\n", length(results)))
  cat(sprintf("Passed: %d\n", sum(results)))
  cat(sprintf("Failed: %d\n", sum(!results)))

  if (all(results)) {
    cat("\n✅ All code blocks passed!\n")
  } else {
    cat("\n❌ Some code blocks failed\n")
  }

  return(all(results))
}

# Main execution
args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
  cat("Usage: Rscript code_tester.R <tex_file>\n")
  cat("Example: Rscript code_tester.R ../Week_4/Lab/week4_lab.tex\n")
  quit(status = 1)
}

tex_file <- args[1]
success <- validate_r_file(tex_file)

quit(status = if (success) 0 else 1)
