import boto3
import os
region = 'eu-west-1'
session = boto3.Session(region_name=region)
ec2 = session.resource('ec2', region)
def handler(event, context):
    print(event)
    start_event_arn=os.environ["START_EVENT_ARN"]
    stop_event_arn=os.environ["STOP_EVENT_ARN"]
    event_arn=event["resources"][0]
    if event_arn==stop_event_arn:
        filters = [{
            'Name': f'tag:{os.environ["STOP_TAG"]}',
            'Values': ['true']
        },
        {
            'Name': 'instance-state-name',
            'Values': ['running']

        }]
        instances = ec2.instances.filter(Filters=filters)
        ilist = [instance for instance in instances]
        print(f'Stopping the {len(ilist)} instances')
        instances.stop()
        return {
            'status': 200,
            'message': "Instances stopped"
        }
    if event_arn==start_event_arn:
        filters = [{
            'Name': f'tag:{os.environ["START_TAG"]}',
            'Values': ['true']
        },
        {
            'Name': 'instance-state-name',
            'Values': ['stopped']

        }]
        instances = ec2.instances.filter(Filters=filters)
        ilist = [instance for instance in instances]
        print(f'Starting the {len(ilist)} instances')
        instances.start()
        return {
            'status' : 200,
            'message' : "Instances started"
        }
    return {
        'status' : 400,
        'message' : 'Bad request: Unhandled event'
    }
