package com.sulake.habbo.communication.messages.parser.userclassification
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class UserClassificationMessageEventParser implements IMessageParser
   {
      
      private var var_1724:class_55;
      
      private var var_1546:class_55;
      
      public function UserClassificationMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_1724)
         {
            var_1724.dispose();
            var_1724 = null;
         }
         if(var_1546)
         {
            var_1546.dispose();
            var_1546 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var_1724 = new class_55();
         var_1546 = new class_55();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:int = param1.readInteger();
            var _loc6_:String = param1.readString();
            var _loc5_:String = param1.readString();
            var_1724.add(0,null);
            var_1546.add(0,null);
            _loc3_++;
         }
         return true;
      }
      
      public function get classifiedUsernameMap() : class_55
      {
         return var_1724;
      }
      
      public function get classifiedUserTypeMap() : class_55
      {
         return var_1546;
      }
   }
}

