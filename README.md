# Social Listening

**AI-Driven Social Media Dashboard** is a complete web application that provides Voice of Customer Analytics through Social Media: Build a Social Media Dashboard using Artificial Intelligence and Business Intelligence Services including end-to-end testing, Serverless (Lambda, API-Gateway), Data Lake (Glue, Athena, Quicksight) and CI/CD. 

**Organizations want to understand how Customers perceive them and who those Customers are**. For example, what factors are driving the most positive and negative experiences for their offerings? Social Media interactions between Organizations and Customers are a great way to evaluate this and deepen brand awareness. Understanding these conversations are a low-cost way to acquire Leads, improve Website traffic, develop Customer Relationships, and improve Customer Service. Since these conversations are all in unstructured text format, it is difficult to scale the analysis and get the full picture.

For more up-to-date information on what's being implemented, take a look at our current [Social Listening Boards](https://github.com/nnthanh101/social-listening/projects/1).

## 1. Environment Setup & Deployment

### 1.1. Docker-Bootstrap

```bash
./bootstrap.sh
```

### 1.2. Building Lambda Package

```bash
cd deployment
./build-s3-dist.sh source-bucket-base-name version
```

source-bucket-base-name should be the base name for the S3 bucket location where the template will source the Lambda code from.
The template will append '-[region_name]' to this value.
version should be a version S3 key prefix
For example: ./build-s3-dist.sh solutions v1.0
The template will then expect the source code to be located in the solutions-[region_name]/ai-driven-social-media-dashboard/v1.0/

> CI/CD: TBD

## CF template and Lambda function
Located in deployment/dist