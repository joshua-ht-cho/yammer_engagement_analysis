# yammer_engagement_analysis
Analysis of Yammer data to identify causes of decreasing user engagement in 2022. Interactive Tableau dashboard can be found here.

## Summary of Insights
### Problem Overview:
- Weekly active users steadily increased from May to July 2022.
- However, August saw a ***19% decrease*** in engagment over four weeks.

### Analysis:
- Daily signups (new users) increased at a regular rate.
  - User growth rate was high on weekdays and low on weekends, which is logical for a business platform.
- Average account age of active users began decreasing at the same time as engagement.
  - From May to July, average account age climbed from 124 days to 143 days -- but fell back to 128 days in August.
  - This suggests that engagement decreased among existing older users.

- Mobile device users declined sharply -- phone and tablet engagement fell 30% and 37%, respectively.
- While the ***open rate*** on our weekly digest emails remained constant, the ***clickthrough rate*** decreased by almost half -- from 41% to 22%.

## Findings & Recommendations
- The drop in user engagement can be attributed to ***existing mobile device users***. This is likely related to lower clickthrough rates on our weekly emails.
- Investigate our weekly email content before and after the drop in clickthrough rate.
  - Is our email content relevant to users?
  - Are there UX issues?
- Investigate the high-level relationship between weekly emails and mobile engagement.
  - Why is engagement driven by email content to such a large extent? Is this sustainable?
  - If mobile users are using Yammer only because they are reminded to by email, are we providing a good mobile product?
- Validate these findings through A/B testing on future weekly emails.
