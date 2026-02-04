package com.sulake.habbo.moderation
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.StringUtil;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import package_74.class_3823;
   import package_74.class_4059;
   import package_79.class_3291;
   
   public class ChatlogCtrl implements class_13, ITrackedWindow, class_2879
   {
      
      private static var CHAT_LINE_POOL_MAX_SIZE:int = 1000;
      
      private static const CHAT_REPORTED_USER_COLOUR:uint = 4293973667;
      
      private static const CHAT_REPORTEE_COLOUR:uint = 4288921072;
      
      private static var CHAT_LINE_POOL:Array = [];
      
      private var var_230:int;
      
      private var var_197:int;
      
      private var _msg:IMessageComposer;
      
      private var _main:ModerationManager;
      
      private var _frame:class_1812;
      
      private var var_121:IItemListWindow;
      
      private var _rooms:Array;
      
      private var _embedded:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_1488:class_1812;
      
      private var var_2179:class_1812;
      
      private var _hilitedUserIds:Dictionary;
      
      private var var_908:Timer;
      
      private var var_3325:class_55;
      
      private var var_2726:class_3291;
      
      private var var_1433:Array = [];
      
      private var _headers:Array = [];
      
      public function ChatlogCtrl(param1:IMessageComposer, param2:ModerationManager, param3:int, param4:int, param5:class_3291 = null, param6:class_1812 = null, param7:IItemListWindow = null, param8:Boolean = false)
      {
         super();
         _main = param2;
         var_230 = param3;
         var_197 = param4;
         _msg = param1;
         var_3325 = new class_55();
         var_2726 = param5;
         _frame = param6;
         var_121 = param7;
         _embedded = param8;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var _loc1_:class_2250 = class_2250(_main.getXmlWindow("evidence_frame"));
         _loc1_.visible = false;
         var _loc3_:IItemListWindow = IItemListWindow(_loc1_.findChildByName("evidence_list"));
         var_2179 = _loc3_.getListItemAt(0) as class_1812;
         var_1488 = _loc3_.getListItemAt(1) as class_1812;
         _loc3_.removeListItems();
         var_908 = new Timer(1000,1);
         var_908.addEventListener("timer",onResizeTimer);
         if(!_embedded)
         {
            _frame = _loc1_;
            _frame.procedure = onWindow;
            _frame.visible = true;
            var _loc2_:class_1741 = _frame.findChildByTag("close");
            null.procedure = onClose;
            var_121 = _loc3_;
         }
         else
         {
            _loc1_.dispose();
         }
         _main.connection.send(_msg);
         _main.messageHandler.addChatlogListener(this);
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      public function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         var _loc6_:* = null;
         if(param2 != var_230 || param3 != var_197 || _disposed)
         {
            return;
         }
         for each(_loc6_ in var_1433)
         {
            recycleContentLine(_loc6_);
         }
         for each(_loc6_ in _headers)
         {
            _loc6_.dispose();
         }
         var_1433 = [];
         _headers = [];
         _main.messageHandler.removeChatlogListener(this);
         _rooms = param4;
         _hilitedUserIds = param5;
         populate();
         onResizeTimer(null);
         if(!_embedded)
         {
            _frame.caption = param1;
            _frame.visible = true;
         }
      }
      
      public function getType() : int
      {
         return var_230;
      }
      
      public function getId() : String
      {
         return "" + var_197;
      }
      
      public function setId(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function getFrame() : class_2250
      {
         return _frame as class_2250;
      }
      
      private function populate() : void
      {
         var _loc1_:* = null;
         var_121.autoArrangeItems = false;
         var_121.removeListItems();
         for each(_loc1_ in _rooms)
         {
            populateEvidence(_loc1_);
         }
         var_121.autoArrangeItems = true;
      }
      
      private function populateEvidence(param1:class_4059) : void
      {
         var _loc10_:String = null;
         var _loc7_:int = 0;
         var _loc8_:class_3823 = null;
         var _loc6_:class_1812 = createHeaderLine();
         var _loc9_:class_1741 = _loc6_.findChildByName("text");
         var _loc2_:class_1775 = class_1775(_loc6_.findChildByName("btnHeaderAction"));
         var _loc3_:class_1775 = class_1775(_loc6_.findChildByName("btnHeaderAction2"));
         if(_loc3_)
         {
            _loc3_.visible = false;
         }
         switch(param1.recordType - 1)
         {
            case 0:
               if(param1.roomId > 0)
               {
                  _loc2_.caption = "Room tool";
                  if(param1.roomName == null)
                  {
                     _loc9_.caption = "Room #" + param1.roomId;
                  }
                  else
                  {
                     _loc9_.caption = "Room: " + param1.roomName;
                  }
                  _loc3_.visible = true;
                  _loc3_.caption = "View room";
                  new OpenRoomInSpectatorMode(_main,_loc3_,param1.roomId);
                  if(_embedded)
                  {
                     new OpenRoomTool(null,_main,_loc2_,param1.roomId);
                     break;
                  }
                  new OpenRoomTool(_frame as class_2250,_main,_loc2_,param1.roomId);
               }
               break;
            case 1:
               _loc9_.caption = "IM session";
               break;
            case 2:
               _loc9_.caption = "Forum thread";
               _loc3_.visible = true;
               _loc3_.caption = "Open thread";
               new OpenDiscussionThread(_main,_loc3_,param1.groupId,param1.threadId);
               _loc2_.caption = "Delete";
               new HideDiscussionThread(_main,this,_loc2_,param1.groupId,param1.threadId);
               break;
            case 3:
               _loc9_.caption = "Forum message";
               _loc3_.visible = true;
               _loc3_.caption = "Open Message";
               new OpenDiscussionMessage(_main,_loc3_,param1.groupId,param1.threadId,param1.context.messageIndex);
               _loc2_.caption = "Delete";
               new HideDiscussionMessage(_main,this,_loc2_,param1.groupId,param1.threadId,param1.messageId);
               break;
            case 4:
               _loc9_.caption = "Selfie report";
               _loc3_.visible = true;
               _loc3_.caption = "View selfie";
               new OpenExternalLink(_main,_loc3_,param1.context.url);
               _loc2_.visible = true;
               _loc2_.caption = "Room tool";
               if(_embedded)
               {
                  new OpenRoomTool(null,_main,_loc2_,param1.roomId);
                  break;
               }
               new OpenRoomTool(_frame as class_2250,_main,_loc2_,param1.roomId);
               break;
            case 5:
               _loc9_.caption = "Photo report";
               _loc3_.visible = true;
               _loc3_.caption = "Moderate photo";
               _loc10_ = _main.getProperty("stories.admin.tool.base.url");
               if(StringUtil.isEmpty(_loc10_))
               {
                  _loc10_ = "https://theallseeingeye.sulake.com/habbo-stories-admin/#/photos/";
               }
               _loc10_ += param1.context.extraDataId;
               new OpenExternalLink(_main,_loc3_,_loc10_);
               _loc2_.visible = true;
               _loc2_.caption = "Room tool";
               if(_embedded)
               {
                  new OpenRoomTool(null,_main,_loc2_,param1.roomId);
                  break;
               }
               new OpenRoomTool(_frame as class_2250,_main,_loc2_,param1.roomId);
         }
         addHeaderLineToList(_loc6_);
         var _loc4_:* = true;
         var _loc5_:int = -1;
         _loc7_ = 0;
         while(_loc7_ < param1.chatlog.length)
         {
            _loc8_ = param1.chatlog[_loc7_];
            populateContentLine(_loc8_,_loc4_);
            _loc4_ = !_loc4_;
            if(_loc8_.hasHighlighting && _loc5_ == -1)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         if(_loc5_ > -1)
         {
            var_121.autoArrangeItems = true;
            if(var_121.maxScrollV > 0)
            {
               var_121.scrollV = var_121.getListItemAt(_loc5_).y / var_121.maxScrollV;
            }
         }
      }
      
      private function addContentLineToList(param1:class_1812) : void
      {
         var_121.addListItem(param1);
         var_1433.push(param1);
      }
      
      private function addHeaderLineToList(param1:class_1812) : void
      {
         var_121.addListItem(param1);
         _headers.push(param1);
      }
      
      private function createContentLine() : class_1812
      {
         if(CHAT_LINE_POOL.length > 0)
         {
            return CHAT_LINE_POOL.pop() as class_1812;
         }
         return class_1812(var_1488.clone());
      }
      
      private function recycleContentLine(param1:class_1812) : void
      {
         if(CHAT_LINE_POOL.length < CHAT_LINE_POOL_MAX_SIZE)
         {
            var _loc2_:ITextWindow = ITextWindow(param1.findChildByName("chatter_txt"));
            null.removeEventListener("WME_CLICK",onUserClick);
            param1.width = var_1488.width;
            param1.height = var_1488.height - 10;
            CHAT_LINE_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function createHeaderLine() : class_1812
      {
         return var_2179.clone() as class_1812;
      }
      
      private function populateContentLine(param1:class_3823, param2:Boolean) : void
      {
         var _loc5_:TextFormat = null;
         var _loc7_:class_1812 = createContentLine();
         var _loc8_:class_1741 = _loc7_.findChildByName("time_txt");
         var _loc4_:ITextWindow = ITextWindow(_loc7_.findChildByName("chatter_txt"));
         var _loc6_:ITextWindow = _loc7_.findChildByName("msg_txt") as ITextWindow;
         _loc8_.caption = param1.timeStamp;
         var _loc9_:* = _hilitedUserIds[param1.chatterId];
         if(_loc9_ != null)
         {
            _loc7_.color = _loc9_ as int == 0 ? 4293973667 : 4288921072;
         }
         else
         {
            _loc7_.color = param2 ? 4291030266 : 4294967295;
         }
         if(param1.hasHighlighting)
         {
            _loc5_ = _loc6_.getTextFormat();
            _loc5_.bold = true;
            _loc6_.setTextFormat(_loc5_);
            _loc6_.bold = true;
         }
         if(param1.chatterId > 0)
         {
            _loc4_.text = param1.chatterName;
            _loc4_.underline = true;
            _loc4_.addEventListener("WME_CLICK",onUserClick);
            if(!var_3325.getValue(param1.chatterName))
            {
               var_3325.add(param1.chatterName,param1.chatterId);
            }
         }
         else if(param1.chatterId == 0)
         {
            _loc4_.text = "Bot / pet";
            _loc4_.underline = false;
         }
         else
         {
            _loc4_.text = "-";
            _loc4_.underline = false;
         }
         _loc4_.color = _loc7_.color;
         _loc8_.color = _loc7_.color;
         _loc6_.color = _loc7_.color;
         _loc6_.text = param1.msg;
         var _loc3_:int = Math.max(_loc8_.height,_loc6_.textHeight + 5);
         _loc6_.height = _loc3_;
         if(_loc6_.getTextFormat())
         {
            _loc6_.getTextFormat().align = "left";
            _loc6_.getTextFormat().rightMargin = _loc6_.getTextFormat().rightMargin + 10;
         }
         _loc4_.height = _loc3_;
         _loc8_.height = _loc3_;
         _loc7_.height = _loc3_;
         addContentLineToList(_loc7_);
      }
      
      private function onUserClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = param1.target.caption;
         var _loc3_:int = var_3325.getValue(_loc2_);
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,_loc3_,var_2726),_frame as class_2250,false,false,true);
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         var_908.reset();
         var_908.start();
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshListDims();
         var _loc2_:Boolean = refreshScrollBarVisibility();
      }
      
      private function refreshListDims() : void
      {
         var _loc4_:class_1812 = null;
         var _loc3_:int = 0;
         var_121.autoArrangeItems = false;
         var _loc1_:int = var_121.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = class_1812(var_121.getListItemAt(_loc3_));
            if(_loc4_.name == "chatline")
            {
               var _loc2_:ITextWindow = ITextWindow(_loc4_.findChildByName("msg_txt"));
               null.width = _loc4_.width - null.x;
               null.height = null.textHeight + 5;
               _loc4_.height = null.height;
            }
            _loc3_++;
         }
         var_121.autoArrangeItems = true;
      }
      
      private function refreshScrollBarVisibility() : Boolean
      {
         var _loc2_:class_1812 = class_1812(var_121.parent);
         var _loc4_:class_1741 = _loc2_.getChildByName("scroller") as class_1741;
         var _loc3_:* = var_121.scrollableRegion.height > var_121.height;
         if(_loc4_.visible)
         {
            if(_loc3_)
            {
               return false;
            }
            _loc4_.visible = false;
            var_121.width += 22;
            return true;
         }
         if(_loc3_)
         {
            _loc4_.visible = true;
            var_121.width -= 22;
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main = null;
         _msg = null;
         var_2726 = null;
         if(var_121 != null)
         {
            var_121.removeListItems();
            var_121.dispose();
            var_121 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _rooms = null;
         _hilitedUserIds = null;
         if(var_908 != null)
         {
            var_908.stop();
            var_908.removeEventListener("timer",onResizeTimer);
            var_908 = null;
         }
         if(!_embedded)
         {
            for each(var _loc1_ in var_1433)
            {
               recycleContentLine(null);
            }
            for each(_loc1_ in _headers)
            {
               null.dispose();
            }
         }
         var_1433 = [];
         _headers = [];
         if(var_1488 != null)
         {
            var_1488.dispose();
            var_1488 = null;
         }
         if(var_2179 != null)
         {
            var_2179.dispose();
            var_2179 = null;
         }
      }
   }
}

