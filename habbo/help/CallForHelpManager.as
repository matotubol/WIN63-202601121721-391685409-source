package com.sulake.habbo.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpReplyMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.IssueCloseNotificationMessageEventParser;
   import com.sulake.habbo.help.cfh.registry.user.UserRegistryItem;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromSelfieMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewSessionCreateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumThreadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.DeletePendingCallsForHelpMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromPhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromIMMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   
   public class CallForHelpManager implements class_13
   {
      
      private static const FIELD_MAX_CHARS:int = 253;
      
      private static const EMERGENCY_HELP_REQUEST_TITLE:String = "emergency_help_request";
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var _window:class_1812;
      
      private var var_547:ChatReportController;
      
      private var var_150:int = -1;
      
      private var _reportedUserName:String = "";
      
      private var var_374:int = -1;
      
      private var _reportedRoomName:String;
      
      private var var_3555:String;
      
      private var var_1322:int = -1;
      
      private var var_1287:int = -1;
      
      private var var_2455:int = -1;
      
      private var var_4435:String;
      
      private var var_4399:int = -1;
      
      private var var_363:int;
      
      private var var_4136:int;
      
      private var var_1344:int;
      
      private var var_986:String;
      
      public function CallForHelpManager(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         var_547 = new ChatReportController(_habboHelp,onChatReportEvent);
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new IssueCloseNotificationMessageEvent(onIssueClose));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CallForHelpResultMessageEvent(onCallForHelpResult));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CallForHelpReplyMessageEvent(onCallForHelpReply));
      }
      
      private static function getCloseReasonKey(param1:int) : String
      {
         if(param1 == 1)
         {
            return "useless";
         }
         if(param1 == 2)
         {
            return "abusive";
         }
         return "resolved";
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            closeWindow();
            if(var_547)
            {
               var_547.dispose();
               var_547 = null;
            }
            _habboHelp = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get reportedUserId() : int
      {
         return var_150;
      }
      
      public function get reportedUserName() : String
      {
         return _reportedUserName;
      }
      
      public function get reportedRoomId() : int
      {
         return var_374;
      }
      
      public function get reportedRoomName() : String
      {
         return _reportedRoomName;
      }
      
      public function get reportedExtraDataId() : String
      {
         return var_4435;
      }
      
      public function get reportedRoomObjectId() : int
      {
         return var_4399;
      }
      
      public function get reportedGroupId() : int
      {
         return var_1322;
      }
      
      public function get reportedThreadId() : int
      {
         return var_1287;
      }
      
      public function get reportedMessageId() : int
      {
         return var_2455;
      }
      
      public function set reportedUserId(param1:int) : void
      {
         var_150 = param1;
      }
      
      public function set reportedUserName(param1:String) : void
      {
         _reportedUserName = param1;
      }
      
      public function set reportedRoomId(param1:int) : void
      {
         var_374 = param1;
      }
      
      public function set reportedRoomName(param1:String) : void
      {
         _reportedRoomName = param1;
      }
      
      public function set reportedExtraDataId(param1:String) : void
      {
         var_4435 = param1;
      }
      
      public function set reportedRoomObjectId(param1:int) : void
      {
         var_4399 = param1;
      }
      
      public function set reportedGroupId(param1:int) : void
      {
         var_1322 = param1;
      }
      
      public function set reportedThreadId(param1:int) : void
      {
         var_1287 = param1;
      }
      
      public function set reportedMessageId(param1:int) : void
      {
         var_2455 = param1;
      }
      
      public function reportBully(param1:int, param2:int) : void
      {
         if(_habboHelp.guardiansEnabled)
         {
            var_150 = param1;
            var_374 = param2;
            _habboHelp.queryForGuideReportingStatus(3);
         }
         else
         {
            reportUser(param1,1,123);
         }
      }
      
      public function reportUser(param1:int, param2:int, param3:int) : void
      {
         var_150 = param1;
         var_374 = -1;
         var_4136 = param3;
         _habboHelp.queryForPendingCallsForHelp(param2);
      }
      
      public function reportRoom(param1:int, param2:String, param3:String) : void
      {
         var_374 = param1;
         _reportedRoomName = param2;
         var_3555 = param3;
         var_150 = -1;
         _habboHelp.queryForPendingCallsForHelp(4);
      }
      
      public function reportThread(param1:int, param2:int) : void
      {
         var_1322 = param1;
         var_1287 = param2;
         _habboHelp.queryForPendingCallsForHelp(7);
      }
      
      public function reportMessage(param1:int, param2:int, param3:int) : void
      {
         var_1322 = param1;
         var_1287 = param2;
         var_2455 = param3;
         _habboHelp.queryForPendingCallsForHelp(8);
      }
      
      public function reportSelfie(param1:String, param2:String, param3:int, param4:int, param5:int) : void
      {
         _habboHelp.sendMessage(new CallForHelpFromSelfieMessageComposer(param1,param3,param4,param2,param5));
      }
      
      public function reportPhoto(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         _habboHelp.setReportMessage(new CallForHelpFromPhotoMessageComposer(param1,param3,param4,param2,param5,"",""));
         _habboHelp.queryForPendingCallsForHelp(9);
      }
      
      public function openEmergencyHelpRequest() : void
      {
         reportUser(0,1,-1);
      }
      
      private function showAbusiveNotice() : void
      {
         closeWindow();
         _window = _habboHelp.getXmlWindow("abusive_notice") as class_1812;
         _window.center();
         _window.findChildByName("header_button_close").visible = false;
         _window.procedure = onAbusiveNoticeEvent;
      }
      
      public function showEmergencyHelpRequest(param1:int) : void
      {
         closeWindow();
         var_363 = param1;
         if(var_363 == 6)
         {
            _window = _habboHelp.getXmlWindow("bully_report") as class_1812;
            _window.procedure = onBullyReportEvent;
         }
         else
         {
            _window = _habboHelp.getXmlWindow("emergency_help_request") as class_1812;
            _window.procedure = onEmergencyHelpRequestEvent;
            IIlluminaInputWidget(class_2010(_window.findChildByName("help_message")).widget).maxChars = 253;
         }
         _window.center();
         var _loc4_:IItemListWindow = _window.findChildByName("user_panel") as IItemListWindow;
         var _loc5_:IItemListWindow = _window.findChildByName("room_panel") as IItemListWindow;
         var _loc2_:ISelectorWindow = ISelectorWindow(_window.findChildByName("topic_selector"));
         if(_loc2_ != null)
         {
            var _loc3_:ISelectableWindow = _loc2_.getSelectableByName("" + var_4136);
            var _loc6_:ISelectableWindow = _loc2_.getSelectableByName("123");
            if(_loc6_ != null && _habboHelp.guardiansEnabled)
            {
               null.visible = false;
            }
         }
         switch(var_363 - 1)
         {
            case 0:
               showPanels(true,false);
               break;
            case 2:
               showPanels(false,false);
               break;
            case 3:
               showPanels(false,true);
               break;
            case 5:
               populateUserList();
               break;
            case 6:
            case 7:
               showPanels(false,false);
         }
      }
      
      private function showChatReportTool() : void
      {
         closeWindow();
         var_547.show(_habboHelp.ownUserId,var_150,var_363);
      }
      
      private function showPanels(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:IItemListWindow = _window.findChildByName("user_panel") as IItemListWindow;
         var _loc5_:IItemListWindow = _window.findChildByName("room_panel") as IItemListWindow;
         var _loc4_:Boolean = param1 || param2;
         _window.findChildByName("submit_box_wide").visible = _loc4_;
         _window.findChildByName("submit_box_narrow").visible = !_loc4_;
         _window.findChildByName("separator").visible = _loc4_;
         _loc5_.visible = param2;
         _loc3_.visible = param1;
         if(param2)
         {
            _loc5_.getListItemByName("room_name").caption = _reportedRoomName ?? "";
            _loc5_.getListItemByName("room_description").caption = var_3555 ?? "";
         }
         if(param1)
         {
            populateUserList();
         }
         if(!_loc4_)
         {
            _window.width = 301;
         }
      }
      
      private function populateUserList() : void
      {
         var _loc3_:class_1812 = null;
         var _loc4_:* = false;
         var _loc2_:IItemListWindow = _window.findChildByName("user_list") as IItemListWindow;
         var _loc1_:class_1812 = _loc2_.getListItemAt(0) as class_1812;
         _loc2_.removeListItems();
         var _loc5_:int = 0;
         for each(var _loc6_ in _habboHelp.userRegistry.getRegistry())
         {
            _loc3_ = _loc1_.clone() as class_1812;
            _loc4_ = _loc6_.userId == var_150;
            _loc3_.name = _loc6_.userId.toString();
            _loc3_.blend = _loc4_ ? 1 : 0;
            _loc3_.procedure = onUserSelectEvent;
            _loc3_.findChildByName("user_name").caption = _loc6_.userName;
            _loc3_.findChildByName("room_name").id = _loc6_.roomId;
            if(_loc4_)
            {
               var_374 = _loc6_.roomId;
            }
            _loc3_.findChildByName("room_name").caption = _loc6_.roomName != "" ? _habboHelp.localization.getLocalizationWithParams("help.emergency.main.step.two.room.name","","room_name",_loc6_.roomName) : "";
            class_2478(class_2010(_loc3_.findChildByName("user_avatar")).widget).figure = _loc6_.figure;
            _loc2_.addListItemAt(_loc3_,_loc5_);
            if(_loc4_)
            {
               _loc5_ = 1;
            }
         }
      }
      
      private function refreshUserList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1812 = null;
         var _loc1_:IItemListWindow = _window.findChildByName("user_list") as IItemListWindow;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.numListItems)
         {
            _loc2_ = class_1812(_loc1_.getListItemAt(_loc3_));
            _loc2_.blend = int(_loc2_.name) == var_150 ? 1 : 0;
            _loc3_++;
         }
      }
      
      public function showPendingRequest(param1:String) : void
      {
         closeWindow();
         _window = _habboHelp.getXmlWindow("pending_request") as class_1812;
         _window.findChildByName("request_message").caption = param1;
         _window.center();
         _window.procedure = onPendingReuqestEvent;
      }
      
      private function closeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onAbusiveNoticeEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:* = param2.name;
            if("close_button" === _loc3_)
            {
               closeWindow();
            }
         }
      }
      
      private function onEmergencyHelpRequestEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "submit_button":
                  if(!saveEmergencyHelpRequestData())
                  {
                     return;
                  }
                  basicInfoDone();
                  break;
               case "header_button_close":
                  closeWindow();
            }
         }
      }
      
      private function onBullyReportEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "submit_button":
                  if(var_150 > 0)
                  {
                     _habboHelp.sendMessage(new IgnoreUserMessageComposer(var_150));
                     _habboHelp.sendMessage(new ChatReviewSessionCreateMessageComposer(var_150,var_374));
                     closeWindow();
                     break;
                  }
                  _habboHelp.windowManager.alert("${generic.alert.title}","${guide.bully.request.usermissing}",0,null);
                  break;
               case "header_button_close":
                  closeWindow();
            }
         }
      }
      
      private function onChatReportEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "submit_button":
                  if(var_547.collectSelectedEntries(var_363,-1).length == 0)
                  {
                     _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.chatmissing}",0,null);
                     return;
                  }
                  submitCallForHelp();
                  var_547.closeWindow();
                  closeWindow();
                  break;
               case "header_button_close":
                  var_547.closeWindow();
            }
         }
      }
      
      private function onUserSelectEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            selectUserToReport(param2 as class_1812);
         }
      }
      
      private function selectUserToReport(param1:class_1812) : void
      {
         if(_window == null || _window.name != "emergency_help_request" || param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.name);
         if(var_150 == _loc2_)
         {
            var_150 = 0;
            var_374 = -1;
         }
         else
         {
            var_150 = _loc2_;
            var_374 = param1.findChildByName("room_name").id;
         }
         refreshUserList();
      }
      
      private function basicInfoDone() : void
      {
         var _loc1_:Boolean = isChatSelectionRequired();
         if(var_363 == 3)
         {
            if(!_habboHelp.instantMessageRegistry.hasUserChatted(var_150))
            {
               _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.nochathistory}",0,null);
            }
         }
         else if(_loc1_ && !_habboHelp.chatRegistry.hasContentWithoutChatFromUser(_habboHelp.ownUserId) && _habboHelp.chatRegistry.hasContentWithoutChatFromUser(var_150))
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.nochathistory}",0,null);
            return;
         }
         if(_loc1_)
         {
            showChatReportTool();
         }
         else
         {
            submitCallForHelp();
         }
      }
      
      private function isChatSelectionRequired() : Boolean
      {
         if(var_363 == 7 || var_363 == 8 || var_363 == 4)
         {
            return false;
         }
         return var_150 <= 0 || _habboHelp.chatRegistry.getItemsByUser(var_150).length > 0 || var_363 == 3;
      }
      
      private function saveEmergencyHelpRequestData(param1:Boolean = true) : Boolean
      {
         if(_window == null || _window.name != "emergency_help_request")
         {
            return false;
         }
         var_986 = IIlluminaInputWidget(class_2010(_window.findChildByName("help_message")).widget).message;
         if(var_986 == null || var_986 == "")
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.nomsg}",0,null);
            return false;
         }
         if(var_986.length < _habboHelp.getInteger("help.cfh.length.minimum",15))
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.msgtooshort}",0,null);
            return false;
         }
         var_1344 = 0;
         var _loc2_:ISelectableWindow = ISelectorWindow(_window.findChildByName("topic_selector")).getSelected();
         if(_loc2_ != null)
         {
            var_1344 = int(_loc2_.name);
         }
         if(var_1344 == 0)
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${help.cfh.error.notopic}",0,null);
            return false;
         }
         if(var_363 == 8 || var_363 == 7)
         {
            return true;
         }
         if(var_150 <= 0 && (var_363 != 8 && var_363 == 7) || var_363 == 4 && !_habboHelp.getBoolean("room.report.enabled"))
         {
            _habboHelp.windowManager.alert("${generic.alert.title}","${guide.bully.request.usermissing}",0,null);
            return false;
         }
         if(_habboHelp.friendList.getFriend(var_150) != null)
         {
            _habboHelp.windowManager.confirm("${help.cfh.unfriend.confirm.title}","${help.cfh.unfriend.confirm.message}",0x10 | 0x20,onFriendReportConfirmation);
            return false;
         }
         return true;
      }
      
      private function submitCallForHelp() : void
      {
         var _loc1_:int = 0;
         closeWindow();
         switch(var_363 - 1)
         {
            case 0:
            case 3:
               _loc1_ = var_547.reportedRoomId <= 0 ? var_374 : var_547.reportedRoomId;
               _habboHelp.sendMessage(new CallForHelpMessageComposer(var_986,var_1344,var_150,_loc1_,var_547.collectSelectedEntries(var_363,-1),"",""));
               break;
            case 2:
               _habboHelp.sendMessage(new CallForHelpFromIMMessageComposer(var_986,var_1344,var_150,var_547.collectSelectedEntries(3,-1),"",""));
               break;
            case 6:
               _habboHelp.sendMessage(new CallForHelpFromForumThreadMessageComposer(var_1322,var_1287,var_1344,var_986,"",""));
               break;
            case 7:
               _habboHelp.sendMessage(new CallForHelpFromForumMessageMessageComposer(var_1322,var_1287,var_2455,var_1344,var_986,"",""));
         }
         _habboHelp.ignoreAndUnfriendReportedUser();
      }
      
      private function onFriendReportConfirmation(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
            basicInfoDone();
         }
         param1.dispose();
      }
      
      private function onPendingReuqestEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "keep_button":
               case "header_button_close":
                  closeWindow();
                  break;
               case "discard_button":
                  deletePendingCallsForHelp();
                  closeWindow();
            }
         }
      }
      
      private function onCallForHelpReply(param1:IMessageEvent) : void
      {
         var _loc2_:CallForHelpReplyMessageEventParser = CallForHelpReplyMessageEvent(param1).getParser();
         _habboHelp.windowManager.alert("${help.cfh.reply.title}",_loc2_.message,0,null);
      }
      
      private function onCallForHelpResult(param1:IMessageEvent) : void
      {
         var _loc3_:CallForHelpResultMessageEventParser = CallForHelpResultMessageEvent(param1).getParser();
         var _loc4_:int = _loc3_.resultType;
         var _loc2_:String = _loc3_.messageText;
         if(_loc2_ == "")
         {
            _loc2_ = "${help.cfh.sent.text}";
         }
         _habboHelp.windowManager.alert("${help.cfh.sent.title}",_loc2_,0,null);
      }
      
      private function onIssueClose(param1:IssueCloseNotificationMessageEvent) : void
      {
         var _loc3_:IssueCloseNotificationMessageEventParser = param1.getParser();
         var _loc2_:String = _loc3_.messageText;
         if(_loc2_ == "")
         {
            _loc2_ = "${help.cfh.closed." + getCloseReasonKey(_loc3_.closeReason) + "}";
         }
         _habboHelp.windowManager.alert("${mod.alert.title}",_loc2_,0,null);
      }
      
      private function deletePendingCallsForHelp() : void
      {
         _habboHelp.sendMessage(new DeletePendingCallsForHelpMessageComposer());
      }
      
      public function get chatReportController() : ChatReportController
      {
         return var_547;
      }
   }
}

