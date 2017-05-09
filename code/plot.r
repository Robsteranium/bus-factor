library(ggplot2)
library(scales)
source("bus-factor.r")

lba <- count_of_lines_by_author_in_repo("/path/to/git/repo")
ac <- calculate_author_contribution(lba)

ggplot(ac, aes(cumulative_author_count, cumulative_line_percent)) + 
  geom_line() + geom_hline(yintercept=0.5, colour="darkgrey") +
  expand_limits(y=0, x=0) +
  scale_y_continuous("Lines of Code", labels=percent) +
  scale_x_log10("Number of Authors", breaks=c(0,10,20,30,40,50)) +
  labs(title="Cumulative Author Contributions") + 
  theme_minimal()