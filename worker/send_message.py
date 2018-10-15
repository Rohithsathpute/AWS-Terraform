# -*- coding: utf-8 -*-
#!/bin/python
import boto3
import os

COMMAND="ls -la /"

sqs = boto3.resource('sqs')
queue = sqs.get_queue_by_name(QueueName=os.environ.get('AWS_SQS_QUEUE_NAME', 'queueing-system-dev-queue'))

queue.send_message(MessageBody='boto3', MessageAttributes={
    'Command': {
        'StringValue': '%s' % COMMAND,
        'DataType': 'String',
    }
})
