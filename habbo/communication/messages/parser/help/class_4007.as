package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class class_4007 implements IMessageParser
   {
      
      private var var_1771:class_55;
      
      private var var_1732:class_55;
      
      public function class_4007()
      {
         super();
      }
      
      public function get urgentData() : class_55
      {
         return var_1771;
      }
      
      public function get normalData() : class_55
      {
         return var_1732;
      }
      
      public function flush() : Boolean
      {
         if(var_1771 != null)
         {
            var_1771.dispose();
         }
         var_1771 = null;
         if(var_1732 != null)
         {
            var_1732.dispose();
         }
         var_1732 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1771 = new class_55();
         var_1732 = new class_55();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         return true;
      }
   }
}

