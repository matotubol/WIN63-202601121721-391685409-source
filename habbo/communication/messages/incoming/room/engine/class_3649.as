package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class class_3649
   {
      
      private var var_197:int = 0;
      
      private var var_1859:String;
      
      private var var_61:int;
      
      public function class_3649(param1:int, param2:String)
      {
         super();
         var_197 = param1;
         var_1859 = param2;
         var _loc3_:Number = parseFloat(var_1859);
         if(!isNaN(_loc3_))
         {
            var_61 = int(var_1859);
         }
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get itemData() : String
      {
         return var_1859;
      }
      
      public function get state() : int
      {
         return var_61;
      }
   }
}

