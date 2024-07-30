self.addEventListener('push', event => {
    if (event.data) {
        const payload = event.data.json();
        console.log('Received push notification:', payload);

        const title = payload.notification.title;
        const options = {
            body: payload.notification.body,
            icon: payload.notification.icon || '/default-icon.png',
        };

        event.waitUntil(
            self.registration.showNotification(title, options)
        );
    } else {
        console.log('Received push notification with no data');
    }
});

self.addEventListener('notificationclick', event => {
    event.notification.close();
    event.waitUntil(
        clients.openWindow('/')
    );
});
