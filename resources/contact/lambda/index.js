import { SendEmailCommand, SESClient } from '@aws-sdk/client-ses'

const sesClient = new SESClient({ region: 'ap-southeast-2' })
const toAddress = 'micapam+jmcontact@gmail.com'
const fromAddress = 'micapam+jmcontact@gmail.com'

const createSendEmailCommand = (postParams) =>
  new SendEmailCommand({
    Destination: {
      ToAddresses: [
        toAddress,
      ],
    },
    Message: {
      Body: {
        Text: {
          Charset: 'UTF-8',
          Data: 'Name: ' + postParams.name + '\nPhone: ' + postParams.phone +
            '\nEmail: ' + postParams.email + '\nMessage: ' + postParams.message,
        },
      },
      Subject: {
        Charset: 'UTF-8',
        Data: `Contact email from ${postParams.name}`,
      },
    },
    Source: fromAddress,
  })

const response = (statusCode, body) => ({
  isBase64Encoded: false,
  headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': 'http://joshuamostafa.info',
  },
  statusCode,
  body: JSON.stringify(body)
})

export const handler = async (event, context) => {
    console.log('Received event:', event);
    const sendEmailCommand = createSendEmailCommand(event)

    try {
      await sesClient.send(sendEmailCommand)
      return response(200, { result: 'success' })
    } catch (error) {
      console.error('Failed to send email', error)
      return response(500, { error })
    }
}
