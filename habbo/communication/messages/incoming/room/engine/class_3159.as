package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class class_3159
   {
      
      private var var_2265:String;
      
      private var var_1331:String;
      
      public function class_3159(param1:String, param2:String)
      {
         super();
         var_2265 = param1;
         var_1331 = param2;
      }
      
      public function get actionType() : String
      {
         return var_2265;
      }
      
      public function get actionParameter() : String
      {
         return var_1331;
      }
      
      public function toString() : String
      {
         return var_2265 + ":" + var_1331;
      }
   }
}

