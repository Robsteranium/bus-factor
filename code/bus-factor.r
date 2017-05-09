# Functions for calculating a project's Bus Factor

library(plyr)

# Get a vector of the files in a repo
enumerate_files_in_repo <- function(repo_path) {
  system(paste("cd", repo_path, "; git ls-tree HEAD -r | awk -F '\t' '{print $2}'"), intern=T)
}

# Get a vector of author names - one for each line in a file
get_author_for_lines_in_file <- function(repo_path, filename) {
  system(paste("cd", repo_path, "; git blame --line-porcelain", filename, "| grep '^author ' | sed -e 's/^author //'"), intern=T)
}

# Count the lines by author for a vector of names
count_line_authors <- function(author) {
  as.data.frame(table(author), responseName="line_count")
}

# Count the lines by author for a given file/ repo
count_of_lines_by_author_in_file <- function(repo_path, filename) {
  line_authors <- get_author_for_lines_in_file(repo_path, filename)
  file_blame <- count_line_authors(line_authors)
  file_blame$filename <- rep(filename,nrow(file_blame))
  file_blame
}

# Count the lines by author for a whole repo
count_of_lines_by_author_in_repo <- function(repo_path) {
  repo_tree <- enumerate_files_in_repo(repo_path)
  lines_by_file <- adply(repo_tree, 1, count_of_lines_by_author_in_file, repo_path=repo_path, .progress = "text")
  ddply(lines_by_file, .(author), summarise, line_count=sum(line_count))
}

# Calculate the cumulative line count of authors in order of contribution
calculate_author_contribution <- function(author_lines) {
  author_lines$author <- reorder(as.factor(author_lines$author), -author_lines$line_count)
  sorted_contributions <- author_lines[order(author_lines$line_count, decreasing=T),]
  sorted_contributions$cumulative_line_count <- cumsum(sorted_contributions$line_count)
  sorted_contributions$cumulative_author_count <- 1:nrow(sorted_contributions)
  sorted_contributions$cumulative_line_percent <- sorted_contributions$cumulative_line_count/max(sorted_contributions$cumulative_line_count)
  sorted_contributions$cumulative_author_percent <- sorted_contributions$cumulative_author_count/max(sorted_contributions$cumulative_author_count)
  return(sorted_contributions)
}

# Calculate the number of authors required to reach a given contribution
calculate_bus_factor <- function(author_contribution, critical_threshold=0.5) {
  critical_contributions <- author_contribution[author_contribution$cumulative_line_percent < critical_threshold, ]
  nrow(critical_contributions)
}

# Overall calculation of bus factor for a given repo
calculate_bus_factor_for_repo <- function(repo) {
  lba <- count_of_lines_by_author_in_repo(repo)
  ac <- calculate_author_contribution(lba)
  calculate_bus_factor(ac)
}