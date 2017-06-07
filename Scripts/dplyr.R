library(tidyverse)
gapminder <- read_csv("Data/gapminder-FiveYearData.csv")

rep("This is an example", times=3)

"This is an example" %>% rep(times=3)

year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

year_country_gdp <- gapminder %>%
  select(year, country, gdpPercap)
head(year_country_gdp)

gapminder %>%
  filter(year==2002) %>%
  ggplot(mapping = aes(x=continent, y=pop)) +
  geom_boxplot()

year_country_gdp_euro <- gapminder %>%
  filter(continent=="Europe") %>%
  select(year, country, gdpPercap)

year_country_gdp

country_lifeExp_Norway <- gapminder %>%
  filter(country == "Norway") %>%
  select(year,lifeExp,gdpPercap)
country_lifeExp_Norway

gapminder %>% 
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))

gapminder %>% 
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap)) %>% 
  ggplot(mapping = aes(x = continent, y = mean_gdpPercap)) +
  geom_bar(stat = "identity")

gapminder %>% 
  filter(continent == "Asia") %>% 
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(mapping = aes(y=country, x=mean_lifeExp))+
  geom_point()+
  order()

gapminder %>% 
  mutate(gdp_billion = gdpPercap * pop / 10^9) %>%
  head()
gapminder %>% 
  mutate(gdp_billion = gdpPercap * pop / 10^9)%>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdp_billion)

gapminder %>% 
  mutate(gdp_billion = gdpPercap * pop / 10^9)%>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))
gapminder_country_summary <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))
library (maps)
map_data("world")%>%
  rename(country=region)%>%
  left_join(gapminder_country_summary, by="country")%>%
  ggplot()+
  geom_polygon(aes(x=long, y=lat, group=group, fill = mean_lifeExp))+
  scale_fill_gradient(low="blue", high="Red")+
  coord_equal()

ggsave("My_worldmap.png")
