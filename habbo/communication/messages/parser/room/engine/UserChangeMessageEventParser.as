package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserChangeMessageEventParser implements IMessageParser
   {
      
      private var var_197:int;
      
      private var var_975:String;
      
      private var var_1309:String;
      
      private var _customInfo:String;
      
      private var _achievementScore:int;
      
      public function UserChangeMessageEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get sex() : String
      {
         return var_1309;
      }
      
      public function get customInfo() : String
      {
         return _customInfo;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function flush() : Boolean
      {
         var_197 = 0;
         var_975 = "";
         var_1309 = "";
         _customInfo = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_197 = param1.readInteger();
         var_975 = param1.readString();
         var_1309 = param1.readString();
         _customInfo = param1.readString();
         _achievementScore = param1.readInteger();
         if(var_1309)
         {
            var_1309 = var_1309.toUpperCase();
         }
         return true;
      }
   }
}

