package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetSpamWallPostItFinishEditingMessage extends RoomWidgetMessage
   {
      
      public static const SEND_POSTIT_DATA:String = "RWSWPFEE_SEND_POSTIT_DATA";
      
      private var var_315:int;
      
      private var var_559:String;
      
      private var _text:String;
      
      private var var_628:String;
      
      public function RoomWidgetSpamWallPostItFinishEditingMessage(param1:String, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1);
         var_315 = param2;
         var_559 = param3;
         _text = param4;
         var_628 = param5;
      }
      
      public function get location() : String
      {
         return var_559;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return var_628;
      }
   }
}

