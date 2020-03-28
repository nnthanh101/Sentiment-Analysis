import setuptools


with open("README.md") as fp:
    long_description = fp.read()


setuptools.setup(
    name="serverless_widget_service",
    version="0.0.1",

    description="Creating a Serverless Application using the AWS CDK",
    long_description=long_description,
    long_description_content_type="text/markdown",

    author="nnthanh101",

    package_dir={"": "serverless_widget_service"},
    packages=setuptools.find_packages(where="serverless_widget_service"),

    install_requires=[
        "aws-cdk.core==1.31.0",
    ],

    python_requires=">=3.6",

    classifiers=[
        "Development Status :: 4 - Beta",

        "Intended Audience :: Developers",

        "License :: OSI Approved :: Apache Software License",

        "Programming Language :: JavaScript",
        "Programming Language :: Python :: 3 :: Only",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",

        "Topic :: Utilities",

        "Typing :: Typed",
    ],
)
