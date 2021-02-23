var ready = function () {
    App.cable.subscriptions.create('ChatChannel', {
            connected: function () {
                this.perform('follow');
                console.log('IM CONNECTED')
            },
            received: function (data) {
                var message = data.message

                if (data.action === 'created') {
                    $(".chat_zone").prepend(`
                        <div class="message_${message.id}">
                            ${message.body}
                        </div>
                    `)
                }
                if (data.action === 'destroyed') {
                    $(".message_" + message.id).remove();
                }
            }
        }
    )
}

$(document).on('turbolinks:load', ready)