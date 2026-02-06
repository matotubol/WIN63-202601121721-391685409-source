package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class UnseenItemsEventParser implements IMessageParser
   {
      
      private var _items:class_55;
      
      public function UnseenItemsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_items)
         {
            _items.dispose();
            _items = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _items = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc5_:int = param1.readInteger();
            var _loc6_:Array = [];
            var _loc7_:int = param1.readInteger();
            var _loc4_:int = 0;
            _items.add(0,null);
            _loc3_++;
         }
         return true;
      }
      
      public function getCategories() : Array
      {
         return _items.getKeys();
      }
      
      public function getItemsByCategory(param1:int) : Array
      {
         return _items.getValue(param1);
      }
   }
}

