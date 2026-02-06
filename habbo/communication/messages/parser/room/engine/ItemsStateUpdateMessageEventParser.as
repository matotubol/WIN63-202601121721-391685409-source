package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3649;
   
   [SecureSWF(rename="true")]
   public class ItemsStateUpdateMessageEventParser implements IMessageParser
   {
      
      private var _items:Array = [];
      
      public function ItemsStateUpdateMessageEventParser()
      {
         super();
      }
      
      public function get itemCount() : int
      {
         return _items.length;
      }
      
      public function getItemData(param1:int) : class_3649
      {
         if(param1 < 0 || param1 >= itemCount)
         {
            return null;
         }
         return _items[param1];
      }
      
      public function flush() : Boolean
      {
         _items = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readInteger();
            _loc2_ = param1.readString();
            _items.push(new class_3649(_loc5_,_loc2_));
            _loc4_++;
         }
         return true;
      }
   }
}

