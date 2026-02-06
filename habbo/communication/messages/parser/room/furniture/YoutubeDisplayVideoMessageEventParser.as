package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeDisplayVideoMessageEventParser implements IMessageParser
   {
      
      private var var_2536:int;
      
      private var var_4392:String;
      
      private var var_4010:int;
      
      private var var_4215:int;
      
      private var var_61:int;
      
      public function YoutubeDisplayVideoMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2536 = param1.readInteger();
         var_4392 = param1.readString();
         var_4010 = param1.readInteger();
         var_4215 = param1.readInteger();
         var_61 = param1.readInteger();
         return true;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get videoId() : String
      {
         return var_4392;
      }
      
      public function get startAtSeconds() : int
      {
         return var_4010;
      }
      
      public function get endAtSeconds() : int
      {
         return var_4215;
      }
      
      public function get state() : int
      {
         return var_61;
      }
   }
}

