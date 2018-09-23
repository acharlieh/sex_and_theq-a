Checking on gender bias in The Q&A
----

So I happened to see an [article interviewing Jodie Whittaker](https://www.theguardian.com/lifeandstyle/2018/sep/22/jodie-whittaker-q-and-a-drinking-wine-doctor-who) and my knee-jerk reaction was "seriously? they asked her how often does she have sex? She answered the question well but still.."

So this lead me to try to find Q&A of a previous Doctor Who actor, and I found that [Matt Smith](https://www.theguardian.com/lifeandstyle/2013/mar/30/matt-smith-interview) did not have that question asked of him, so I was starting to be disappointed and was thinking that maybe the Guardian was doing the whole "ask intimate questions of women because they're women" type of thing. 

So with some Ruby, and with the power of YAML and Nokogiri, my weekend diversion proved that, no, in fact this question is being asked of both genders at similar rates, and it's probably just either the subject not answering or not providing a good answer to print. In fact the process that [@celebQandA](https://twitter.com/celebQandA) seems to follow is to ask a standard bank of questions of everyone as alluded to [in the 25th anniversary article](https://www.theguardian.com/lifeandstyle/2015/dec/19/kylie-rob-lowe-25-years-weekend-magazine-celebrity-qa)

Here were my resultant numbers looking for this:

published answer to a question with the word sex in it: {"male"=>119, "female"=>90, "unknown"=>1}
no question: {"male"=>203, "female"=>164, "unknown"=>5}

which works out to a 35 - 36% response rate on both.

Arguably these were quick and dirty parsing methods as you can see in the scripts, so might be slightly off, but hacking to get the general gist, it seems legit.

Now I will also point out that according to this imperfect parsing method, only [Damien Lewis](https://www.theguardian.com/stage/2005/oct/29/theatre)  had the question published of 'Have you ever had a same-sex experience?'

Running for yourself
====
You'll need [Nokogiri](https://www.nokogiri.org/) and Ruby... then run them in order... 

```shell
ruby guardian_step1.rb
ruby guardian_step2.rb
ruby reprocess_raw.rb
ruby reprocess_articles.rb
ruby statistics.rb
```

The script `relocateraw.rb` I originally stored the raw data in the same files as the processed metadata, but second pass figured out that it was better to keep raw separate. But by caching down the raw HTML, that means I was able to reprocess a number of times with a few different tweaks without re-hitting the Guardian's servers.
