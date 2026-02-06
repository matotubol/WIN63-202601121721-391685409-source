package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_3149;
   
   [SecureSWF(rename="true")]
   public class FurniListAddOrUpdateEventParser implements IMessageParser
   {
      
      protected var var_2268:Vector.<class_3149>;
      
      public function FurniListAddOrUpdateEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2268 = new Vector.<class_3149>(0);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2268.push(new class_3149(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2268 = null;
         return true;
      }
      
      public function getFurni() : Vector.<class_3149>
      {
         return var_2268;
      }
   }
}

