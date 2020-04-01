import boto3
import os
region = 'eu-west-1'
ec2 = boto3.client('ec2', region_name=region)

def handler(event, context):
    print(event)
    start_event_arn=os.environ["START_EVENT_ARN"]
    stop_event_arn=os.environ["STOP_EVENT_ARN"]
    event_arn=event["resources"][0]
    if event_arn==stop_event_arn:
        filters = [{
         'Name': f'tag:{os.environ["STOP_TAG"]}:',
         'Values': ['true']
        }]
        instances = ec2.describe_instances(Filters=filters)['Reservations']['Instances']
        print(f'Stopping {len(instances)} instances...')
        for instance in instances:
            if instance['Status']['Name']=='running':
                instance_id=instance['InstanceId']
                print(f'Stopping {instance_id}...')
                ec2.stop_instances(InstanceIds=[instance_id])
            else:
                print(f'{instance_id} is not running.')
        return {
            'status': 200,
            'message': "Instances stopped"
        }
    if event_arn==start_event_arn:
        filters = [{
         'Name': f'tag:{os.environ["START_TAG"]}:',
         'Values': ['true']
        }]
        instances = ec2.describe_instances(Filters=filters)['Reservations']['Instances']
        print(f'Starting {len(instances)} instances...')
        for instance in instances:
            if instance['Status']['Name']!='running':
                instance_id=instance['InstanceId']
                print(f'Starting {instance_id}...')
                ec2.start_instances(InstanceIds=[instance_id])
            else:
                print(f'{instance_id} is already running.')
        print("Starting the instance")

        return {
            'status' : 200,
            'message' : "Instances started"
        }
    return {
        'status' : 400,
        'message' : 'Bad request: Unhandled event'
    }
