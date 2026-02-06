package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsSaveErrorEventParser implements IMessageParser
   {
      
      public static const const_134:int = 1;
      
      public static const const_828:int = 2;
      
      public static const const_753:int = 3;
      
      public static const const_917:int = 4;
      
      public static const const_423:int = 5;
      
      public static const const_646:int = 6;
      
      public static const const_751:int = 7;
      
      public static const const_881:int = 8;
      
      public static const const_488:int = 9;
      
      public static const const_1057:int = 10;
      
      public static const const_380:int = 11;
      
      public static const const_465:int = 12;
      
      public static const const_1200:int = 13;
      
      private var var_1951:int;
      
      private var var_2759:int;
      
      private var var_3050:String;
      
      public function RoomSettingsSaveErrorEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1951 = param1.readInteger();
         var_2759 = param1.readInteger();
         var_3050 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
      
      public function get info() : String
      {
         return var_3050;
      }
   }
}

