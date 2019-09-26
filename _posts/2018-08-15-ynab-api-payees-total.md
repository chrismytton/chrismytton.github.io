---
title: "YNAB API: Get total amount paid to each payee"
layout: post
tags: [programming]
---

I created this little shell pipeline to help me see the total amount given to or received from people and companies using my data in [YNAB](https://www.youneedabudget.com/).

I used the new [YNAB API](https://api.youneedabudget.com/), [jq](https://stedolan.github.io/jq/) and [q](https://harelba.github.io/q/) to get a CSV out. It's not perfect as it includes the "Transfer: Bank Account" payees, but it's good enough for my purposes.

First set an access token in the environment.  You can get an access token from <https://app.youneedabudget.com/settings/developer>.

{% highlight shell %}
export YNAB_ACCESS_TOKEN='...'
{% endhighlight %}

Then you can run the pipeline, which _should_ default to your last-used budget. This outputs a CSV where the first column is the payee name and the second column is the total amount paid to that payee (if negative) or received from that payee (if positive).

{% highlight shell %}
curl -H "Authorization: Bearer $YNAB_ACCESS_TOKEN" https://api.youneedabudget.com/v1/budgets/last-used/transactions \
  | jq -r '.data.transactions | .[] | [.payee_name,.amount] | @csv' \
  | q -d, 'select c1, sum(c2)/1000.0 as total from - group by c1 order by total'
{% endhighlight %}
