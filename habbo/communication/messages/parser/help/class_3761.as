package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class class_3761 implements IMessageParser
   {
      
      private var var_2851:int;
      
      private var var_735:String;
      
      private var var_24:class_55;
      
      public function class_3761()
      {
         super();
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get data() : class_55
      {
         return var_24;
      }
      
      public function flush() : Boolean
      {
         if(var_24 != null)
         {
            var_24.dispose();
         }
         var_24 = null;
         var_2851 = -1;
         var_735 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_55();
         var_2851 = param1.readInteger();
         var_735 = param1.readString();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:int = param1.readInteger();
            var _loc5_:String = param1.readString();
            var_24.add(0,null);
            _loc4_++;
         }
         return true;
      }
   }
}

