import os
from telegram import Bot
import asyncio

def lambda_handler(event, context):
    pipeline_name = event["detail"]["pipeline"]
    pipeline_state = event["detail"]["state"]
    bot_token = os.environ['TELEGRAM_BOT_TOKEN']

    bot = Bot(token=bot_token)

    url = "https://us-east-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/" + pipeline_name + "/view?region=us-east-1"

    message = "The execution of the pipeline " + pipeline_name + " has been " + pipeline_state + "\n" + url

    channel_or_chat_id = os.environ['TELEGRAM_CHANNEL']
    message_thread_id = os.environ['TELEGRAM_THREAD_ID']
    asyncio.run(bot.send_message(message_thread_id=message_thread_id, chat_id=channel_or_chat_id, text=message))

    return {
        'statusCode': 200,
        'body': 'Mensaje enviado a Telegram'
    }
