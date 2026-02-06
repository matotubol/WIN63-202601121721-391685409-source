package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class BadgesEventParser implements IMessageParser
   {
      
      protected var var_4631:int;
      
      protected var var_4298:int;
      
      private var var_1612:class_55;
      
      public function BadgesEventParser()
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
      
      public function get currentFragment() : class_55
      {
         return var_1612;
      }
      
      public function flush() : Boolean
      {
         if(var_1612)
         {
            var_1612.dispose();
            var_1612 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4631 = param1.readInteger();
         var_4298 = param1.readInteger();
         var_1612 = new class_55();
         var _loc5_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc5_)
         {
            var _loc2_:int = param1.readInteger();
            var _loc3_:String = param1.readString();
            var_1612.add(null,0);
            _loc4_++;
         }
         return true;
      }
   }
}

