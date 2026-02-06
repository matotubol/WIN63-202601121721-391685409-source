package com.sulake.habbo.help
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.help.cfh.registry.chat.ChatRegistryItem;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistryItem;
   import com.sulake.habbo.help.cfh.registry.user.UserRegistryItem;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_2218;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_3499;
   import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewSessionCreateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumThreadMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromPhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromIMMessageComposer;
   
   public class TopicsFlowHelpController implements class_13
   {
      
      private static const START_CONTAINER:String = "start_container";
      
      private static const HELP_CONTAINER:String = "help_container";
      
      private static const USERS_CONTAINER:String = "users_container";
      
      private static const USER_CONTAINER:String = "user";
      
      private static const REASON_CONTAINER:String = "reason_container";
      
      private static const TOPIC_CONTAINER:String = "topic_container";
      
      private static const MESSAGE_CONTAINER:String = "message_container";
      
      private static const CHAT_CONTAINER:String = "chat_container";
      
      private static const BACK_BUTTON:String = "back_button";
      
      private static const SUMMARY_CONTAINER:String = "summary_container";
      
      private static const UNLAWFUL_MESSAGE_CONTENT:String = "unlawful_message_content";
      
      private static const HELP_MESSAGE:String = "help_message";
      
      private static const MESSAGE_CONTAINER_DESCRIPTION:String = "message_container_description";
      
      private static const const_656:String = "unlawful_message_confirm";
      
      private static const MESSAGE_NAME_INPUT:String = "help_message_name";
      
      private static const MESSAGE_EMAIL_INPUT:String = "help_message_email";
      
      private static const CONTINUE_BUTTON:String = "continue_button";
      
      private static const FIELD_MAX_CHARS:int = 253;
      
      private static const TOPIC_NAME_BULLYING:String = "bullying";
      
      private static const TOPIC_NAME_BAD_USER_NAME:String = "habbo_name";
      
      private static const DEFAULT_REPORT_MESSAGE_DESCRIPTION:String = "help.emergency.main.step.one.description";
      
      private static const UNLAWFUL_REPORT_MESSAGE_TITLE:String = "help.cfh.unlawful_activity.reason_description";
      
      private static const REQUIRES_CONTINUE_BUTTON:Array = ["users_container","message_container","chat_container"];
      
      private static const REQUIRES_USER_DATA:Array = ["reason_container","message_container","chat_container","summary_container"];
      
      private var _habboHelp:HabboHelp;
      
      private var _disposed:Boolean = false;
      
      private var var_607:IModalDialog;
      
      private var var_18:class_1812;
      
      private var _containers:Vector.<String>;
      
      private var var_1476:IItemListWindow;
      
      private var var_440:IItemListWindow;
      
      private var var_1387:IItemListWindow;
      
      private var var_3936:class_1812;
      
      private var var_3062:class_1812;
      
      private var var_3663:class_1812;
      
      private var var_805:String = "start_container";
      
      private var var_592:class_3499;
      
      private var var_1814:String;
      
      private var var_986:String;
      
      private var _reportedUserName:String;
      
      private var var_773:int = -1;
      
      private var var_4312:Boolean = false;
      
      private var var_2739:Array = ["unlawful_activity"];
      
      public function TopicsFlowHelpController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _containers = new Vector.<String>(0);
         _containers.push("start_container","help_container","users_container","user","reason_container","message_container","chat_container","back_button","summary_container");
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         _habboHelp = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function openReportingUserName() : void
      {
         var_4312 = true;
         showReportingDialog(-1,false);
         var_592 = getTopic("habbo_name");
         var_18.findChildByName("message_phase_title").caption = _habboHelp.localization.getLocalization("generic.reason") + " " + _habboHelp.localization.getLocalization("help.cfh.topic." + var_592.id);
         showContainer("message_container");
      }
      
      public function openReportingChatLineSelection() : void
      {
         showReportingDialog(-1,true);
         if(!userChatLinesAvailable())
         {
            return;
         }
         showContainer("chat_container");
         populateChatMessage();
      }
      
      public function openReportingContentReasonCategory(param1:int) : Boolean
      {
         showReportingDialog(param1,false);
         var _loc2_:Boolean = showReasons(param1);
         if(!_loc2_)
         {
            closeWindow();
         }
         return _loc2_;
      }
      
      public function openReportingIMSelection() : void
      {
         showReportingDialog(3,false);
         showContainer("chat_container");
         populateInstantMessages();
         if(var_1387.numListItems == 0)
         {
            _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.no_user_data}",0,null);
            closeWindow();
         }
      }
      
      private function showReportingDialog(param1:int, param2:Boolean) : void
      {
         var_773 = param1;
         if(var_607 == null)
         {
            openWindow();
         }
         var_18.findChildByName("change_user").visible = param2;
      }
      
      private function openWindow() : void
      {
         if(var_607 == null && !disposed)
         {
            var_607 = _habboHelp.getModalXmlWindow("topics_flow_help");
            var_607.rootWindow.procedure = windowEventProcedure;
            var_18 = var_607.rootWindow as class_1812;
            var_1476 = var_18.findChildByName("user_list") as IItemListWindow;
            var_440 = var_18.findChildByName("reason_list") as IItemListWindow;
            var_1387 = var_18.findChildByName("chat_list") as IItemListWindow;
            var_3936 = var_1476.getListItemAt(0) as class_1812;
            var_3062 = var_440.getListItemAt(0) as class_1812;
            var_3663 = var_1387.getListItemAt(0) as class_1812;
            var_1476.removeListItems();
            var_440.removeListItems();
            var_1387.removeListItems();
            IIlluminaInputWidget(class_2010(var_18.findChildByName("help_message")).widget).maxChars = 253;
            if(!_habboHelp.getBoolean("my.reports.status.enabled"))
            {
               var_607.rootWindow.findChildByName("reports_status_bitmap").visible = false;
               var_607.rootWindow.findChildByName("reports_status").visible = false;
            }
            deselectChatEntries();
         }
      }
      
      public function closeWindow() : void
      {
         if(var_607 != null)
         {
            var_607.dispose();
            var_607 = null;
         }
         var_805 = "start_container";
      }
      
      public function toggleWindow() : void
      {
         if(var_607 == null)
         {
            var_773 = -1;
            openWindow();
            showContainer("start_container");
         }
         else
         {
            closeWindow();
         }
      }
      
      private function showContainer(param1:String) : void
      {
         for each(var _loc2_ in _containers)
         {
            var_18.findChildByName(_loc2_).visible = false;
         }
         var_18.findChildByName("continue_button").visible = REQUIRES_CONTINUE_BUTTON.indexOf(param1) > -1;
         var_18.findChildByName("user").visible = REQUIRES_USER_DATA.indexOf(param1) > -1;
         var_805 = param1;
         updateBackButtonVisibility();
         var_18.findChildByName(param1).visible = true;
         if(param1 == "message_container")
         {
            var _loc3_:* = var_2739.indexOf(var_1814) > -1;
            var_18.findChildByName("unlawful_message_content").visible = false;
            var_18.findChildByName("help_message").height = 220;
            var_18.findChildByName("message_container_description").caption = _habboHelp.localization.getLocalization("help.emergency.main.step.one.description");
         }
         if(REQUIRES_USER_DATA.indexOf(param1) > -1)
         {
            updateUserData();
         }
      }
      
      private function updateBackButtonVisibility() : void
      {
         var _loc1_:* = true;
         if(var_805 == "start_container")
         {
            _loc1_ = false;
         }
         else if(var_773 == 3)
         {
            _loc1_ = var_805 != "chat_container";
         }
         else if(var_773 > -1)
         {
            _loc1_ = var_805 != "reason_container";
         }
         else if(var_4312)
         {
            _loc1_ = var_805 != "message_container";
         }
         var_18.findChildByName("back_button").visible = _loc1_;
      }
      
      private function verifyUserSelected() : Boolean
      {
         if(_habboHelp.reportedUserId == -1)
         {
            _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${guide.bully.request.usermissing}",0,null);
            return false;
         }
         return true;
      }
      
      private function verifyMessage() : Boolean
      {
         if(var_2739.indexOf(var_1814) > -1)
         {
            if(!(var_18.findChildByName("unlawful_message_confirm") as class_1885).isSelected || IIlluminaInputWidget(class_2010(var_18.findChildByName("help_message_name")).widget).message == "" || IIlluminaInputWidget(class_2010(var_18.findChildByName("help_message_email")).widget).message == "")
            {
               _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.emergency.main.step.one.description}",0,null);
               return false;
            }
         }
         var_986 = IIlluminaInputWidget(class_2010(var_18.findChildByName("help_message")).widget).message;
         if(var_986 == null || var_986 == "")
         {
            _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.nomsg}",0,null);
            return false;
         }
         if(var_986.length < _habboHelp.getInteger("help.cfh.length.minimum",15))
         {
            _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.msgtooshort}",0,null);
            return false;
         }
         return true;
      }
      
      private function verifySelectedChatLines() : Boolean
      {
         var _loc1_:Array = _habboHelp.callForHelpManager.chatReportController.collectSelectedEntries(var_773,_habboHelp.reportedUserId);
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.chatmissing}",0,null);
            return false;
         }
         return true;
      }
      
      private function windowEventProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               closeWindow();
               break;
            case "back_button":
               switch(var_805)
               {
                  case "reason_container":
                     showContainer("chat_container");
                     break;
                  case "topic_container":
                  case "message_container":
                     showContainer("reason_container");
                     populateReasons();
                     break;
                  case "chat_container":
                     if(populateUsers())
                     {
                        showContainer("users_container");
                        break;
                     }
                     showContainer("start_container");
                     break;
                  case "summary_container":
                     showContainer("message_container");
                     break;
                  default:
                     showContainer("start_container");
               }
               break;
            case "continue_button":
               switch(var_805)
               {
                  case "users_container":
                     if(verifyUserSelected())
                     {
                        showContainer("chat_container");
                        populateChatMessage();
                     }
                     break;
                  case "message_container":
                     if(verifyMessage())
                     {
                        showContainer("summary_container");
                     }
                     break;
                  case "chat_container":
                     if(verifySelectedChatLines())
                     {
                        showContainer("reason_container");
                        populateReasons();
                     }
                     break;
                  default:
                     showContainer("start_container");
               }
               break;
            case "button_habbo_help":
               showContainer("help_container");
               break;
            case "button_user_report":
            case "change_user":
               if(populateUsers())
               {
                  showContainer("users_container");
                  break;
               }
               _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.nochathistory}",0,null);
               break;
            case "button_account":
               HabboWebTools.openWebPage(_habboHelp.getProperty("zendesk.url"),"habboMain");
               _habboHelp.trackGoogle("helpWindow","click_selfHelp");
               closeWindow();
               break;
            case "tour_button":
               _habboHelp.guideHelpManager.createHelpRequest(_habboHelp.newIdentity ? 0 : 2);
               _habboHelp.trackGoogle("helpWindow","click_userTour");
               closeWindow();
               break;
            case "bully_button":
               closeWindow();
               _habboHelp.toggleNewHelpWindow();
               _habboHelp.trackGoogle("helpWindow","click_reportBully");
               break;
            case "instructions_button":
               _habboHelp.guideHelpManager.createHelpRequest(1);
               _habboHelp.trackGoogle("helpWindow","click_instructions");
               closeWindow();
               break;
            case "safetybooklet_link":
               _habboHelp.showSafetyBooklet();
               _habboHelp.trackGoogle("helpWindow","click_showSafetyBooklet");
               closeWindow();
               break;
            case "habboway_link":
               if(_habboHelp.getBoolean("habboway.enabled"))
               {
                  _habboHelp.showHabboWay();
               }
               else
               {
                  HabboWebTools.openWebPage(_habboHelp.getProperty("habboway.url"),"habboMain");
               }
               _habboHelp.trackGoogle("helpWindow","click_habboWay");
               closeWindow();
               break;
            case "faq_link":
               _habboHelp.openCfhFaq();
               break;
            case "sanction_info_link":
               _habboHelp.requestSanctionInfo(false);
               closeWindow();
               break;
            case "reports_status":
               _habboHelp.requestReportsStatus();
               closeWindow();
               break;
            case "submit_button":
               if(var_592)
               {
                  submitCallForHelp(true);
                  closeWindow();
                  break;
               }
               _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.notopic}",0,null);
         }
      }
      
      public function submitCallForHelp(param1:Boolean) : void
      {
         if(!var_986 || !var_592 || !_habboHelp)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(var_2739.indexOf(var_1814) > -1)
         {
            _loc2_ = IIlluminaInputWidget(class_2010(var_18.findChildByName("help_message_name")).widget).message;
            _loc3_ = IIlluminaInputWidget(class_2010(var_18.findChildByName("help_message_email")).widget).message;
         }
         _habboHelp.ignoreAndUnfriendReportedUser();
         switch(var_773 - 3)
         {
            case 0:
               _habboHelp.sendMessage(new CallForHelpFromIMMessageComposer(var_986,var_592.id,_habboHelp.reportedUserId,_habboHelp.callForHelpManager.chatReportController.collectSelectedEntries(3,_habboHelp.reportedUserId),_loc2_,_loc3_));
               break;
            case 1:
               _habboHelp.sendMessage(new CallForHelpMessageComposer(var_986,var_592.id,-1,_habboHelp.reportedRoomId,[],_loc2_,_loc3_));
               break;
            case 4:
               _habboHelp.sendMessage(new CallForHelpFromForumThreadMessageComposer(_habboHelp.callForHelpManager.reportedGroupId,_habboHelp.callForHelpManager.reportedThreadId,var_592.id,var_986,_loc2_,_loc3_));
               break;
            case 5:
               _habboHelp.sendMessage(new CallForHelpFromForumMessageMessageComposer(_habboHelp.callForHelpManager.reportedGroupId,_habboHelp.callForHelpManager.reportedThreadId,_habboHelp.callForHelpManager.reportedMessageId,var_592.id,var_986,_loc2_,_loc3_));
               break;
            case 6:
               _habboHelp.sendMessage(new CallForHelpFromPhotoMessageComposer(_habboHelp.reportedExtraDataId,_habboHelp.reportedRoomId,_habboHelp.reportedUserId,var_592.id,_habboHelp.reportedRoomObjectId,_loc2_,_loc3_));
               break;
            default:
               if(param1 && var_592.name == "bullying" && _habboHelp.getBoolean("guides.enabled") && _habboHelp.guardiansEnabled)
               {
                  _habboHelp.sendMessage(new ChatReviewSessionCreateMessageComposer(_habboHelp.reportedUserId,_habboHelp.reportedRoomId));
                  break;
               }
               _habboHelp.sendMessage(new CallForHelpMessageComposer(var_986,var_592.id,_habboHelp.reportedUserId,_habboHelp.reportedRoomId,_habboHelp.callForHelpManager.chatReportController.collectSelectedEntries(1,-1),_loc2_,_loc3_));
         }
      }
      
      private function populateUsers() : Boolean
      {
         var _loc5_:* = undefined;
         var _loc1_:class_1812 = null;
         var _loc2_:* = false;
         var_1476.removeListItems();
         var _loc3_:int = 0;
         var _loc6_:Boolean = false;
         for each(var _loc4_ in _habboHelp.userRegistry.getRegistry())
         {
            _loc5_ = _habboHelp.chatRegistry.getItemsByUser(_loc4_.userId);
            if(_loc5_.length != 0)
            {
               _loc1_ = var_3936.clone() as class_1812;
               _loc2_ = _loc4_.userId == _habboHelp.reportedUserId;
               _loc1_.name = _loc4_.userId.toString();
               _loc1_.findChildByName("user_bg").blend = _loc2_ ? 1 : 0;
               _loc1_.procedure = onUserSelectEvent;
               _loc1_.findChildByName("user_name").caption = _loc4_.userName;
               _loc1_.findChildByName("room_name").id = _loc4_.roomId;
               if(_loc2_)
               {
                  _habboHelp.reportedRoomId = _loc4_.roomId;
               }
               _loc1_.findChildByName("room_name").caption = _loc4_.roomName != "" ? _habboHelp.localization.getLocalizationWithParams("help.emergency.main.step.two.room.name","","room_name",_loc4_.roomName) : "";
               class_2478(class_2010(_loc1_.findChildByName("user_avatar")).widget).figure = _loc4_.figure;
               var_1476.addListItemAt(_loc1_,_loc3_);
               if(_loc2_)
               {
                  _loc3_ = 1;
                  _loc6_ = true;
               }
            }
         }
         if(!_loc6_)
         {
            _habboHelp.reportedUserId = -1;
            _habboHelp.reportedRoomId = -1;
         }
         return var_1476.numListItems > 0;
      }
      
      private function refreshUserList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_1812 = null;
         _loc2_ = 0;
         while(_loc2_ < var_1476.numListItems)
         {
            _loc1_ = class_1812(var_1476.getListItemAt(_loc2_));
            _loc1_.findChildByName("user_bg").blend = int(_loc1_.name) == _habboHelp.reportedUserId ? 1 : 0;
            _loc2_++;
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
         var _loc2_:int = int(param1.name);
         _habboHelp.reportedUserId = _loc2_;
         _habboHelp.reportedRoomId = param1.findChildByName("room_name").id;
         refreshUserList();
      }
      
      private function populateRoomReportButton() : void
      {
         var_440.destroyListItems();
         var _loc3_:int = int(var_440.height);
         var_440.height = 0;
         var_440.height = _loc3_;
         var _loc4_:class_1812 = var_3062.clone() as class_1812;
         _habboHelp.localization.registerParameter("help.cfh.topic." + 34,"name",_reportedUserName);
         var _loc1_:ITextWindow = _loc4_.findChildByName("name") as ITextWindow;
         _loc1_.caption = "${help.cfh.topic." + 34 + "}";
         if(_loc1_.height < _loc1_.textHeight)
         {
            _loc1_.height = _loc1_.textHeight + 5;
         }
         if(_loc4_.height < _loc1_.height + _loc1_.y * 2 + 5)
         {
            _loc4_.height = _loc1_.height + _loc1_.y * 2 + 5;
         }
         _loc4_.name = "inappropiate_room_group_event";
         _loc4_.addEventListener("WME_CLICK",onReportTopic);
         var_440.addListItem(_loc4_);
         var_1814 = "room_report";
      }
      
      private function populateReasons() : void
      {
         var _loc1_:class_1812 = null;
         var_440.destroyListItems();
         for each(var _loc2_ in _habboHelp.callForHelpCategories)
         {
            _loc1_ = var_3062.clone() as class_1812;
            _loc1_.findChildByName("name").caption = "${help.cfh.reason." + _loc2_.name + "}";
            _loc1_.name = _loc2_.name;
            _loc1_.addEventListener("WME_CLICK",populateTopicsEvent);
            var_440.addListItem(_loc1_);
         }
      }
      
      private function populateTopicsEvent(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.target;
         populateTopics(_loc2_.name);
         var_1814 = _loc2_.name;
      }
      
      private function populateTopics(param1:String) : Boolean
      {
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:class_1812 = null;
         var _loc2_:ITextWindow = null;
         for each(var _loc7_ in _habboHelp.callForHelpCategories)
         {
            if(_loc7_.name == param1)
            {
               _loc5_ = _loc7_.topics;
               break;
            }
         }
         if(_loc5_ && _loc5_.length > 0)
         {
            var_440.destroyListItems();
            _loc3_ = int(var_440.height);
            var_440.height = 0;
            var_440.height = _loc3_;
            for each(var _loc6_ in _loc5_)
            {
               _loc4_ = var_3062.clone() as class_1812;
               _habboHelp.localization.registerParameter("help.cfh.topic." + _loc6_.id,"name",_reportedUserName);
               _loc2_ = _loc4_.findChildByName("name") as ITextWindow;
               _loc2_.caption = "${help.cfh.topic." + _loc6_.id + "}";
               if(_loc2_.height < _loc2_.textHeight)
               {
                  _loc2_.height = _loc2_.textHeight + 5;
               }
               if(_loc4_.height < _loc2_.height + _loc2_.y * 2 + 5)
               {
                  _loc4_.height = _loc2_.height + _loc2_.y * 2 + 5;
               }
               _loc4_.name = _loc6_.name;
               _loc4_.addEventListener("WME_CLICK",onReportTopic);
               var_440.addListItem(_loc4_);
            }
            var_805 = "topic_container";
            updateBackButtonVisibility();
            return true;
         }
         return false;
      }
      
      private function populateChatMessage() : void
      {
         var _loc1_:class_1812 = null;
         var _loc2_:ITextLinkWindow = null;
         var _loc3_:class_1885 = null;
         var_1387.removeListItems();
         _habboHelp.chatRegistry.holdPurges = true;
         var _loc4_:Vector.<ChatRegistryItem> = _habboHelp.reportedUserId > 0 ? _habboHelp.chatRegistry.getItemsByUser(_habboHelp.reportedUserId) : _habboHelp.chatRegistry.getItems();
         class_21.log("Found chat items: " + _loc4_.length + " from user:" + _habboHelp.reportedUserId);
         for each(var _loc5_ in _loc4_)
         {
            if(_loc5_.userId != _habboHelp.ownUserId)
            {
               _loc1_ = var_3663.clone() as class_1812;
               _loc2_ = _loc1_.findChildByName("chat_text") as ITextLinkWindow;
               _loc2_.caption = _loc5_.text;
               if(_loc2_.height < _loc2_.textHeight)
               {
                  _loc2_.height = _loc2_.textHeight + 5;
               }
               if(_loc1_.height < _loc2_.height + _loc2_.y * 2)
               {
                  _loc1_.height = _loc2_.height + _loc2_.y * 2;
               }
               _loc1_.id = _loc5_.index;
               _loc1_.procedure = onChatEntryEvent;
               _loc3_ = _loc1_.findChildByName("chat_check") as class_1885;
               _loc3_.isSelected = _loc5_.selected;
               var_1387.addListItem(_loc1_);
            }
         }
      }
      
      private function deselectChatEntries() : void
      {
         for each(var _loc2_ in _habboHelp.instantMessageRegistry.getItems())
         {
            for each(var _loc3_ in _loc2_)
            {
               _loc3_.selected = false;
            }
         }
         for each(var _loc1_ in _habboHelp.chatRegistry.getItems())
         {
            _loc1_.selected = false;
         }
      }
      
      private function onChatEntryEvent(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1885 = null;
         var _loc5_:ChatRegistryItem = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = param2.id;
            if(param2 is ITextLinkWindow)
            {
               _loc3_ = param2.parent.id;
               _loc4_ = (param2.parent as class_1812).findChildByName("chat_check") as class_1885;
            }
            if(param2 is class_1885)
            {
               _loc3_ = param2.parent.id;
               _loc4_ = param2 as class_1885;
            }
            _loc5_ = _habboHelp.chatRegistry.getItem(_loc3_);
            if(!_loc5_)
            {
               return;
            }
            if(!_loc5_.selected && _loc5_.roomId != _habboHelp.reportedRoomId)
            {
               _habboHelp.reportedRoomId = _loc5_.roomId;
            }
            _loc5_.selected = !_loc5_.selected;
            _loc4_.isSelected = _loc5_.selected;
         }
      }
      
      private function populateInstantMessages() : void
      {
         var _loc1_:class_1812 = null;
         var _loc2_:class_1885 = null;
         var_1387.removeListItems();
         _habboHelp.instantMessageRegistry.holdPurges = true;
         var _loc3_:Vector.<InstantMessageRegistryItem> = _habboHelp.instantMessageRegistry.getItemsByUser(_habboHelp.reportedUserId);
         for each(var _loc4_ in _loc3_)
         {
            _loc1_ = var_3663.clone() as class_1812;
            _loc1_.findChildByName("chat_text").caption = _loc4_.text;
            _loc1_.id = _loc4_.index;
            _loc1_.procedure = onInstantMessageEntryEvent;
            _loc2_ = _loc1_.findChildByName("chat_check") as class_1885;
            _loc2_.isSelected = _loc4_.selected;
            var_1387.addListItem(_loc1_);
         }
      }
      
      private function onInstantMessageEntryEvent(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1885 = null;
         var _loc5_:InstantMessageRegistryItem = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = param2.id;
            if(param2 is ITextLinkWindow)
            {
               _loc3_ = param2.parent.id;
               _loc4_ = (param2.parent as class_1812).findChildByName("chat_check") as class_1885;
            }
            else if(param2 is class_1885)
            {
               _loc3_ = param2.parent.id;
               _loc4_ = param2 as class_1885;
            }
            _loc5_ = _habboHelp.instantMessageRegistry.getItem(_habboHelp.reportedUserId,_loc3_);
            if(_loc5_)
            {
               _loc5_.selected = !_loc5_.selected;
               _loc4_.isSelected = _loc5_.selected;
            }
         }
      }
      
      private function onReportTopic(param1:class_1758 = null) : void
      {
         if(var_607 == null)
         {
            openWindow();
         }
         var_592 = getTopic(param1.target.name);
         showContainer("message_container");
      }
      
      private function isNotNeededToSelectUser() : Boolean
      {
         return var_773 == 4 || var_773 == 7 || var_773 == 8;
      }
      
      private function showReasons(param1:int) : Boolean
      {
         if(isNotNeededToSelectUser() || verifyUserSelected())
         {
            showContainer("reason_container");
            if(param1 == 4)
            {
               populateRoomReportButton();
            }
            else
            {
               populateReasons();
            }
            return true;
         }
         return false;
      }
      
      private function userChatLinesAvailable() : Boolean
      {
         populateUsers();
         if(_habboHelp.reportedUserId <= 0)
         {
            _habboHelp.windowManager.alertWithModal("${generic.alert.title}","${help.cfh.error.no_user_data}",0,null);
            closeWindow();
            return false;
         }
         return true;
      }
      
      private function getTopic(param1:String) : class_3499
      {
         for each(var _loc3_ in _habboHelp.callForHelpCategories)
         {
            for each(var _loc2_ in _loc3_.topics)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function updateUserData() : void
      {
         var _loc1_:UserRegistryItem = null;
         switch(var_773 - 4)
         {
            case 0:
               var_18.findChildByName("reported_user_avatar").visible = false;
               var_18.findChildByName("user_info_title").visible = false;
               var_18.findChildByName("reported_user_name").caption = _habboHelp.callForHelpManager.reportedRoomName;
               break;
            case 3:
            case 4:
               var_18.findChildByName("reported_user_avatar").visible = false;
               var_18.findChildByName("user_info_title").visible = false;
               var_18.findChildByName("reported_user_name").visible = false;
               break;
            default:
               if(_habboHelp.reportedUserId > 0)
               {
                  _loc1_ = _habboHelp.userRegistry.getEntry(_habboHelp.reportedUserId);
                  if(_loc1_)
                  {
                     _reportedUserName = _loc1_.userName;
                     class_2478(class_2010(var_18.findChildByName("reported_user_avatar")).widget).figure = _loc1_.figure;
                  }
                  else
                  {
                     var_18.findChildByName("reported_user_avatar").visible = false;
                     _reportedUserName = _habboHelp.reportedUserName;
                  }
                  var_18.findChildByName("reported_user_name").caption = _reportedUserName;
               }
         }
      }
   }
}

