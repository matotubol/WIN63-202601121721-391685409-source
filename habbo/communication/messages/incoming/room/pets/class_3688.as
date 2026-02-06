package com.sulake.habbo.communication.messages.incoming.room.pets
{
   [SecureSWF(rename="true")]
   public class class_3688
   {
      
      private var _stuffId:int;
      
      private var var_1015:int;
      
      private var var_2711:String;
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_4033:int;
      
      private var var_3966:Boolean;
      
      public function class_3688(param1:int, param2:int, param3:String, param4:int, param5:String, param6:int, param7:Boolean)
      {
         super();
         _stuffId = param1;
         var_1015 = param2;
         var_2711 = param3;
         var_1270 = param4;
         _userName = param5;
         var_4033 = param6;
         var_3966 = param7;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function get hasMutation() : Boolean
      {
         return var_3966;
      }
   }
}

