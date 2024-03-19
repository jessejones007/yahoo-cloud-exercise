import boto3
from datetime import datetime
import os

def lambda_handler(event, context):
    # Initialize the Boto3 client with the AWS region
    s3_client = boto3.client('s3')

    # Retrieve environment variables
    bucket_name = os.environ['BUCKET_NAME']

    # Get the current timestamp
    timestamp = datetime.utcnow().isoformat()

    # Create a new object content with "Hello World" and the timestamp
    object_content = f"Hello World. The current timestamp is {timestamp}."

    # Create a new object key with the current timestamp
    object_key = f"hello_world_{timestamp}.txt"
    
    # Put the object in the S3 bucket
    s3_client.put_object(
        Bucket=bucket_name,
        Key=object_key,
        Body=object_content
    )

    return {
        'statusCode': 200,
        'body': f"Successfully created object with key: {object_key}"
    }
