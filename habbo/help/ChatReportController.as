package com.sulake.habbo.help
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.help.cfh.registry.chat.ChatRegistryItem;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistryItem;
   
   public class ChatReportController implements class_13
   {
      
      private static const COLOR_ITEM_SELECTED:uint = 4282169599;
      
      private static const COLOR_ITEM_NORMAL:uint = 4293848814;
      
      private var _habboHelp:HabboHelp;
      
      private var _window:class_1812;
      
      private var var_3979:Function;
      
      private var var_374:int;
      
      private var var_150:int;
      
      private var _disposed:Boolean = false;
      
      public function ChatReportController(param1:HabboHelp, param2:Function)
      {
         super();
         _habboHelp = param1;
         var_3979 = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get reportedRoomId() : int
      {
         return var_374;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            closeWindow();
            _habboHelp = null;
            _disposed = true;
         }
      }
      
      public function show(param1:int, param2:int, param3:int) : void
      {
         _window = _habboHelp.getXmlWindow("chat_report") as class_1812;
         _window.procedure = var_3979;
         _window.center();
         var_150 = param2;
         var_374 = -1;
         if(param3 == 3)
         {
            deselectInstantMessageEntries();
            populateInstantMessageList(param1,param2);
         }
         else
         {
            deselectChatEntries();
            populateChatMessageList(param1,param2);
         }
      }
      
      public function closeWindow() : void
      {
         if(_habboHelp && _habboHelp.chatRegistry)
         {
            _habboHelp.chatRegistry.holdPurges = false;
         }
         if(_habboHelp && _habboHelp.instantMessageRegistry)
         {
            _habboHelp.instantMessageRegistry.holdPurges = false;
         }
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      public function collectSelectedEntries(param1:int, param2:int) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:Array = [];
         if(param1 == 3)
         {
            _loc6_ = param2 > 0 ? param2 : var_150;
            _loc4_ = _habboHelp.instantMessageRegistry.getItemsByUser(_loc6_);
            for each(var _loc5_ in _loc4_)
            {
               if(_loc5_.selected)
               {
                  if(_loc5_.userId < 0)
                  {
                     _loc3_.push(Number(_loc5_.userName.split(":")[0]));
                     _loc3_.push(_loc5_.text);
                  }
                  else
                  {
                     _loc3_.push(_loc5_.userId);
                     _loc3_.push(_loc5_.text);
                  }
               }
            }
         }
         else
         {
            for each(var _loc7_ in _habboHelp.chatRegistry.getItems())
            {
               if(_loc7_.selected)
               {
                  _loc3_.push(_loc7_.userId);
                  _loc3_.push(_loc7_.text);
               }
            }
         }
         return _loc3_;
      }
      
      private function populateInstantMessageList(param1:int, param2:int) : void
      {
         var _loc4_:class_1812 = null;
         var _loc7_:ITextWindow = null;
         var _loc8_:IItemListWindow = _window.findChildByName("room_items") as IItemListWindow;
         var _loc3_:class_1812 = _loc8_.getListItemAt(0) as class_1812;
         var _loc5_:class_1812 = _habboHelp.getXmlWindow("chat_report_item") as class_1812;
         _loc8_.removeListItems();
         var _loc6_:class_1812 = _loc3_.clone() as class_1812;
         _loc8_.addListItemAt(_loc6_,0);
         var _loc10_:IItemListWindow = _loc6_.findChildByName("chat_items") as IItemListWindow;
         _loc10_.removeListItems();
         _habboHelp.instantMessageRegistry.holdPurges = true;
         var _loc9_:Vector.<InstantMessageRegistryItem> = _habboHelp.instantMessageRegistry.getItemsByUser(param2);
         for each(var _loc11_ in _loc9_)
         {
            _loc4_ = _loc5_.clone() as class_1812;
            _loc7_ = _loc4_.getChildByName("text") as ITextWindow;
            if(_loc11_.userId < 0)
            {
               _loc7_.caption = _loc11_.userName.split(":")[1] + ": " + _loc11_.text;
            }
            else
            {
               _loc7_.caption = _loc11_.userName + ": " + _loc11_.text;
            }
            _loc4_.id = _loc11_.index;
            _loc4_.procedure = onInstantMessageEntryEvent;
            _loc4_.color = 4293848814;
            _loc10_.addListItem(_loc4_);
         }
      }
      
      private function populateChatMessageList(param1:int, param2:int) : void
      {
         var _loc9_:int = 0;
         var _loc4_:class_1812 = null;
         var _loc7_:ITextWindow = null;
         var _loc8_:IItemListWindow = _window.findChildByName("room_items") as IItemListWindow;
         var _loc3_:class_1812 = _loc8_.getListItemAt(0) as class_1812;
         var _loc5_:class_1812 = _habboHelp.getXmlWindow("chat_report_item") as class_1812;
         _loc8_.removeListItems();
         _habboHelp.chatRegistry.holdPurges = true;
         var _loc10_:Vector.<ChatRegistryItem> = param2 > 0 ? _habboHelp.chatRegistry.getItemsByUser(param2) : _habboHelp.chatRegistry.getItems();
         for each(var _loc12_ in _loc10_)
         {
            if(_loc12_.userId != param1)
            {
               if(_loc12_.roomId != _loc9_)
               {
                  _loc9_ = _loc12_.roomId;
                  var _loc6_:class_1812 = _loc3_.clone() as class_1812;
                  _loc6_.findChildByName("room_name").caption = "Room: " + _loc12_.roomName;
                  _loc8_.addListItemAt(null,0);
                  var _loc11_:IItemListWindow = null.findChildByName("chat_items") as IItemListWindow;
                  _loc11_.removeListItems();
               }
               _loc4_ = _loc5_.clone() as class_1812;
               _loc7_ = _loc4_.getChildByName("text") as ITextWindow;
               _loc7_.caption = _loc12_.userName + ": " + _loc12_.text;
               _loc4_.id = _loc12_.index;
               _loc4_.procedure = onChatEntryEvent;
               _loc4_.color = 4293848814;
               null.addListItem(_loc4_);
            }
         }
      }
      
      private function onChatEntryEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:ChatRegistryItem = _habboHelp.chatRegistry.getItem(param2.id);
            return;
         }
      }
      
      private function onInstantMessageEntryEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:InstantMessageRegistryItem = _habboHelp.instantMessageRegistry.getItem(var_150,param2.id);
            return;
         }
      }
      
      private function deselectInstantMessageEntries() : void
      {
         deselectAllEntries();
         refreshInstantMessageEntries();
      }
      
      private function deselectChatEntries() : void
      {
         deselectAllEntries();
         refreshChatEntries();
      }
      
      private function deselectAllEntries() : void
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
      
      private function refreshChatEntries() : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1812 = null;
         var _loc6_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc1_:class_1741 = null;
         var _loc7_:ChatRegistryItem = null;
         var _loc5_:IItemListWindow = _window.findChildByName("room_items") as IItemListWindow;
         _loc3_ = 0;
         while(_loc3_ < _loc5_.numListItems)
         {
            _loc2_ = _loc5_.getListItemAt(_loc3_) as class_1812;
            _loc6_ = _loc2_.findChildByName("chat_items") as IItemListWindow;
            _loc4_ = 0;
            while(_loc4_ < _loc6_.numListItems)
            {
               _loc1_ = _loc6_.getListItemAt(_loc4_) as class_1741;
               _loc7_ = _habboHelp.chatRegistry.getItem(_loc1_.id);
               if(_loc7_)
               {
                  _loc1_.color = _loc7_.selected ? 4282169599 : 4293848814;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function refreshInstantMessageEntries() : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1812 = null;
         var _loc6_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc1_:class_1741 = null;
         var _loc7_:InstantMessageRegistryItem = null;
         var _loc5_:IItemListWindow = _window.findChildByName("room_items") as IItemListWindow;
         _loc3_ = 0;
         while(_loc3_ < _loc5_.numListItems)
         {
            _loc2_ = _loc5_.getListItemAt(_loc3_) as class_1812;
            _loc6_ = _loc2_.findChildByName("chat_items") as IItemListWindow;
            _loc4_ = 0;
            while(_loc4_ < _loc6_.numListItems)
            {
               _loc1_ = _loc6_.getListItemAt(_loc4_) as class_1741;
               _loc7_ = _habboHelp.instantMessageRegistry.getItem(var_150,_loc1_.id);
               if(_loc7_)
               {
                  _loc1_.color = _loc7_.selected ? 4282169599 : 4293848814;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
   }
}

