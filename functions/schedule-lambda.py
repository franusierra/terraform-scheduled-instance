import boto3
import os
region = 'eu-west-1'
ec2 = boto3.client('ec2', region_name=region)

def handler(event, context):
    print(event)
    instance_id=os.environ["INSTANCE_ID"]
    start_event_arn=os.environ["START_EVENT_ARN"]
    stop_event_arn=os.environ["STOP_EVENT_ARN"]
    event_arn=event["resources"][0]
    if event_arn==stop_event_arn:
        print("Stopping the instance")
        ec2.stop_instances(InstanceIds=[instance_id])
        return {
            'status': 200,
            'message': "Instance stopped"
        }
    if event_arn==start_event_arn:
        print("Starting the instance")
        ec2.start_instances(InstanceIds=[instance_id])
        return {
            'status' : 200,
            'message' : "Instance started"
        }
    return {
        'status' : 400,
        'message' : 'Bad request: Unhandled event'
    }
