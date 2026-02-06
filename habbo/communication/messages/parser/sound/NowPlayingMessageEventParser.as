package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NowPlayingMessageEventParser implements IMessageParser
   {
      
      private var var_3237:int;
      
      private var var_2728:int;
      
      private var var_3165:int;
      
      private var var_3314:int;
      
      private var var_3094:int;
      
      public function NowPlayingMessageEventParser()
      {
         super();
      }
      
      public function get currentSongId() : int
      {
         return var_3237;
      }
      
      public function get currentPosition() : int
      {
         return var_2728;
      }
      
      public function get nextSongId() : int
      {
         return var_3165;
      }
      
      public function get nextPosition() : int
      {
         return var_3314;
      }
      
      public function get syncCount() : int
      {
         return var_3094;
      }
      
      public function flush() : Boolean
      {
         var_3237 = -1;
         var_2728 = -1;
         var_3165 = -1;
         var_3314 = -1;
         var_3094 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3237 = param1.readInteger();
         var_2728 = param1.readInteger();
         var_3165 = param1.readInteger();
         var_3314 = param1.readInteger();
         var_3094 = param1.readInteger();
         return true;
      }
   }
}

