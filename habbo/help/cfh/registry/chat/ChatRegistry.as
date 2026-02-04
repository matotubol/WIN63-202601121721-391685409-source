package com.sulake.habbo.help.cfh.registry.chat
{
   public class ChatRegistry
   {
      
      private static const MAX_ITEMS_TO_STORE:int = 120;
      
      private static const ITEMS_TO_PURGE:int = 20;
      
      private var _registry:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
      
      private var var_2349:uint = 0;
      
      private var var_4942:Boolean;
      
      public function ChatRegistry()
      {
         super();
      }
      
      public function hasContent() : Boolean
      {
         return _registry.length > 0;
      }
      
      public function hasContentWithoutChatFromUser(param1:int) : Boolean
      {
         return getItemsNotByUser(param1).length > 0;
      }
      
      public function getItems() : Vector.<ChatRegistryItem>
      {
         return _registry;
      }
      
      public function addItem(param1:int, param2:String, param3:int, param4:String, param5:String) : void
      {
         _registry.push(new ChatRegistryItem(var_2349++,param1,param2,param3,param4,param5));
         purgeRegistry();
      }
      
      public function set holdPurges(param1:Boolean) : void
      {
         var_4942 = param1;
      }
      
      private function purgeRegistry() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(var_4942)
         {
            return;
         }
         var _loc1_:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
         _loc3_ = 0;
         while(_loc3_ < _registry.length)
         {
            _loc4_ = new Date().time - _registry[_loc3_].chatTime.time;
            _loc2_ = _loc4_ / 65500;
            if(_loc2_ <= 15)
            {
               _loc1_.push(_registry[_loc3_]);
            }
            _loc3_++;
         }
         if(_loc1_.length > 120)
         {
            _loc1_.splice(0,_loc1_.length - (120 - 20));
         }
         _registry.splice(0,_registry.length);
         _registry = _registry.concat(_loc1_);
      }
      
      public function getItem(param1:uint) : ChatRegistryItem
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _registry.length)
         {
            if(_registry[_loc2_].index == param1)
            {
               return _registry[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getItemsByUser(param1:int) : Vector.<ChatRegistryItem>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
         _loc3_ = 0;
         while(_loc3_ < _registry.length)
         {
            if(_registry[_loc3_].userId == param1)
            {
               _loc2_.push(_registry[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getItemsNotByUser(param1:int) : Vector.<ChatRegistryItem>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<ChatRegistryItem> = new Vector.<ChatRegistryItem>(0);
         _loc3_ = 0;
         while(_loc3_ < _registry.length)
         {
            if(_registry[_loc3_].userId != param1)
            {
               _loc2_.push(_registry[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

