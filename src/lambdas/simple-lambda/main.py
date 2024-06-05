import os
import json
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(os.environ.get('LOG_LEVEL', 'INFO'))


def handler(event, context):
    """
    Lambda function to list S3 buckets.

    Parameters:
    event (dict): Event data passed to the function.
    context (object): Runtime information provided by Lambda.

    Returns:
    dict: A dictionary containing status code and a list of S3 bucket names.
    """

    s3_client = boto3.client('s3')

    try:
        response = s3_client.list_buckets()

        bucket_names = [bucket['Name'] for bucket in response['Buckets']]
        logger.info(f"Buckets found: {bucket_names}")

        return {
            'statusCode': 200,
            'body': json.dumps(bucket_names)
        }
    except Exception as e:
        logger.error(f"Error listing buckets: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
