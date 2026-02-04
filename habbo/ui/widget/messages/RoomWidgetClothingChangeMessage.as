package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage
   {
      
      public static const REQUEST_EDITOR:String = "RWCCM_REQUEST_EDITOR";
      
      private var var_315:int = 0;
      
      private var var_3874:int = 0;
      
      private var var_1951:int = 0;
      
      private var var_111:String = "";
      
      public function RoomWidgetClothingChangeMessage(param1:String, param2:String, param3:int, param4:int, param5:int)
      {
         super(param1);
         var_111 = param2;
         var_315 = param3;
         var_3874 = param4;
         var_1951 = param5;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectCategory() : int
      {
         return var_3874;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
   }
}

