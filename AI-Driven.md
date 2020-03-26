<h2 id="ai---driven-social-media-dashboard">AI - Driven Social Media Dashboard</h2>
<h2 id="aws-implementation-guide">AWS Implementation Guide</h2>
<h2 id="about-this-guide"><strong>About This Guide</strong></h2>
<p>This  implementation  guide  discusses  architectural  considerations  and  configuration  steps  for deploying  an  AI-Driven  Social  Media  Dashboard  on  the  Amazon  Web  Services  (AWS)  Cloud. It  includes  links  to  an  <a href="http://aws.amazon.com/cloudformation/">AWS  CloudFormation</a> template  that  launches,  configures,  and  runs  the AWS services required to deploy this solution using AWS best practices for security and availability.</p>
<p>The guide is intended for IT infrastructure architects, administrators, and DevOps professionals who have practical experience architecting on the AWS Cloud.</p>
<h2 id="overview"><strong>Overview</strong></h2>
<p>Companies can gain valuable insight and deepen brand awareness by analyzing their social media interactions with customers. Using machine learning (ML) and business intelligence (BI) services from Amazon Web Services (AWS), including <a href="https://aws.amazon.com/translate/">Amazon Translate</a>, <a href="https://aws.amazon.com/comprehend/">Amazon</a>  <a href="https://aws.amazon.com/comprehend/">Comprehend</a>, <a href="https://aws.amazon.com/kinesis/">Amazon Kinesis</a>, <a href="https://aws.amazon.com/athena/">Amazon Athena</a>, and <a href="https://aws.amazon.com/quicksight/">Amazon QuickSight</a>, businesses can build meaningful, low-cost social media dashboards to analyze customer sentiment, which can lead to better opportunities for acquiring leads, improve website traffic, strengthen customer relationships, and improve customer service.</p>
<p>To help customers more easily build a natural-language-processing (NLP)-powered social media  dashboard  for  customer  feedback,  AWS  offers  the  AI-Driven  Social  Media  Dashboard. This  solution  automatically  provisions  and  configures  the  AWS  services  necessary  to  capture multi-language tweets in near real-time, translate them, and display them on a dashboard powered by Amazon  QuickSight.</p>
<p>You can also capture both the raw and enriched datasets and durably store them in the solution’s data lake. This allows data analysts to quickly and easily perform new types of analytics and ML on this data.</p>
<h2 id="cost">Cost</h2>
<p>You are responsible for the cost of the AWS services used while running this reference deployment.  As  of  the  date  of publication,  the  total  cost  for  running  this  solution  with  default settings  in  the  US  East (N.  Virginia)  Region  is  approximately <strong>$190  per  month</strong> for  ingesting 10,000  tweets  per  day  and  storing  them  for  one  year.  Refer  to <a href="#_bookmark22">Appendix  A</a> for  a  breakdown of  the  cost.</p>
<blockquote>
<p>Written with <a href="https://stackedit.io/">StackEdit</a>.</p>
</blockquote>

