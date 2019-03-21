library('tidyverse')
library('lubridate')

vacants.count <- read_csv('input/vbn_count_by_date.csv')
vacants.count <- vacants.count %>% mutate(date = mdy(date))


ggplot(vacants.count %>% filter(month(date) == 1), aes(x = date, group = 1))  +
  geom_line(aes(y = count), color = '#2484C6', size = 2) +
  geom_point(aes(y = count), fill = 'white', color = '#2484C6', size = 5, shape=21) +
  scale_y_continuous(limits = c(14000, 18000)) +
  scale_x_date(date_breaks = '1 year', date_labels = "%Y") +
  theme(panel.background = element_blank(), 
       plot.background = element_blank(),
       panel.grid.major.y =  element_line(color = 'darkgrey'),
       panel.grid.major.x = element_blank(),
       panel.grid.minor.x = element_blank()) + 
  labs(x = '', y = '')

ggsave('output/vacants_graph_print.eps', device = 'eps', width = 6, height = 7)

