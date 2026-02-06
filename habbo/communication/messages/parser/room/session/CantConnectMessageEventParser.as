package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CantConnectMessageEventParser implements IMessageParser
   {
      
      public static const const_788:int = 1;
      
      public static const const_127:int = 2;
      
      public static const const_1061:int = 3;
      
      public static const const_600:int = 4;
      
      public static const const_150:int = 5;
      
      private var var_2352:int = 0;
      
      private var var_1900:String = "";
      
      public function CantConnectMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2352 = 0;
         var_1900 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2352 = param1.readInteger();
         if(var_2352 == 3)
         {
            var_1900 = param1.readString();
         }
         else
         {
            var_1900 = "";
         }
         return true;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
      
      public function get parameter() : String
      {
         return var_1900;
      }
   }
}

