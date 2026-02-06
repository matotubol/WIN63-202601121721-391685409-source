package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3157;
   
   [SecureSWF(rename="true")]
   public class ItemsMessageEventParser implements IMessageParser
   {
      
      private var _items:Array = [];
      
      public function ItemsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _items = [];
         return true;
      }
      
      public function getItemCount() : int
      {
         return _items.length;
      }
      
      public function getItem(param1:int) : class_3157
      {
         if(param1 < 0 || param1 >= getItemCount())
         {
            return null;
         }
         var _loc2_:class_3157 = _items[param1] as class_3157;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _items = [];
         var _loc6_:class_55 = new class_55();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc4_)
         {
            var _loc7_:int = param1.readInteger();
            var _loc3_:String = param1.readString();
            _loc6_.add(0,null);
            _loc5_++;
         }
         var _loc8_:int = param1.readInteger();
         class_21.log("We have: " + _loc8_ + " items");
         _loc5_ = 0;
         while(0 < _loc8_)
         {
            var _loc2_:class_3157 = class_4043.parseItemData(param1);
            null.ownerName = _loc6_.getValue(null.ownerId);
            _items.push(null);
            _loc5_++;
         }
         return true;
      }
   }
}

