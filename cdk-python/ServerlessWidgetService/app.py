#!/usr/bin/env python3

from aws_cdk import core

from serverless_widget_service.serverless_widget_service_stack import ServerlessWidgetServiceStack


app = core.App()
ServerlessWidgetServiceStack(app, "serverless-widget-service")

app.synth()
