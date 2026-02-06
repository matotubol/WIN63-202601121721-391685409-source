package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class BotInventoryEventParser implements IMessageParser
   {
      
      private var _items:class_55;
      
      public function BotInventoryEventParser()
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
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:class_3317 = new class_3317(param1);
            _items.add(null.id,null);
            _loc4_++;
         }
         return true;
      }
      
      public function get items() : class_55
      {
         return _items;
      }
   }
}

