package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class PetInventoryEventParser implements IMessageParser
   {
      
      protected var var_4631:int;
      
      protected var var_4298:int;
      
      private var var_1557:class_55;
      
      public function PetInventoryEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_1557)
         {
            var_1557.dispose();
            var_1557 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4631 = param1.readInteger();
         var_4298 = param1.readInteger();
         var_1557 = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:class_2838 = new class_2838(param1);
            var_1557.add(null.id,null);
            _loc3_++;
         }
         return true;
      }
      
      public function get petListFragment() : class_55
      {
         return var_1557;
      }
      
      public function get totalFragments() : int
      {
         return var_4631;
      }
      
      public function get fragmentNo() : int
      {
         return var_4298;
      }
   }
}

