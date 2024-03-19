import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    # Initialize the Boto3 client with the AWS region
    s3_client = boto3.client('s3')

    # Retrieve environment variables
    bucket_name = os.environ['BUCKET_NAME']

    # List objects in the S3 bucket with the 'hello_world_' prefix
    response = s3_client.list_objects_v2(
        Bucket=bucket_name,
        Prefix='hello_world_'
    )

    # Retrieve the most recent object if exists
    if 'Contents' in response:
        # Get the most recent object based on timestamp in the key
        object_key = max(response['Contents'], key=lambda obj: obj['Key'])['Key']
        object_body = s3_client.get_object(Bucket=bucket_name, Key=object_key)['Body'].read()

        return {
            'statusCode': 200,
            'body': object_body.decode('utf-8')
        }
    else:
        return {
            'statusCode': 404,
            'body': "No objects found in the bucket."
        }
