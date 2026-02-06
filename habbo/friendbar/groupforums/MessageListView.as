package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_2670;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3434;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3591;
   
   public class MessageListView
   {
      
      private static const UNREAD_MESSAGE_STATUS:int = -1;
      
      private static const const_509:int = 20;
      
      private static const QUOTE_BG_COLOR:uint = 4291611852;
      
      public static const LINE_PATTERN:RegExp = /\\?(?:(?:\*([^*]+)\*)|(?:_([^_]+)_)|(?:@\S+))/;
      
      public static const const_30:RegExp = /^>(?: ?|$)/;
      
      private var var_55:GroupForumController;
      
      private var var_172:GroupForumView;
      
      private var var_121:IScrollableListWindow;
      
      private var var_3400:class_1812;
      
      private var var_95:class_3591;
      
      private var var_1096:class_3434;
      
      private var var_1459:MessagesListData;
      
      private var var_1306:Boolean = true;
      
      public function MessageListView(param1:GroupForumView, param2:IScrollableListWindow, param3:class_3591, param4:class_3434, param5:MessagesListData)
      {
         super();
         var_172 = param1;
         var_55 = var_172.controller;
         var_121 = param2;
         var_3400 = var_55.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_message_list_item_xml())) as class_1812;
         var_95 = param3;
         var_1096 = param4;
         var_1459 = param5;
      }
      
      private static function getMessageColor(param1:int) : Array
      {
         switch(param1)
         {
            case 10:
               return [4293519840,4292335567];
            case 20:
               return [4294952634,4294959058];
            case -1:
               return [4294964441,4291227641];
            case 0:
            case 1:
            default:
               return [4294967295,4291227641];
         }
      }
      
      private static function initMessageText(param1:ITextWindow, param2:String) : void
      {
         var _loc8_:int = 0;
         var _loc5_:* = undefined;
         var _loc3_:class_1812 = class_1812(param1.parent);
         _loc3_.removeChild(param1);
         var _loc9_:Array = param2.split("\r");
         var _loc4_:StringBuffer = new StringBuffer();
         var _loc7_:int = 0;
         for each(var _loc6_ in _loc9_)
         {
            _loc8_ = 0;
            _loc5_ = const_30.exec(_loc6_);
            if(_loc5_ != null)
            {
               _loc8_ = 1;
               _loc6_ = _loc6_.substr(_loc5_[0].length);
            }
            if(_loc8_ != _loc7_)
            {
               addTextBlock(_loc3_,param1,_loc4_,_loc7_);
               _loc7_ = _loc8_;
            }
            else if(_loc4_.length > 0)
            {
               _loc4_.add("\r");
            }
            parseMessageChunk(_loc4_,_loc6_);
         }
         addTextBlock(_loc3_,param1,_loc4_,_loc7_);
      }
      
      private static function parseMessageChunk(param1:StringBuffer, param2:String) : void
      {
         var _loc3_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc4_:String = null;
         while(true)
         {
            _loc3_ = LINE_PATTERN.exec(param2);
            if(!_loc3_)
            {
               break;
            }
            if(_loc3_.index > 0)
            {
               param1.addEscaped(param2.substr(0,_loc3_.index));
            }
            _loc5_ = Number(_loc3_[0].length);
            switch(param2.charAt(_loc3_.index))
            {
               case "*":
                  param1.add(" <b>");
                  parseMessageChunk(param1,param2.substr(_loc3_.index + 1,_loc5_ - 2));
                  param1.add("</b> ");
                  break;
               case "_":
                  param1.add(" <i>");
                  parseMessageChunk(param1,param2.substr(_loc3_.index + 1,_loc5_ - 2));
                  param1.add("</i> ");
                  break;
               case "@":
                  if(_loc3_.index == 0 || _loc3_.index > 0 && param2.substr(_loc3_.index - 1,1) == " ")
                  {
                     _loc4_ = param2.substr(_loc3_.index + 1,_loc5_ - 1);
                     param1.add("<u>").addEscaped(_loc4_).add("</u>");
                     break;
                  }
                  param1.add("@");
               default:
                  param1.add(param2.charAt(_loc3_.index + 1));
                  param2 = param2.substr(_loc3_.index + 2);
                  continue;
            }
            param2 = param2.substr(_loc3_.index + _loc5_);
         }
         param1.addEscaped(param2);
      }
      
      private static function addTextBlock(param1:class_1812, param2:ITextWindow, param3:StringBuffer, param4:int) : void
      {
         var _loc6_:String = param3.toString();
         var _loc5_:ITextWindow = ITextWindow(param2.clone());
         param1.addChild(_loc5_);
         _loc5_.htmlText = _loc6_;
         if(param4 > 0)
         {
            _loc5_.x += param4 * 20;
            _loc5_.width -= (param4 + 1) * 20;
            _loc5_.color = 4291611852;
            _loc5_.background = true;
         }
         param3.reset();
      }
      
      public function update() : void
      {
         if(var_121.numListItems > 0)
         {
            var_121.destroyListItems();
         }
         var_121.invalidate();
         var _loc2_:int = var_55.getThreadLastReadMessageIndex(var_1459.threadId);
         var_1306 = true;
         var_121.autoArrangeItems = false;
         for each(var _loc1_ in var_1459.messages)
         {
            var _loc3_:* = _loc1_.messageIndex > _loc2_;
            var_121.addListItem(createListItem(_loc1_,false));
         }
         var_1306 = false;
         updateItemSizes();
      }
      
      public function updateItemSizes() : void
      {
         if(var_1306)
         {
            return;
         }
         var _loc1_:Number = Number(var_121.scrollableWindow.width);
         updateItemSizesInternal();
         if(var_121.scrollableWindow.width != _loc1_)
         {
            updateItemSizesInternal();
         }
      }
      
      private function updateItemSizesInternal() : void
      {
         var _loc5_:int = 0;
         var _loc1_:class_1812 = null;
         var _loc3_:class_1812 = null;
         var _loc4_:class_1812 = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:ITextWindow = null;
         var_121.autoArrangeItems = false;
         _loc5_ = 0;
         while(_loc5_ < var_121.numListItems)
         {
            _loc1_ = class_1812(var_121.getListItemAt(_loc5_));
            _loc3_ = _loc1_.findChildByName("texts_container") as class_1812;
            _loc4_ = class_1812(_loc1_.findChildByName("message_text_container"));
            _loc1_.width = var_121.scrollableWindow.width - 2;
            _loc7_ = 2;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.numChildren)
            {
               _loc2_ = ITextWindow(_loc4_.getChildAt(_loc6_));
               _loc2_.y = _loc7_;
               _loc7_ = int(_loc2_.bottom);
               _loc6_++;
            }
            _loc4_.height = _loc7_;
            _loc1_.height = _loc3_.height + _loc4_.bottom;
            _loc5_++;
         }
         var_121.autoArrangeItems = true;
      }
      
      private function createListItem(param1:class_2670, param2:Boolean = false) : class_1812
      {
         var _loc4_:class_1812 = var_3400.clone() as class_1812;
         _loc4_.name = "message_" + param1.messageId;
         var _loc11_:int = param1.state;
         var _loc8_:Boolean = var_95.canModerate;
         var _loc6_:Boolean = var_95.isStaff;
         var _loc9_:class_1812 = _loc4_.findChildByName("texts_container") as class_1812;
         _loc9_.id = param1.messageId;
         _loc9_.findChildByName("date").caption = var_172.getAsDaysHoursMinutes(param1.creationTimeAsSecondsAgo);
         _loc9_.findChildByName("reply_num").caption = "#" + (param1.messageIndex + 1);
         var _loc5_:ITextWindow = _loc4_.findChildByName("message_text") as ITextWindow;
         if(param2)
         {
            _loc11_ = -1;
         }
         if(_loc11_ == 20 && !_loc6_)
         {
            _loc5_.text = getModerationMessage(param1);
         }
         else if(_loc11_ > 1 && !_loc8_)
         {
            _loc5_.text = getModerationMessage(param1);
         }
         else
         {
            initMessageText(_loc5_,param1.messageText);
         }
         var _loc3_:class_1812 = _loc4_.findChildByName("msg_container") as class_1812;
         var _loc12_:Array = getMessageColor(_loc11_);
         _loc3_.color = _loc12_[0];
         var _loc10_:class_1812 = _loc4_.findChildByName("avatar_image") as class_1812;
         var _loc7_:Array = getMessageColor(_loc11_);
         _loc10_.color = _loc7_[1];
         _loc10_.id = param1.authorId;
         _loc10_.removeEventListener("WME_CLICK",onSelectAuthor);
         _loc10_.addEventListener("WME_CLICK",onSelectAuthor);
         class_2478(class_2010(_loc10_.findChildByName("avatar_widget")).widget).figure = param1.authorFigure;
         _loc10_.findChildByName("author").caption = param1.authorName;
         _loc10_.findChildByName("author_post_count").caption = param1.authorPostCount + " " + var_55.localizationManager.getLocalization("messageboard.messages","posts");
         handleButtonVisibility(_loc4_,param1,_loc11_);
         return _loc4_;
      }
      
      public function updateElement(param1:class_2670) : void
      {
         var _loc3_:int = param1.messageId;
         var _loc2_:class_1812 = var_121.getListItemByName("message_" + _loc3_) as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = int(var_121.getListItemIndex(_loc2_));
         var_1306 = true;
         var_121.autoArrangeItems = false;
         var_121.removeListItemAt(_loc4_);
         var_121.addListItemAt(createListItem(param1),_loc4_);
         var_1306 = false;
         updateItemSizes();
      }
      
      private function handleButtonVisibility(param1:class_1812, param2:class_2670, param3:int) : void
      {
         var _loc9_:IRegionWindow = null;
         var _loc7_:Boolean = var_95.canModerate;
         var _loc6_:Boolean = var_95.isStaff;
         var _loc4_:Boolean = var_95.canReport;
         var _loc5_:Boolean = var_95.canPostMessage;
         _loc9_ = param1.findChildByName("delete_message") as IRegionWindow;
         _loc9_.removeEventListener("WME_CLICK",onDelete);
         _loc9_.removeEventListener("WME_CLICK",onUndelete);
         if(_loc7_)
         {
            _loc9_.id = param2.messageId;
            var _loc8_:IStaticBitmapWrapperWindow = _loc9_.getChildByName("icon") as IStaticBitmapWrapperWindow;
            switch(param3)
            {
               case 10:
                  _loc9_.addEventListener("WME_CLICK",onUndelete);
                  null.assetUri = "forum_forum_unhide";
                  break;
               case 20:
                  if(_loc6_)
                  {
                     _loc9_.addEventListener("WME_CLICK",onUndelete);
                     null.assetUri = "forum_forum_unhide";
                     break;
                  }
                  _loc9_.visible = false;
                  break;
               case 0:
               case 1:
               default:
                  _loc9_.addEventListener("WME_CLICK",onDelete);
                  null.assetUri = "forum_forum_hide";
            }
         }
         else
         {
            _loc9_.visible = false;
         }
         _loc9_ = param1.findChildByName("report_message") as IRegionWindow;
         if(_loc4_)
         {
            _loc9_.id = param2.messageId;
            _loc9_.removeEventListener("WME_CLICK",onReport);
            _loc9_.addEventListener("WME_CLICK",onReport);
         }
         else
         {
            _loc9_.visible = false;
         }
         _loc9_ = param1.findChildByName("reply_message") as IRegionWindow;
         if(_loc5_)
         {
            _loc9_.id = param2.messageId;
            _loc9_.removeEventListener("WME_CLICK",onReply);
            _loc9_.addEventListener("WME_CLICK",onReply);
         }
         else
         {
            _loc9_.visible = false;
         }
      }
      
      private function getModerationMessage(param1:class_2670) : String
      {
         switch(param1.state - 10)
         {
            case 0:
               return var_55.localizationManager.getLocalizationWithParams("groupforum.view.message_hidden_by_admin","","admin_name",param1.adminName);
            case 10:
               return var_55.localizationManager.getLocalizationWithParams("groupforum.view.message_hidden_by_staff","","admin_name",param1.adminName);
            default:
               return null;
         }
      }
      
      public function scrollToSpecificElement(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:class_1812 = null;
         if(!param2)
         {
            _loc3_ = var_121.getListItemByName("message_" + param1) as class_1812;
         }
         else
         {
            _loc3_ = var_121.getListItemAt(param1 - 1) as class_1812;
         }
         if(_loc3_ != null)
         {
            var_121.scrollV = _loc3_.bottom / var_121.maxScrollV;
         }
      }
      
      private function onReport(param1:WindowMouseEvent) : void
      {
         var_55.reportMessage(var_95,var_1096.threadId,param1.target.id);
      }
      
      private function onUndelete(param1:WindowMouseEvent) : void
      {
         var_55.unDeleteMessage(var_95,var_1096.threadId,param1.target.id);
      }
      
      private function onDelete(param1:WindowMouseEvent) : void
      {
         var_55.deleteMessage(var_95,var_1096.threadId,param1.target.id);
      }
      
      private function onSelectAuthor(param1:WindowMouseEvent) : void
      {
         var_55.getUserInfo(param1.target.id);
      }
      
      private function onReply(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = param1.target.id;
         var _loc3_:class_2670 = var_1459.messagesById[_loc2_];
         if(_loc3_ == null)
         {
            return;
         }
         var_172.openComposeMessageView(var_1096,_loc3_);
      }
   }
}

