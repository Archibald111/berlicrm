{*<!--
/*********************************************************************************
  ** The contents of this file are subject to the vtiger CRM Public License Version 1.0
   * ("License"); You may not use this file except in compliance with the License
   * The Original Code is:  vtiger CRM Open Source
   * The Initial Developer of the Original Code is vtiger.
   * Portions created by vtiger are Copyright (C) vtiger.
   * All Rights Reserved.
  *
 ********************************************************************************/
-->*}
{strip}
<table class="summary-table" style="width:100%;table-layout:fixed;">
	<tbody>
	{foreach item=FIELD_MODEL key=FIELD_NAME from=$SUMMARY_RECORD_STRUCTURE['SUMMARY_FIELDS']}
		{if $FIELD_MODEL->get('name') neq 'modifiedtime' && $FIELD_MODEL->get('name') neq 'createdtime' && !$BLOCKED_BLOCKS[$FIELD_MODEL->block->id]}
			<tr class="summaryViewEntries">
				<td class="fieldLabel" style="width:35%">
					<label class="muted">
						{if $FIELD_MODEL->get('name') eq "firstname"}
							{vtranslate("Salutation", $MODULE_NAME)}&nbsp;{vtranslate($FIELD_MODEL->get('label'), $MODULE_NAME)}
						{else}
							{vtranslate($FIELD_MODEL->get('label'),$MODULE_NAME)}
						{/if}
                        {if $FIELD_MODEL->get('helpinfo') != ""}
                        <i class="icon-info-sign pull-right" style="margin:3px" rel="popover" data-placement="top" data-trigger="hover" data-content="{vtranslate($FIELD_MODEL->get('helpinfo'), $MODULE_NAME)|replace:'"':'&quot;'}" data-original-title="{vtranslate('LBL_HELP', $MODULE)}"></i>
                        {/if}
					</label>
				</td>
				<td class="fieldValue" style="width:65%">
                    <div class="row-fluid">
                        <span class="value" {if $FIELD_MODEL->get('uitype') eq '19' or $FIELD_MODEL->get('uitype') eq '20' or $FIELD_MODEL->get('uitype') eq '21'}style="word-wrap: break-word; overflow-wrap: break-word;"{/if}>
                            {include file=$FIELD_MODEL->getUITypeModel()->getDetailViewTemplateName()|@vtemplate_path FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$MODULE_NAME RECORD=$RECORD}
                        </span>
                        {if $FIELD_MODEL->isEditable() eq 'true' && ($FIELD_MODEL->getFieldDataType()!=Vtiger_Field_Model::REFERENCE_TYPE) && $IS_AJAX_ENABLED && $FIELD_MODEL->isAjaxEditable() eq 'true' && $FIELD_MODEL->get('uitype') neq 69}
                            <span class="hide edit">
                                {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$MODULE_NAME) FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$MODULE_NAME}
                                {if $FIELD_MODEL->getFieldDataType() eq 'multipicklist'}
                                    <input type="hidden" class="fieldname" value='{$FIELD_MODEL->get('name')}[]' data-prev-value='{$FIELD_MODEL->getDisplayValue($FIELD_MODEL->get('fieldvalue'))}' />
                                {else}
                                    <input type="hidden" class="fieldname" value='{$FIELD_MODEL->get('name')}' data-prev-value='{$FIELD_MODEL->get('fieldvalue')}' />
                                {/if}
                            </span>
                            <span class="summaryViewEdit cursorPointer pull-right">
                                &nbsp;<i class="icon-pencil" title="{vtranslate('LBL_EDIT',$MODULE_NAME)}"></i>
                            </span>
                        {/if}
                    </div>
				</td>
			</tr>
        {elseif $BLOCKED_BLOCKS[$FIELD_MODEL->block->id]}
            {ASSIGN var=blockedfields value=$blockedfields+1}
		{/if}
	{/foreach}
	</tbody>
</table>
{if $USER_MODEL->isAdminUser()}
    {if $blockedfields == 1}
        <div class="alert alert-warning" role="alert" style="font-size:80%;padding:3px 12px">{vtranslate('LBL_FIELD_HIDDEN_NOTICE')} <a href='{$smarty.server.REQUEST_URI}&overridedynblocks=1'>{vtranslate('LBL_SHOW_HIDDEN_ONCE')}</a></div>
    {elseif $blockedfields > 1}
        <div class="alert alert-warning" role="alert" style="font-size:80%;padding:3px 12px">{vtranslate('LBL_FIELDS_HIDDEN_NOTICE')|sprintf:$blockedfields} <a href='{$smarty.server.REQUEST_URI}&overridedynblocks=1'>{vtranslate('LBL_SHOW_HIDDEN_ONCE')}</a></div>
    {/if}
{/if}
<hr>
<div class="row-fluid">
	<div class="span4 toggleViewByMode">
		{assign var="CURRENT_VIEW" value="full"}
		{assign var="CURRENT_MODE_LABEL" value="{vtranslate('LBL_COMPLETE_DETAILS',{$MODULE_NAME})}"}
		<button type="button" class="btn changeDetailViewMode cursorPointer"><strong>{vtranslate('LBL_SHOW_FULL_DETAILS',$MODULE_NAME)}</strong></button>
		{assign var="FULL_MODE_URL" value={$RECORD->getDetailViewUrl()|cat:'&mode=showDetailViewByMode&requestMode=full'} }
		<input type="hidden" name="viewMode" value="{$CURRENT_VIEW}" data-nextviewname="full" data-currentviewlabel="{$CURRENT_MODE_LABEL}"
			data-full-url="{$FULL_MODE_URL}"  />
	</div>
	<div class="span8">
		<div class="pull-right">
			<div>
				<p>
					<small>
						{vtranslate('LBL_CREATED_ON',$MODULE_NAME)} {Vtiger_Util_Helper::formatDateTimeIntoDayString($RECORD->get('createdtime'))}
					</small>
				</p>
			</div>
			<div>
				<p>
					<small>
						{vtranslate('LBL_MODIFIED_ON',$MODULE_NAME)} {Vtiger_Util_Helper::formatDateTimeIntoDayString($RECORD->get('modifiedtime'))}
					</small>
				</p>
			</div>
		</div>
	</div>
</div>
{/strip}