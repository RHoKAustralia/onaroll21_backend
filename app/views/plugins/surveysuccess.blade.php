<div class="modal fade bs-modal-sm" id="postSurvey" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">{{ trans('master.thankyou') }}</h4>
            </div>
            <div class="modal-body">
                {{ $postmessage }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-xs" data-dismiss="modal">{{ t('master.ok') }}</button>
            </div>
        </div>
    </div>
</div>