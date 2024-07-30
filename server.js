const PushNotifications = require('@pusher/push-notifications-server');

const beamsClient = new PushNotifications({
  instanceId: 'adb2017d-2ae7-4778-9839-cbf0303212c7',
  secretKey: '913C86EE23339D198964D59955F6F100B70C6798A385F3C7ACFC0294F9CAFD74'
});

// Function to send a notification to a specific user
const sendNotificationToUser = async (userId, title, body) => {
  try {
    await beamsClient.publishToUsers(
      [userId],
      {
        apns: {
          aps: {
            alert: {
              title: title,
              body: body
            }
          }
        },
        fcm: {
          notification: {
            title: title,
            body: body
          }
        }
      }
    );
    console.log('Notification sent successfully!');
  } catch (error) {
    console.error('Error sending notification:', error);
  }
};

// Function to send a notification to an interest
const sendNotificationToInterest = async (interest, title, body) => {
  try {
    const publishResponse = await beamsClient.publishToInterests(
      [interest],
      {
        apns: {
          aps: {
            alert: {
              title: title,
              body: body
            }
          }
        },
        fcm: {
          notification: {
            title: title,
            body: body
          }
        }
      }
    );
    console.log('Just published:', publishResponse.publishId);
  } catch (error) {
    console.error('Error:', error);
  }
};

// Example usage for sending notification to a user
sendNotificationToUser('debug-hello', 'This is a test notification', 'This is the body of the test notification');

// Example usage for sending notification to an interest
sendNotificationToInterest('debug-hello', 'This is a test notification', 'This is the body of the test notification');
