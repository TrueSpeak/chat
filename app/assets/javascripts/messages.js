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
                                <div class="card">
                                    <div class="card-body">
                                        ${data.user_email}: ${message.body}
                                    </div>
                                </div>
                                <br>
                            </div>
                        `)
                    }
                    if (gon.current_user_role !== 'user') {
                        $(".chat_zone").prepend(`
                            <div class="message_${message.id}">
                                <div class="card">
                                    <div class="card-body">
                                        ${data.user_email}: ${message.body}
                                        <a class="btn btn-outline-danger" style="float: right" data-remote="true" rel="nofollow" data-method="delete" href="${message.id}"> delete</a>
                                    </div>
                                </div>
                                <br>
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