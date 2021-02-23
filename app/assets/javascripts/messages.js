var ready = function () {
    App.cable.subscriptions.create('ChatChannel', {
            connected: function () {
                this.perform('follow');
                console.log('IM CONNECTED')
            },
            received: function (data) {
                var message = data.message

                if (data.action === 'created') {
                    if (gon.current_user_role === 'user') {
                        $(".chat_zone").prepend(`
                            <div class="message_${message.id}">
                                ${data.user_email}: ${message.body}
                            </div>
                        `)
                    }
                    if (gon.current_user_role !== 'user') {
                        $(".chat_zone").prepend(`
                            <div class="message_${message.id}">
                                ${data.user_email}: ${message.body}
                                <a data-remote="true" rel="nofollow" data-method="delete" href="/messages/${message.id}"> delete</a>
                            </div>
                        `)
                    }
                }
                if (data.action === 'destroyed') {
                    $(".message_" + message.id).remove();
                }
            }
        }
    )
}

$(document).on('turbolinks:load', ready)