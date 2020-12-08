library(readxl)

exp_re = read_xlsx("C:\\Users\\aargeros\\Downloads\\Experiment Responses.xlsx", sheet = 1)
exp_re_2 = read_xlsx("C:\\Users\\aargeros\\Downloads\\Experiment Responses.xlsx", sheet = 2)


exp_df = exp_re %>% inner_join(exp_re_2, by = "Email Address") %>% select(-`Email Address`)

exp_df %<>% 
  rename("time_end" = 1,
         "code" = 2,
         "win" = 3,
         "satisfaction" = 4,
         "time_start" = 5,
         "gender" = 6,
         "major" = 7,
         "business" = 8, 
         "casino" = 9, 
         "sports" = 10,
         "gambling" = 11) %>% 
  mutate(code = ifelse(code == "RBE135", "Treatment", "Control"))

exp_df %>% 
  group_by(code, win) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  group_by(code) %>% 
  mutate(n_prop = n/sum(n))

exp_df %>% 
  group_by(code) %>% 
  summarise(m = mean(satisfaction),
            s = sd(satisfaction)) %>% 
  ggplot() + 
  aes(x = code, y = m, fill = code) +
  geom_bar(stat = "identity", width = 0.5)

exp_df %>% 
  group_by(code, win) %>% 
  summarise(m = mean(satisfaction)) %>% 
  ggplot() + 
  aes(x = code, y = m, fill = win) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5)

exp_df %$% cor(sports, satisfaction)

exp_df %>% 
  group_by(code, satisfaction) %>% 
  summarise(n = n())