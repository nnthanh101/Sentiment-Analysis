# Creating a Serverless Application Using the AWS CDK


### 1. Create a AWS CDK App
  
```
mkdir ServerlessWidgetService && cd ServerlessWidgetService
cdk init --language python
source .env/bin/activate
pip install -r requirements.txt

cdk synth

mkdir resources

```

### 2. Create a Lambda Function

### 3. Creating a Widget Service

```
pip3 install aws_cdk.aws_apigateway aws_cdk.aws_lambda aws_cdk.aws_s3
```

### 4. Add the Service to the App

### 5. Deploy and Test the App

```
export GUID="ct5o1hvsh9"
export REGION="ap-southeast-2"

curl -X GET 'https://ct5o1hvsh9.execute-api.ap-southeast-2.amazonaws.com/prod/'
curl -X POST 'https://${GUID}.execute-api-REGION.amazonaws.com/prod/example'
curl -X GET 'https://${GUID}.execute-api-REGION.amazonaws.com/prod'
curl -X GET 'https://${GUID}.execute-api-REGION.amazonaws.com/prod/example'
curl -X DELETE 'https://${GUID}.execute-api-REGION.amazonaws.com/prod/example'
curl -X GET 'https://${GUID}.execute-api-REGION.amazonaws.com/prod'
```

### 6. Add the Individual Widget Functions

### 7. Clean Up

```

The initialization process also creates a virtualenv within this project, stored under the .env directory.  
To create the virtualenv it assumes that there is a `python3`
(or `python` for Windows) executable in your path with access to the `venv` package. If for any reason the automatic creation of the virtualenv fails, you can create the virtualenv manually.

To manually create a virtualenv on MacOS and Linux:

```
$ python3 -m venv .env
```

After the init process completes and the virtualenv is created, you can use the following
step to activate your virtualenv.

```
$ source .env/bin/activate
```

If you are a Windows platform, you would activate the virtualenv like this:

```
% .env\Scripts\activate.bat
```

Once the virtualenv is activated, you can install the required dependencies.

```
$ pip install -r requirements.txt
```

At this point you can now synthesize the CloudFormation template for this code.

```
$ cdk synth
```

To add additional dependencies, for example other CDK libraries, just add
them to your `setup.py` file and rerun the `pip install -r requirements.txt`
command.

## Useful commands

 * `cdk ls`          list all stacks in the app
 * `cdk synth`       emits the synthesized CloudFormation template
 * `cdk deploy`      deploy this stack to your default AWS account/region
 * `cdk diff`        compare deployed stack with current state
 * `cdk docs`        open CDK documentation

Enjoy!
