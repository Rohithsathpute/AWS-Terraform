# -*- coding: utf-8 -*-
#!/bin/python
import boto3
import os
import subprocess
import sys
import traceback


sqs = boto3.resource('sqs')
queue = sqs.get_queue_by_name(QueueName=os.environ.get('AWS_SQS_QUEUE_NAME','queueing-system-dev-queue'))

while True:
    for message in queue.receive_messages(MessageAttributeNames=['Command']):
        try:
            if message.message_attributes is not None:
                command = message.message_attributes.get('Command').get('StringValue')
                print('Command: %s' % command)
                proc = subprocess.Popen(command.split(), stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                for line in proc.stdout:
                    sys.stdout.write(line.decode())
                proc.wait()
                rc = proc.returncode
                print('Exit code: %s' % rc)
        except Exception as e:
            exc_type, exc_value, exc_traceback = sys.exc_info()
            print("*** print_tb:")
            traceback.print_tb(exc_traceback, limit=1, file=sys.stdout)
            print("*** print_exception:")
            # exc_type below is ignored on 3.5 and later
            traceback.print_exception(exc_type, exc_value, exc_traceback,
                                      limit=2, file=sys.stdout)
            print("*** print_exc:")
            traceback.print_exc(limit=2, file=sys.stdout)
            print("*** format_exc, first and last line:")
            formatted_lines = traceback.format_exc().splitlines()
            print(formatted_lines[0])
            print(formatted_lines[-1])
            print("*** format_exception:")
            # exc_type below is ignored on 3.5 and later
            print(repr(traceback.format_exception(exc_type, exc_value,
                                                  exc_traceback)))
            print("*** extract_tb:")
            print(repr(traceback.extract_tb(exc_traceback)))
            print("*** format_tb:")
            print(repr(traceback.format_tb(exc_traceback)))
            print("*** tb_lineno:", exc_traceback.tb_lineno)

            # put message in to dead queue or do something else
            message.delete()
        else:
            message.delete()
