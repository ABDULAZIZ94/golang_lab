const PushNotifications = require('@pusher/push-notifications-server');

const beamsClient = new PushNotifications({
  instanceId: 'adb2017d-2ae7-4778-9839-cbf0303212c7',
  secretKey: 'D7B8E8A6AE86C1F3A0A382CD4E243D80858493316C4B4E0CB22B23B2331E5E42'
});

// Function to send a notification to a specific user
const sendNotificationToUser = async (userId, title, body) => {
  try {
    const response = await beamsClient.publishToUsers(
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
        },
        web: {
            notification: {
                title: title,
                body: body
            },
        },
      }
    );
    console.log('Notification sent successfully!', response);
  } catch (error) {
    console.error('Error sending notification:', error.response ? error.response.body : error);
  }
};

// Function to send a notification to an interest
const sendNotificationToInterest = async (interest, title, body) => {
  try {
    const response = await beamsClient.publishToInterests(
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
        },
        web: {
            notification: {
                title: title,
                body: body
            },
        },
      }
    );
    console.log('Just published:', response.publishId);
  } catch (error) {
    console.error('Error:', error.response ? error.response.body : error);
  }
};

// Example usage for sending notification to a user
sendNotificationToUser('debug-hello', 'Test Notification Title', 'Test Notification Body');

// Example usage for sending notification to an interest
sendNotificationToInterest('debug-hello', 'Test Interest Title', 'Test Interest Body');
