package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OfficialSongIdMessageEventParser implements IMessageParser
   {
      
      private var var_2766:int;
      
      private var _officialSongId:String;
      
      public function OfficialSongIdMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2766 = 0;
         _officialSongId = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _officialSongId = param1.readString();
         var_2766 = param1.readInteger();
         return true;
      }
      
      public function get songId() : int
      {
         return var_2766;
      }
      
      public function get officialSongId() : String
      {
         return _officialSongId;
      }
   }
}

