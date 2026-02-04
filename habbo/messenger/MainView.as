package com.sulake.habbo.messenger
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2483;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendlist.class_1927;
   import com.sulake.habbo.window.widgets.IIlluminaChatBubbleWidget;
   import com.sulake.habbo.window.widgets.IIlluminaInputHandler;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3087;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_14.class_3449;
   import package_28.class_2578;
   import package_28.class_2765;
   import package_28.class_3000;
   import package_71.class_2196;
   import package_9.class_1796;
   import package_9.class_1879;
   
   public class MainView implements class_13, IIlluminaInputHandler
   {
      
      private static const HIDDEN:String = "HIDDEN";
      
      private static const NO_CONVERSATION:int = -1;
      
      private static const NOTIFICATION_ICON_WIDTH:int = 55;
      
      private static const SCROLL_TRIGGER_HEIGHT:int = 150;
      
      private static const COMBINE_MESSAGING_THRESHOLD:int = 600000;
      
      private static const CHAT_ITEM_RENDER_MAX_BUNDLE_SIZE:int = 3;
      
      private static const CHAT_ITEM_RENDER_MAX_MESSAGES_SIZE:int = 7;
      
      private static const CHAT_ITEM_INITIAL_MULTIPLIER:int = 3;
      
      private static const const_1113:int = 40;
      
      private static const const_945:int = 4000;
      
      private static const ERROR_MESSAGES:Dictionary = new Dictionary();
      
      ERROR_MESSAGES[3] = "${messenger.error.receivermuted}";
      ERROR_MESSAGES[4] = "${messenger.error.sendermuted}";
      ERROR_MESSAGES[5] = "${messenger.error.offline}";
      ERROR_MESSAGES[6] = "${messenger.error.notfriend}";
      ERROR_MESSAGES[7] = "${messenger.error.busy}";
      ERROR_MESSAGES[8] = "${messenger.error.receiverhasnochat}";
      ERROR_MESSAGES[9] = "${messenger.error.senderhasnochat}";
      ERROR_MESSAGES[10] = "${messenger.error.offline_failed}";
      ERROR_MESSAGES[11] = "${messenger.error.not_group_member}";
      ERROR_MESSAGES[12] = "${messenger.error.not_group_admin}";
      ERROR_MESSAGES[13] = "${messenger.error.sender_im_unavailable}";
      ERROR_MESSAGES[14] = "${messenger.error.recipient_im_unavailable}";
      
      private var _messenger:HabboMessenger;
      
      private var _frame:class_1812;
      
      private var var_142:IItemListWindow;
      
      private var var_616:class_1812;
      
      private var var_724:int;
      
      private var var_2091:Boolean;
      
      private var var_445:Dictionary = new Dictionary();
      
      private var var_117:int = -1;
      
      private var var_1780:class_1812;
      
      private var var_1767:class_2010;
      
      private var var_1821:class_1812;
      
      private var var_2056:class_1812;
      
      private var var_2139:class_1812;
      
      private var var_1428:Boolean;
      
      private var var_5093:Boolean = false;
      
      private var var_3617:int = 1;
      
      private var var_1802:Dictionary = new Dictionary();
      
      private var var_542:int;
      
      private var _historyFetchesTimestamps:Dictionary = new Dictionary();
      
      private var var_1656:Dictionary = new Dictionary();
      
      public function MainView(param1:HabboMessenger)
      {
         super();
         _messenger = param1;
         _frame = _messenger.getXmlWindow("messenger") as class_1812;
         _frame.visible = false;
         _frame.procedure = messengerWindowProcedure;
         class_2483(_frame.findChildByName("header_button_close")).style = 102;
         var_616 = _frame.findChildByName("avatar_list") as class_1812;
         var_1780 = var_616.getChildAt(0) as class_1812;
         var_616.removeChild(var_1780);
         var_724 = 0;
         var_142 = _frame.findChildByName("conversation") as IItemListWindow;
         var_1767 = var_142.getListItemByName("msg_normal") as class_2010;
         var_1821 = var_142.getListItemByName("msg_notification") as class_1812;
         var_2056 = var_142.getListItemByName("msg_invitation") as class_1812;
         var_2139 = var_142.getListItemByName("msg_info") as class_1812;
         var_142.removeListItems();
         var_542 = -1;
         IIlluminaInputWidget(class_2010(_frame.findChildByName("input_widget")).widget).submitHandler = this;
      }
      
      private static function avatarVisible(param1:class_1741) : Boolean
      {
         return param1 != null && param1.tags.indexOf("HIDDEN") < 0;
      }
      
      private static function setAvatarVisibilityTag(param1:class_1741, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Boolean = avatarVisible(param1);
         if(_loc3_ && !param2)
         {
            param1.tags.push("HIDDEN");
         }
         else if(!_loc3_ && param2)
         {
            param1.tags.splice(param1.tags.indexOf("HIDDEN"),1);
         }
      }
      
      private static function escapeExternalKeys(param1:String) : String
      {
         if(param1.search("\\${") == 0)
         {
            return " " + param1;
         }
         return param1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            var_142 = null;
            var_616 = null;
            if(_frame != null)
            {
               _frame.dispose();
               _frame = null;
            }
            if(var_1767 != null)
            {
               var_1767.dispose();
               var_1767 = null;
            }
            if(var_1821 != null)
            {
               var_1821.dispose();
               var_1821 = null;
            }
            if(var_2056 != null)
            {
               var_2056.dispose();
               var_2056 = null;
            }
            if(var_2139 != null)
            {
               var_2139.dispose();
               var_2139 = null;
            }
            if(var_1780 != null)
            {
               var_1780.dispose();
               var_1780 = null;
            }
            var_445 = null;
            _messenger = null;
            var_1802 = null;
            _historyFetchesTimestamps = null;
            var_1656 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _messenger == null;
      }
      
      public function get isOpen() : Boolean
      {
         return _frame != null && Boolean(_frame.visible);
      }
      
      public function toggle() : void
      {
         if(isOpen)
         {
            hide();
         }
         else
         {
            show();
         }
      }
      
      public function show(param1:Boolean = false) : void
      {
         if(param1 || visibleAvatarCount > 0)
         {
            _frame.visible = true;
            _frame.activate();
         }
         if(var_117 != -1)
         {
            setChatIndicatorVisibility(var_117,false);
         }
      }
      
      public function hide() : void
      {
         _frame.visible = false;
      }
      
      public function startConversation(param1:int, param2:Boolean = true, param3:ChatEntry = null) : void
      {
         if(!(param1 in var_445))
         {
            var_445[param1] = [];
            if(!var_5093)
            {
               recordNotificationMessage(param1,"${messenger.moderationinfo}");
               var_5093 = true;
            }
            var _loc6_:class_1927 = _messenger.getFriend(param1,param3);
            if(!_loc6_)
            {
               ErrorReportStorage.addDebugData("Messenger Mainview","User got start conversation request from nonexistent friend, id: " + param1);
               return;
            }
            if(!null.online)
            {
               recordNotificationMessage(param1,"${messenger.notification.persisted_messages}");
            }
            var _loc9_:class_1812 = var_1780.clone() as class_1812;
            setAvatarVisibilityTag(null,true);
            null.blend = 0;
            null.id = param1;
            if(param1 < 0)
            {
               null.name = String(param1);
            }
            var _loc5_:class_2010 = null.findChildByName("avatar_image") as class_2010;
            var _loc8_:class_2010 = null.findChildByName("group_badge_image") as class_2010;
            if(null.id > 0)
            {
               var _loc7_:class_2478 = null.widget as class_2478;
               null.visible = false;
               null.visible = true;
            }
            else
            {
               var _loc4_:class_3087 = null.widget as class_3087;
               _loc4_.badgeId = null.figure;
               null.groupId = null.id;
               null.visible = true;
               null.visible = false;
            }
            IRegionWindow(null.findChildByName("avatar_click_region")).toolTipCaption = null.name;
            var_616.addChild(null);
            refreshAvatarList();
         }
         if(param2 || !isOpen)
         {
            selectConversation(param1);
         }
         refreshChatCount(param2);
      }
      
      public function addConsoleMessage(param1:int, param2:String, param3:int, param4:String, param5:int, param6:int, param7:String, param8:String) : void
      {
         if(param5 > 0)
         {
            onConfirmOwnChatMessage(param4,param2,param5);
         }
         else
         {
            recordChatMessage(param1,param2,true,param3,param6,param7,param8,param4);
         }
      }
      
      public function addRoomInvite(param1:int, param2:String) : void
      {
         recordInvitationMessage(param1,_messenger.getText("messenger.invitation") + " " + param2,true);
      }
      
      public function setFollowingAllowed(param1:int, param2:Boolean) : void
      {
         if(param1 == var_117)
         {
            refreshButtons();
         }
      }
      
      public function onInstantMessageError(param1:int, param2:int, param3:String) : void
      {
         if(param2 in ERROR_MESSAGES)
         {
            if(param3.length > 0)
            {
               var _loc5_:String = ERROR_MESSAGES[param2];
               var _loc4_:RegExp = /[${}]/g;
               _loc5_ = null.replace(null,"");
               recordNotificationMessage(param1,_messenger.getText(null) + ": " + param3);
            }
            else
            {
               recordNotificationMessage(param1,ERROR_MESSAGES[param2]);
            }
         }
      }
      
      public function setOnlineStatus(param1:int, param2:Boolean) : void
      {
         if(param1 in var_445)
         {
            recordInfoMessage(param1,param2 ? "${messenger.notification.online}" : "${messenger.notification.offline}");
         }
      }
      
      private function selectConversation(param1:int) : void
      {
         var_117 = param1;
         setAvatarVisibilityTag(getAvatarWrapper(param1),true);
         setChatIndicatorVisibility(param1,false);
         refreshConversationList();
         refreshAvatarList();
         var _loc3_:class_1927 = _messenger.getFriend(var_117);
         var _loc2_:String = _loc3_ != null ? _loc3_.name : "";
         _frame.findChildByName("separator_label").visible = var_117 < 0 || _loc3_ != null;
         _messenger.localization.registerParameter("messenger.window.separator","friend_name",_loc2_);
         _messenger.localization.registerParameter("messenger.window.input.default","friend_name",_loc2_);
         _frame.invalidate();
      }
      
      public function hideConversation(param1:int) : void
      {
         var _loc2_:class_1741 = getAvatarWrapper(param1);
         if(_loc2_ != null)
         {
            setAvatarVisibilityTag(_loc2_,false);
         }
         if(visibleAvatarCount == 0)
         {
            selectConversation(-1);
            hide();
         }
         else
         {
            for each(_loc2_ in var_616.iterator)
            {
               if(avatarVisible(_loc2_))
               {
                  var_724 = 0;
                  selectConversation(_loc2_.id);
                  break;
               }
            }
         }
         refreshChatCount();
      }
      
      private function refreshChatCount(param1:Boolean = false) : void
      {
         _messenger.localization.registerParameter("messenger.window.title","open_chat_count",visibleAvatarCount.toString());
         _messenger.conversationCountUpdated(visibleAvatarCount,hasUnreadChat && !param1);
      }
      
      private function recordChatMessage(param1:int, param2:String, param3:Boolean, param4:int, param5:int, param6:String, param7:String, param8:String = "", param9:int = 0) : void
      {
         var _loc10_:ChatEntry = null;
         if(param3)
         {
            recordChatEntry(param1,new ChatEntry(2,param1,param2,param4,param5,param6,param7,param8),true);
         }
         else
         {
            _loc10_ = new ChatEntry(1,param1,param2,param4,param5,param6,param7,param8,param9);
            if(param9 > 0)
            {
               var_1802[param9] = _loc10_;
            }
            recordChatEntry(param1,_loc10_);
         }
      }
      
      private function onConfirmOwnChatMessage(param1:String, param2:String, param3:int) : void
      {
         var _loc5_:ChatEntry = var_1802[param3];
         if(_loc5_ != null)
         {
            _loc5_.isConfirmed(param2,param1);
            var_1656[param1] = true;
            var _loc4_:int = var_142.numListItems;
            var _loc8_:Boolean = false;
            var _loc7_:int = 0;
            delete var_1802[param3];
         }
      }
      
      private function recordNotificationMessage(param1:int, param2:String) : void
      {
         recordChatEntry(param1,new ChatEntry(3,0,param2,0));
      }
      
      private function recordInfoMessage(param1:int, param2:String, param3:Boolean = false) : void
      {
         recordChatEntry(param1,new ChatEntry(4,0,param2,0),param3);
      }
      
      private function recordInvitationMessage(param1:int, param2:String, param3:Boolean = false) : void
      {
         recordChatEntry(param1,new ChatEntry(5,0,param2,0),param3);
      }
      
      private function recordChatEntry(param1:int, param2:ChatEntry, param3:Boolean = false) : void
      {
         if(_messenger == null)
         {
            return;
         }
         if(param2.messageId != "")
         {
            if(param2.messageId in var_1656)
            {
               return;
            }
            var_1656[param2.messageId] = true;
         }
         if(!(param1 in var_445))
         {
            if(param1 <= 0)
            {
               return;
            }
            startConversation(param1,false,param2.type == 2 ? param2 : null);
         }
         var _loc5_:Array = var_445[param1];
         var _loc6_:ChatEntry = _loc5_.length > 0 ? _loc5_[_loc5_.length - 1] : null;
         _loc5_.push(param2);
         var _loc4_:class_1812 = getAvatarWrapper(param1);
         if(_loc4_ != null)
         {
            setAvatarVisibilityTag(_loc4_,true);
            refreshAvatarList();
         }
         if(param1 == var_117)
         {
            addToConversationAndCombine(param2,_loc6_);
            var_142.arrangeListItems();
            var_142.scrollV = 1;
            if(!isOpen && param3)
            {
               setChatIndicatorVisibility(param1,true);
            }
         }
         else
         {
            if(param3)
            {
               setChatIndicatorVisibility(param1,true);
            }
            if(visibleAvatarCount == 1)
            {
               selectConversation(param1);
            }
         }
         refreshChatCount();
      }
      
      private function shouldCombineWithPreviousEntry(param1:int, param2:ChatEntry, param3:ChatEntry) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Array = var_445[param1];
         if(_loc6_.length > 0)
         {
            param3.sentTimeStamp();
            if(param1 > 0)
            {
               if(param2.type == param3.type && (param2.type == 1 || param2.type == 2) && param2.sentTimeStamp() < param3.sentTimeStamp() + 600000)
               {
                  _loc5_ = true;
               }
            }
            else
            {
               _loc4_ = param2.type == 2 && param3.senderId == param2.senderId;
               if(param2.type == param3.type && (param2.type == 1 || _loc4_) && param2.sentTimeStamp() < param3.sentTimeStamp() + 600000)
               {
                  _loc5_ = true;
               }
            }
         }
         return _loc5_;
      }
      
      private function getAvatarWrapper(param1:int) : class_1812
      {
         return var_616.getChildByID(param1) as class_1812;
      }
      
      private function setChatIndicatorVisibility(param1:int, param2:Boolean) : void
      {
         var _loc3_:class_1812 = getAvatarWrapper(param1);
         if(_loc3_ != null)
         {
            _loc3_.findChildByName("chat_indicator").visible = param2;
         }
      }
      
      private function createChatItem(param1:ChatEntry, param2:Boolean = false) : class_1741
      {
         var _loc9_:class_2010 = null;
         var _loc5_:IIlluminaChatBubbleWidget = null;
         var _loc11_:class_1812 = null;
         var _loc10_:class_1741 = null;
         var _loc4_:class_1812 = null;
         var _loc6_:class_1812 = null;
         var _loc3_:* = false;
         var _loc7_:class_1927 = null;
         switch(param1.type - 1)
         {
            case 0:
               _loc9_ = var_1767.clone() as class_2010;
               _loc9_.width = conversationItemWidth;
               _loc5_ = _loc9_.widget as IIlluminaChatBubbleWidget;
               _loc5_.appendMessage(param1.message,false,param1.awaitConfirmationId);
               _loc5_.timeStamp = param1.sentTimeStamp();
               _loc5_.flipped = false;
               _loc5_.figure = _messenger.sessionDataManager.figure;
               _loc5_.userName = _messenger.sessionDataManager.userName;
               _loc7_ = _messenger.getFriend(var_117);
               if(!param2 && _loc7_ != null && !_loc7_.online && (_loc7_.persistedMessageUser || _loc7_.pocketHabboUser))
               {
                  _loc5_.friendOnlineStatus = false;
               }
               return _loc9_;
            case 1:
               _loc9_ = var_1767.clone() as class_2010;
               _loc9_.width = conversationItemWidth;
               _loc5_ = _loc9_.widget as IIlluminaChatBubbleWidget;
               _loc5_.appendMessage(param1.message);
               _loc5_.timeStamp = param1.sentTimeStamp();
               _loc5_.flipped = true;
               for each(var _loc8_ in var_616.iterator)
               {
                  _loc3_ = _loc8_ != null && _loc8_.id == var_117;
                  if(!_loc3_ && _loc8_ != null && var_117 < 0)
                  {
                     _loc3_ = Number(_loc8_.name) == var_117;
                  }
                  if(_loc3_)
                  {
                     _loc5_.figure = param1.senderFigure;
                     _loc5_.userId = param1.senderId;
                     _loc5_.userName = param1.senderName;
                     break;
                  }
               }
               return _loc9_;
            case 2:
               _loc4_ = var_1821.clone() as class_1812;
               _loc4_.findChildByName("content").width = conversationItemWidth - 55;
               _loc4_.findChildByName("content").caption = param1.message;
               return _loc4_;
            case 3:
               _loc11_ = var_2139.clone() as class_1812;
               _loc10_ = _loc11_.findChildByName("content");
               _loc10_.limits.minWidth = conversationItemWidth;
               _loc10_.limits.maxWidth = conversationItemWidth;
               _loc10_.caption = param1.message;
               return _loc11_;
            case 4:
               _loc6_ = var_2056.clone() as class_1812;
               _loc6_.findChildByName("content").width = conversationItemWidth - 55;
               _loc6_.findChildByName("content").caption = param1.message;
               return _loc6_;
            default:
               return null;
         }
      }
      
      private function appendChatEntry(param1:ChatEntry) : class_1741
      {
         var _loc2_:class_1741 = createChatItem(param1);
         var_142.addListItem(_loc2_);
         return _loc2_;
      }
      
      private function adjustListItemWidths() : void
      {
         var _loc1_:int = 0;
         var _loc2_:class_1741 = null;
         _loc1_ = 0;
         while(_loc1_ < var_142.numListItems)
         {
            _loc2_ = var_142.getListItemAt(_loc1_);
            switch(_loc2_.name)
            {
               case "msg_notification":
                  class_1812(_loc2_).findChildByName("content").width = conversationItemWidth - 55;
                  break;
               case "msg_info":
                  var _loc3_:class_1741 = class_1812(_loc2_).findChildByName("content");
                  null.limits.minWidth = conversationItemWidth;
                  null.limits.maxWidth = conversationItemWidth;
                  break;
               case "msg_normal":
            }
            _loc2_.width = conversationItemWidth;
            _loc1_++;
         }
         var_142.arrangeListItems();
         _frame.invalidate();
      }
      
      private function get conversationItemWidth() : int
      {
         return _frame.width - 27;
      }
      
      private function refreshButtons() : void
      {
         IItemListWindow(_frame.findChildByName("button_strip")).arrangeListItems();
      }
      
      public function loadMessageHistory(param1:int, param2:Array) : void
      {
         var _loc4_:Array = [];
         var _loc3_:int = _messenger.sessionDataManager.userId;
         for each(var _loc5_ in param2)
         {
            if(!(_loc5_.messageId in var_1656))
            {
               var _loc6_:ChatEntry = new ChatEntry(_loc5_.senderId == _loc3_ ? 1 : 2,param1,_loc5_.message,_loc5_.secondsSinceSent,_loc5_.senderId,_loc5_.senderName,_loc5_.senderFigure,_loc5_.messageId);
               _loc4_.push(null);
            }
         }
         if(_loc4_.length == 0)
         {
            return;
         }
         var _loc7_:Array = var_445[param1];
         if(_loc7_ == null)
         {
            _loc7_ = [];
            var_445[param1] = _loc7_;
         }
         var_445[param1] = _loc4_.concat(_loc7_);
         if(param1 == var_117)
         {
            if(var_542 != -1)
            {
               var_542 += _loc4_.length;
            }
            addMissingChatEntries();
         }
      }
      
      private function requestHistory(param1:int) : void
      {
         var _loc4_:Object = null;
         var _loc2_:Array = var_445[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc5_:String = "";
         if(_loc2_.length > 0)
         {
            _loc5_ = _loc2_[0].messageId;
         }
         var _loc3_:int = getTimer();
         if(param1 in _historyFetchesTimestamps)
         {
            _loc4_ = _historyFetchesTimestamps[param1];
            if(_loc4_.messageId == _loc5_ && _loc4_.time + 4000 > _loc3_)
            {
               return;
            }
         }
         _historyFetchesTimestamps[param1] = {
            "messageId":_loc5_,
            "time":_loc3_
         };
         _messenger.send(new class_3000(param1,_loc5_));
      }
      
      private function refreshConversationList() : void
      {
         var_1428 = true;
         var_142.destroyListItems();
         var_542 = -1;
         scrollBack(true);
         var_142.arrangeListItems();
         var_142.scrollV = 1;
         var_1428 = false;
      }
      
      private function addToConversationAndCombine(param1:ChatEntry, param2:ChatEntry, param3:Boolean = false) : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:class_2010 = null;
         var _loc4_:IIlluminaChatBubbleWidget = null;
         var _loc6_:Boolean = false;
         if(param2 != null && shouldCombineWithPreviousEntry(var_117,param1,param2))
         {
            _loc5_ = param3 ? 0 : var_142.numListItems - 1;
            if(_loc5_ >= 0)
            {
               _loc7_ = var_142.getListItemAt(_loc5_) as class_2010;
               if(_loc7_ != null)
               {
                  _loc4_ = _loc7_.widget as IIlluminaChatBubbleWidget;
                  if(_loc4_ != null)
                  {
                     _loc4_.appendMessage(param1.message,param3,param1.awaitConfirmationId);
                     if(!param3)
                     {
                        _loc4_.timeStamp = param1.sentTimeStamp();
                     }
                     _loc6_ = true;
                  }
               }
            }
         }
         if(!_loc6_)
         {
            if(param3)
            {
               var_142.addListItemAt(createChatItem(param1,true),0);
            }
            else
            {
               appendChatEntry(param1);
            }
         }
         return _loc6_;
      }
      
      private function addMissingChatEntries() : void
      {
         if(-var_142.scrollableRegion.y > 150)
         {
            return;
         }
         var_1428 = true;
         var _loc1_:Number = Number(var_142.scrollV);
         var _loc2_:int = int(var_142.scrollableRegion.height);
         scrollBack();
         var_142.arrangeListItems();
         var_142.scrollV = 1 - _loc2_ * (1 - _loc1_) / var_142.scrollableRegion.height;
         var_1428 = false;
      }
      
      private function scrollBack(param1:Boolean = false) : void
      {
         var _loc7_:int = 0;
         var _loc4_:ChatEntry = null;
         var _loc2_:Array = var_445[var_117];
         if(_loc2_ == null)
         {
            requestHistory(var_117);
            return;
         }
         var _loc10_:int = int(var_542 == -1 ? _loc2_.length : var_542);
         var _loc3_:int = int(param1 ? 3 : 1);
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:ChatEntry = var_542 == -1 ? null : _loc2_[var_542];
         _loc7_ = _loc10_ - 1;
         while(_loc7_ >= 0)
         {
            _loc4_ = _loc2_[_loc7_];
            if(!addToConversationAndCombine(_loc4_,_loc5_,true))
            {
               _loc8_ += 1;
            }
            _loc5_ = _loc4_;
            _loc6_ += 1;
            var_542 = _loc7_;
            if(_loc8_ >= 3 * _loc3_)
            {
               var _loc9_:Boolean = true;
            }
            if(_loc6_ >= 7 * _loc3_)
            {
               break;
            }
            _loc7_--;
         }
         if(var_542 < 40)
         {
            requestHistory(var_117);
         }
      }
      
      private function refreshAvatarList() : void
      {
         var_2091 = false;
         for each(var _loc4_ in var_616.iterator)
         {
            var _loc1_:* = _loc4_.id == var_117;
            if(_loc4_.name.length > 0)
            {
               _loc1_ = Number(_loc4_.name) == var_117;
            }
            var _loc2_:Boolean = avatarVisible(_loc4_);
            _loc4_.visible = false;
         }
         _frame.findChildByName("avatars_scroll_left").visible = var_724 > 0;
         _frame.findChildByName("avatars_scroll_right").visible = var_2091;
      }
      
      private function get visibleAvatarCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_616.iterator)
         {
            if(avatarVisible(_loc2_))
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function get hasUnreadChat() : Boolean
      {
         for each(var _loc2_ in var_616.iterator)
         {
            if(avatarVisible(_loc2_))
            {
               var _loc1_:class_1812 = class_1812(_loc2_);
            }
         }
         return false;
      }
      
      private function messengerWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WE_RESIZE":
               if(param2 == _frame)
               {
                  adjustListItemWidths();
                  refreshAvatarList();
               }
               break;
            case "WE_RELOCATED":
               if(param2.name == "_CONTAINER" && !var_1428)
               {
                  addMissingChatEntries();
               }
               break;
            case "WME_CLICK":
               switch(param2.name)
               {
                  case "avatar_click_region":
                     selectConversation(param2.parent.id);
                     break;
                  case "avatars_scroll_left":
                     if(var_724 > 0)
                     {
                        var_724 = var_724 - 1;
                        refreshAvatarList();
                     }
                     break;
                  case "avatars_scroll_right":
                     if(var_2091)
                     {
                        var_724 = var_724 + 1;
                        refreshAvatarList();
                     }
                     break;
                  case "close_conversation_button":
                     hideConversation(var_117);
                     break;
                  case "follow_button":
                     if(var_117 > 0)
                     {
                        _messenger.send(new class_2765(var_117));
                        _messenger.send(new class_2196("Navigation","IM","go.im"));
                        break;
                     }
                     _messenger.followingToGroupRoom = true;
                     _messenger.send(new class_1796(Math.abs(var_117),false));
                     break;
                  case "profile_button":
                     if(var_117 > 0)
                     {
                        _messenger.send(new class_1879(var_117));
                        _messenger.trackGoogle("extendedProfile","messenger_conversation");
                        break;
                     }
                     _messenger.send(new class_1796(Math.abs(var_117),true));
                     _messenger.trackGoogle("extendedProfile","messenger_conversation");
                     break;
                  case "report_button":
                     _messenger.reportUser(var_117);
                     break;
                  case "header_button_close":
                     hide();
               }
         }
      }
      
      public function onInput(param1:class_2010, param2:String) : void
      {
         if(param2 == "")
         {
            return;
         }
         var _loc5_:int = var_3617;
         var_3617 += 1;
         _messenger.send(new class_2578(var_117,param2,_loc5_));
         IIlluminaInputWidget(param1.widget).message = "";
         var _loc3_:Array = var_445[var_117];
         if(_loc3_.length == 0 || _loc3_.length == 1 && ChatEntry(_loc3_[0]).type == 3)
         {
            _messenger.playSendSound();
         }
         var _loc4_:String = _messenger.sessionDataManager.figure;
         var _loc6_:String = _messenger.sessionDataManager.userName;
         var _loc7_:int = _messenger.sessionDataManager.userId;
         recordChatMessage(var_117,escapeExternalKeys(param2),false,0,_loc7_,_loc6_,_loc4_,"",_loc5_);
      }
   }
}

