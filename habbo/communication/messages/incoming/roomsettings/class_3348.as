package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3348
   {
      
      public static const const_883:int = 0;
      
      public static const const_459:int = 1;
      
      public static const const_975:int = 2;
      
      public static const const_1014:int = 4;
      
      public static const const_238:int = 5;
      
      private var var_4692:int;
      
      private var var_5090:int;
      
      private var var_4598:int;
      
      public function class_3348(param1:IMessageDataWrapper)
      {
         super();
         var_4692 = param1.readInteger();
         var_5090 = param1.readInteger();
         var_4598 = param1.readInteger();
      }
      
      public function get whoCanMute() : int
      {
         return var_4692;
      }
      
      public function get whoCanKick() : int
      {
         return var_5090;
      }
      
      public function get whoCanBan() : int
      {
         return var_4598;
      }
   }
}

