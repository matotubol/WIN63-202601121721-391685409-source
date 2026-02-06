package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class IlluminaChatBubbleWidget implements IIlluminaChatBubbleWidget
   {
      
      public static const TYPE:String = "illumina_chat_bubble";
      
      private static const const_277:String = "illumina_chat_bubble:flipped";
      
      private static const USER_NAME_KEY:String = "illumina_chat_bubble:user_name";
      
      private static const FIGURE_KEY:String = "illumina_chat_bubble:figure";
      
      private static const MESSAGE_KEY:String = "illumina_chat_bubble:message";
      
      private static var RESIZING_OFFSETS:int = 10;
      
      private static const FLIPPED_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:flipped",false,"Boolean");
      
      private static const USER_NAME_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:user_name","","String");
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:figure","","String");
      
      private static const MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:message","","String");
      
      private var var_3425:ITextWindow;
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_2053:Boolean = Boolean(FLIPPED_DEFAULT.value);
      
      private var _userName:ILabelWindow;
      
      private var var_1410:class_1741;
      
      private var _avatarWidget:class_2478;
      
      private var var_1152:class_1741;
      
      private var _postTime:class_3111;
      
      private var _offline:IRegionWindow;
      
      private var _arrowPoint:IStaticBitmapWrapperWindow;
      
      private var var_1899:Boolean;
      
      private var var_489:IItemListWindow;
      
      private var var_4921:IItemListWindow;
      
      private var var_1759:Array = [];
      
      private var var_5114:int = 0;
      
      public function IlluminaChatBubbleWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_chat_bubble_xml").content as XML) as class_1812;
         var_489 = var_134.findChildByName("message_container") as IItemListWindow;
         var_3425 = var_489.getListItemByName("message_template") as ITextWindow;
         var_489.removeListItem(var_3425);
         var_4921 = var_134.findChildByName("spaced_message_container") as IItemListWindow;
         _userName = var_134.findChildByName("user_name") as ILabelWindow;
         var _loc3_:class_2010 = var_134.findChildByName("user_avatar") as class_2010;
         var_1410 = _loc3_.parent;
         _avatarWidget = _loc3_.widget as class_2478;
         var_1152 = var_134.findChildByName("bubble_wrapper");
         _postTime = class_2010(var_134.findChildByName("post_time")).widget as class_3111;
         _offline = var_134.findChildByName("offline_placeholder") as IRegionWindow;
         _offline.height = 0;
         _arrowPoint = var_134.findChildByName("arrow_point") as IStaticBitmapWrapperWindow;
         var_134.findChildByName("message_region").setParamFlag(1,false);
         var_134.procedure = rootProcedure;
         userName = String(USER_NAME_DEFAULT.value);
         figure = String(FIGURE_DEFAULT.value);
         setMessages(getMessagesFromProperty(String(MESSAGE_DEFAULT.value)));
         var_210.rootWindow = var_134;
         var_210.setParamFlag(147456);
         var_134.width = var_210.width;
      }
      
      public static function getMessagesFromProperty(param1:String) : Array
      {
         var _loc2_:Array = param1.split("\t");
         if(_loc2_.length == 1 && _loc2_[0] == "")
         {
            return [];
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FLIPPED_DEFAULT.withValue(flipped));
         _loc1_.push(USER_NAME_DEFAULT.withValue(userName));
         _loc1_.push(FIGURE_DEFAULT.withValue(figure));
         _loc1_.push(MESSAGE_DEFAULT.withValue(getMessages().join("\t")));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_chat_bubble:flipped":
                  flipped = Boolean(_loc2_.value);
                  break;
               case "illumina_chat_bubble:user_name":
                  userName = String(_loc2_.value);
                  break;
               case "illumina_chat_bubble:figure":
                  figure = String(_loc2_.value);
                  break;
               case "illumina_chat_bubble:message":
                  setMessages(getMessagesFromProperty(String(_loc2_.value)));
            }
         }
      }
      
      public function get flipped() : Boolean
      {
         return var_2053;
      }
      
      public function set flipped(param1:Boolean) : void
      {
         var_2053 = param1;
         refresh();
      }
      
      public function get userName() : String
      {
         return _userName.caption.slice(0,-1);
      }
      
      public function set userName(param1:String) : void
      {
         _userName.caption = param1 + ":";
      }
      
      public function get userId() : int
      {
         return _avatarWidget.userId;
      }
      
      public function set userId(param1:int) : void
      {
         _avatarWidget.userId = param1;
      }
      
      public function get figure() : String
      {
         return _avatarWidget.figure;
      }
      
      public function set figure(param1:String) : void
      {
         _avatarWidget.figure = param1;
      }
      
      public function get timeStamp() : Number
      {
         return _postTime.timeStamp;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         _postTime.timeStamp = param1;
      }
      
      public function set friendOnlineStatus(param1:Boolean) : void
      {
         _offline.height = !param1 ? 16 : 0;
      }
      
      public function refresh() : void
      {
         if(var_1899)
         {
            return;
         }
         var_1899 = true;
         var_134.limits.minWidth = var_134.width;
         var_134.limits.maxWidth = var_134.width;
         var_134.height = var_1152.bottom;
         var_1152.width = var_134.width - var_1410.width;
         var _loc2_:int = var_1152.width / RESIZING_OFFSETS;
         if(_loc2_ != var_5114)
         {
            var _loc1_:int = 0;
            while(0 < var_489.numListItems)
            {
               var _loc3_:ITextWindow = var_489.getListItemAt(0) as ITextWindow;
               null.width = var_1152.width - 5;
               _loc1_ = 0 + 1;
            }
            var_5114 = _loc2_;
         }
         var_489.width = var_1152.width;
         var_4921.width = var_1152.width;
         _avatarWidget.direction = var_2053 ? 4 : 2;
         if(var_2053)
         {
            var_1410.x = var_134.width - var_1410.width;
            _arrowPoint.zoomX = 1;
            _arrowPoint.x = var_1410.x;
            var_1152.x = 0;
         }
         else
         {
            var_1410.x = 0;
            _arrowPoint.zoomX = -1;
            _arrowPoint.x = var_1410.right - _arrowPoint.width;
            var_1152.x = var_1410.right;
         }
         var_134.limits.setEmpty();
         _arrowPoint.invalidate();
         var_1899 = false;
      }
      
      private function rootProcedure(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WE_RESIZED":
               refresh();
               break;
            case "WE_CHILD_RESIZED":
               refresh();
               break;
            case "WME_CLICK":
               if(userId > 0 && param2.name == "user_name_region")
               {
                  _windowManager.communication.connection.send(new GetExtendedProfileMessageComposer(userId));
               }
         }
      }
      
      public function get numMessages() : int
      {
         return var_489.numListItems;
      }
      
      public function getMessage(param1:int) : String
      {
         return var_489.getListItemAt(param1).caption;
      }
      
      public function setMessage(param1:int, param2:String) : void
      {
         while(param1 >= numMessages)
         {
            var_489.addListItem(createMessage());
            var_1759.push(0);
         }
         var_489.getListItemAt(param1).caption = param2;
      }
      
      public function appendMessage(param1:String, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         if(param2)
         {
            _loc4_ = 0;
            var_489.addListItemAt(createMessage(),0);
            var_1759.splice(_loc4_,0,0);
         }
         else
         {
            _loc4_ = numMessages;
         }
         setMessage(_loc4_,param1);
         setAwaitingConfirmationId(_loc4_,param3);
      }
      
      private function setMessages(param1:Array) : void
      {
         var_489.removeListItems();
         var_1759.length = 0;
         for each(var _loc2_ in param1)
         {
            appendMessage(_loc2_);
         }
      }
      
      public function getMessages() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < numMessages)
         {
            _loc1_.push(getMessage(_loc2_));
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      public function setAwaitingConfirmationId(param1:int, param2:int) : void
      {
         var _loc3_:ITextWindow = var_489.getListItemAt(param1) as ITextWindow;
         _loc3_.textColor = param2 > 0 ? 9079434 : 0;
         var_1759[param1] = param2;
      }
      
      public function clearAwaitingConfirmationId(param1:int) : void
      {
         var _loc2_:ITextWindow = var_489.getListItemAt(param1) as ITextWindow;
         _loc2_.textColor = 0;
         var_1759[param1] = 0;
      }
      
      public function getAwaitingConfirmationId(param1:int) : int
      {
         return var_1759[param1];
      }
      
      private function createMessage() : ITextWindow
      {
         return var_3425.clone() as ITextWindow;
      }
   }
}

