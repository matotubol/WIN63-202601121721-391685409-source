package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_3149;
   
   [SecureSWF(rename="true")]
   public class FurniListEventParser implements IMessageParser
   {
      
      protected var var_4631:int;
      
      protected var var_4298:int;
      
      private var var_1490:class_55;
      
      public function FurniListEventParser()
      {
         super();
      }
      
      public function get totalFragments() : int
      {
         return var_4631;
      }
      
      public function get fragmentNo() : int
      {
         return var_4298;
      }
      
      public function get furniFragment() : class_55
      {
         return var_1490;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4631 = param1.readInteger();
         var_4298 = param1.readInteger();
         var_1490 = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:class_3149 = new class_3149(param1);
            var_1490.add(null.itemId,null);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         if(var_1490)
         {
            var_1490.dispose();
            var_1490 = null;
         }
         return true;
      }
   }
}

